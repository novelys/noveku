# Noveku

A console utility easing up interactions with heroku when you have several heroku apps for one project (most common use case: production and staging environments for a webapp).
This gem was inspired by [a collection of thoughtbot aliases](https://github.com/thoughtbot/dotfiles/commit/86494030441e88ef9c2e2ceaa00a4da82023e445).

## Prerequisites

Ruby 1.9+ only. This gem depends on novelys/gomon. However, the presence of the commands `heroku` and `git` is assumed.

## Installation

`gem install noveku`

## Usage

This gem is developed with Rails 3+ in mind.

However, it should be suited to any project with a notion of "app environment",
with different heroku apps for these environments.
It is assumed that your apps are using the cedar stack.
While some commands might work for other stacks, this is purely coincidental.

`noveku ENV COMMAND` means that `COMMAND` will be executed for the heroku app with the remote named `heroku-ENV`.
In the case of the commands `push` and `deploy`, the local branch used as source is `ENV`.
Please read the next two paragraphs for detailed explications.

### Conventions

This gem makes a few assumptions about how your branches and remotes are named.
This is *not* configurable, and there is no plans to change this.

* `origin` is the main git remote, pointing towards GitHub, BitBucket, or any other server.
* if you have a branch named `novelys`, the heroku git remote corresponding this branch is assumed to be `heroku-novelys`.

Our git flow at Novelys is pretty straightforward :
the branch `master` is the current version of the app;
`staging` is the pre-production version;
`production` the production one.

This translates to two heroku apps (the name of the apps does not matter), and the remotes named `heroku-staging` and `heroku-master` :

    [remote "heroku-production"]
      url = git@heroku.com:sampleapp.git
      fetch = +refs/heads/*:refs/remotes/production/*
    [remote "heroku-staging"]
      url = git@heroku.com:sampleapp-preprod.git
      fetch = +refs/heads/*:refs/remotes/staging/*

### Interface

Considering what is written above :

`noveku ENV COMMAND`: will execute the given `COMMAND` in the context of the `ENV` local branch and `heroku-ENV` heroku git remote.

## Commands

When giving a command that has no specific support, it will be proxied to `heroku` : `heroku ARGS --remote ENV`.  
This makes several other commands available, such as `restart`, `releases`, `ps`, `open`...

### Common options

Exception made of mongodb related commands, they all accept the following options:

* `--dry-run`: only prints the git command that is going to be executed, without executing it;
* `--verbose`: prints the git command that is going to be executed, and then execute it.

### Heroku

Supported commands and their equivalent :

* `rake ARGS` : `heroku run rake ARGS --remove ENV`
* `console`: `heroku run console --remote ENV`
* `migrate`: `heroku run rake db:migrate --remote ENV && heroku restart --remote ENV`
* `tail`: `heroku logs --tail --remote ENV`
* `create APP_NAME ENV [ADDONS...]`: creates `APP_NAME` bound to the remote `heroku-ENV`. Each listed addon will be added right away. If any part of the subcommand fails, the remaining will not be executed.

### Git

Those commands are shortcuts for other git commands.

* `push`: `git push origin ENV`, push your changes in your local branch to the `origin` remote.
* `deploy`: `git push heroku-ENV ENV:master`, push your changes in your local branch to the heroku remote.

### MongoDB

* `mongodump`: Dumps the mongo database. Shortcut for both `mongolab_dump` and `mongohq_dump`: tries mongolab first, then mongohq.
* `mongolab_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOLAB_URI`.
* `mongohq_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOHQ_URL`.

Those commands put the dump in the `dump` dir, relatively to where you executed it.

Since the restoration of the database does not involve any interaction with heroku, it is out of the scope of this gem at the moment. However, this gem depends on novelys/gomon, which includes a class wrapping mongodump/restore, making it very easy to use in a rake task.

## What's next

Better test coverage. This will be bumped to `1.0.0` once this is done and after using the gem in our daily flow for a few weeks.

## Contributions

1. Check for open issues or open a fresh issue to start a discussion around a feature idea or a bug. In the first case, please include a use-case.
2. Fork the repository on Github, make a feature branch, work on this branch.
3. If necessary, write a test which shows that the bug was fixed or that the feature works as expected.
4. Send a pull request and annoy us until we notice it. :)

## Changelog

* `0.8`: Removes `clone` (duplicate of `heroku fork`)
* `0.7`: Adds `create` and `clone`.
* `0.6`: Adds `deploy` and `push`; assumes heroku remotes are prefixed with `heroku-`; enhanced README; internal refactoring.
* `0.5`: Test coverage, check the presence of environment & that it matches a heroku app, that pwd is a heroku app, the presence of mongohq/lab uri.
* `0.4`: Require `gomon` for mongodump, changed executable names, internal refactoring.
* `0.3`: Added `mongodump`, `mongolab_dump`, `mongohq_dump`.
* `0.2`: Added `rake` command.
* `0.1`: First version. Available commands : `console`, `migrate`, `tail`.
