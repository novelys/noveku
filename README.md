# Noveku

A collection of aliases we use when interacting with heroku.
This gem was inspired by [a collection of thoughtbot aliases](https://github.com/thoughtbot/dotfiles/commit/86494030441e88ef9c2e2ceaa00a4da82023e445).

## Prerequisites

Ruby 1.9+ only. This gem depends on novelys/gomon. However, the presence of the command `heroku` (either via the gem, or the toolbelt) is assumed

## Installation

`gem install noveku`. Since it will not be part of your application, only of your workflow,
you should install it globally, not via bundler and your project's Gemfile.

## Usage

This gem is developed with Rails 3+ in mind. However, it should be suited to any project with a notion of "app environment", with different heroku apps for these environments.

`noveku production COMMAND` translate `COMMAND` in the context of the heroku remote `heroku-production`. When pushing/deploying, the local source branche is `production`. Please read the next two paragraphs for more detailed explications.

### Conventions

This gem makes a few assumptions about how your branches and remotes are named.
This is *not* configurable, and that there is no plans to change this.

* `origin` is the main git remote, pointing towards github, bitbucket, or any other server.
* if you have a branch named `novelys`, the heroku git remote corresponding this branch is assumed to be `heroku-novelys`.

Our git flow at Novelys is pretty straightforward : the branch `master` is the current version of the app; `staging` is the pre-production version; `production` the production one.

This translates to two heroku apps (the name of the apps does not matter), and the remotes named `heroku-staging` and `heroku-master` :

    [remote "heroku-production"]
      url = git@heroku.com:sampleapp.git
      fetch = +refs/heads/*:refs/remotes/production/*
    [remote "heroky-staging"]
      url = git@heroku.com:sampleapp-preprod.git
      fetch = +refs/heads/*:refs/remotes/staging/*

### Interface

Considering what is written above :

`noveku ENV COMMAND`: will execute the given `COMMAND` in the context of the `ENV` local branch and `heroku-ENV` heroku git remote.

## Heroku commands

Supported commands and their equivalent : 

* `rake` : `heroku run rake ARGS --remove ENV`
* `console`: `heroku run console --remote ENV`
* `migrate`: `heroku run rake db:migrate --remote ENV && heroku restart --remote ENV`
* `tail`: `heroku logs --tail --remote ENV`

When giving a command that is not specifically supported, it will be passed to `heroku` : `heroku ARGS --remote ENV`.  
This makes several other commands available, such as `restart`, `releases`, `ps`, `open`...

## Advanced commands

### Git

Those commands are shortcuts for other git commands.

* `push`: Push your changes in your local branch to the `origin` remote.
* `deploy`: Push your changes in your local branch to the heroku remote.

They accept the following options:

* `--dry-run`: only prints the git command that is going to be executed, without executing it;
* `--verbose`: prints the git command that is going to be executed, and then execute it.

### MongoDB

* `mongodump`: Dumps the mongo database. Shortcut for both `mongolab_dump` and `mongohq_dump`: tries mongolab first, then mongohq.
* `mongolab_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOLAB_URI`.
* `mongohq_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOHQ_URL`.

Those commands put the dump in the `dump` dir, relatively to where you executed it.

Since the restoration of the database does not involve any interaction with heroku, it is out of the scope of this gem at the moment. However, this gem depends on novelys/gomon, which includes a class wrapping mongodump/restore, making it very easy to use in a rake task.

## What's next

I plan on adding a command allowing you to create a heroku app, setup your addons, update your git config, create a local branch if needed.. all that in one step. We're still thinking about what the command api will look like. This will probably be the last feature before tagging 1.0.0.

## Contributions

1. Check for open issues or open a fresh issue to start a discussion around a feature idea or a bug. In the first case, please include a use-case.
2. Fork the repository on Github, make a feature branch, work on this branch.
3. If necessary, write a test which shows that the bug was fixed or that the feature works as expected.
4. Send a pull request and annoy us until we notice it. :)

## Changelog

* `0.6`: Adds `deploy` and `push`; assumes heroku remotes are prefixed with `heroku-`; enhanced README; internal refactoring.
* `0.5`: Test coverage, check the presence of environment & that it matches a heroku app, that pwd is a heroku app, the presence of mongohq/lab uri.
* `0.4`: Require `gomon` for mongodump, changed executable names, internal refactoring.
* `0.3`: Added `mongodump`, `mongolab_dump`, `mongohq_dump`.
* `0.2`: Added `rake` command.
* `0.1`: First version. Available commands : `console`, `migrate`, `tail`.
