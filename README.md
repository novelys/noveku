# Noveku

A collection of aliases we use when interacting with heroku.
This gem was inspired by [a collection of thoughtbot aliases](https://github.com/thoughtbot/dotfiles/commit/86494030441e88ef9c2e2ceaa00a4da82023e445).

## Prerequisites

Ruby 1.9+ only. This gem depends on no other gems. However :

* the presence of the command `heroku` (either via the gem, or the toolbelt) is assumed;
* the `hrs` tool assumes there is a heroku git remote named `staging`;
* the `hrp` tool assumes there is a heroku git remote named `production`.

## Installation

`gem install noveku`. Since it will not be part of your application, only of your workflow,
you should install it globally, not via bundler and your project's Gemfile.

## Usage

This gem exposes two executables : 

* `hrs` (heroku staging) : will execute the given commands for the `staging` remote
* `hrp` (heroku production) : will execute the given commands for the `production` remote

## Heroku commands

Supported commands and their equivalent : 

* `rake` : `heroku run rake ARGS --remove ENV`
* `console`: `heroku run console --remote ENV`
* `migrate`: `heroku run rake db:migrate --remote ENV && heroku restart --remote ENV`
* `tail`: `heroku logs --tail --remote ENV`

When giving a command that is not specifically supported, it will be passed to `heroku` : `heroku ARGS --remote ENV`.  
This makes several other commands available, such as `restart`, `releases`, `ps`, `open`...

## Advanced commands

* `mongodump`: Dumps the mongo database. Shortcut for both `mongolab_dump` and `mongohq_dump`: tries mongolab first, then mongohq.
* `mongolab_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOLAB_URI`.
* `mongohq_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOHQ_URL`.

Those commands put the dump in the `dump` dir, relatively to where you executed it.

Since the restoration of the database does not involve any interaction with heroku, it is out of the scope of this gem at the moment. However, it is pretty easy to integrate the commands above and the restoration in a rake task.

## Contributions

1. Check for open issues or open a fresh issue to start a discussion around a feature idea or a bug. In the first case, please include a use-case.
2. Fork the repository on Github, make a feature branch, work on this branch.
3. If necessary, write a test which shows that the bug was fixed or that the feature works as expected.
4. Send a pull request and annoy us until we notice it. :)

## Changelog

* `0.3`: Added `mongodump`, `mongolab_dump`, `mongohq_dump`.
* `0.2`: Added `rake` command.
* `0.1`: First version. Available commands : `console`, `migrate`, `tail`.
