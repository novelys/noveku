# Noveku

A collection of aliases we use when interacting with heroku.
This gem was inspired by [a collection of thoughtbot aliases](https://github.com/thoughtbot/dotfiles/commit/86494030441e88ef9c2e2ceaa00a4da82023e445).

## Prerequisites

This gem depends on novelys/gomon. However, the presence of the command `heroku` (either via the gem, or the toolbelt) is assumed

## Installation

`gem install noveku`. Since it will not be part of your application, only of your workflow,
you should install it globally, not via bundler and your project's Gemfile.

## Usage

`noveku [ENV] commands...`: will execute the given commands for the `staging` remote.

We strongly suggest adding shell aliases for convenience :

```shell
alias nvp='noveku production'
alias nvs='noveku staging'
```

## Heroku commands

Supported commands and their equivalent : 

* `rake` : `heroku run rake ARGS --remove ENV`
* `console`: `heroku run console --remote ENV`
* `migrate`: `heroku run rake db:migrate --remote ENV && heroku restart --remote ENV`
* `tail`: `heroku logs --tail --remote ENV`

When giving a command that is not specifically supported, it will be passed to `heroku` : `heroku ARGS --remote ENV`.  
This makes several other commands available, such as `restart`, `releases`, ...

## Advanced commands

* `mongodump`: Dumps the mongo database. Shortcut for both `mongolab_dump` and `mongohq_dump`: tries mongolab first, then mongohq.
* `mongolab_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOLAB_URI`.
* `mongohq_dump`: Dumps the mongo database. Look in the config keys of `ENV` to find `MONGOHQ_URL`.

Those commands puts the dump in the `dump` dir, relatively to where you executed it.

Since the restoration of the database does not involve any interaction with heroku, it is out of the scope of this gem at the moment. However, this gem depends on novelys/gomon, which includes a class wrapping mongodump/restore, making it very easy to use in a rake task.

## Contributions

1. Check for open issues or open a fresh issue to start a discussion around a feature idea or a bug. In the first case, please include a use-case.
2. Fork the repository on Github, make a feature branch, work on this branch.
3. If necessary, write a test which shows that the bug was fixed or that the feature works as expected.
4. Send a pull request and annoy us until we notice it. :)

## Changelog

* `0.4`: Require `gomon` for mongodump, changed executable names, internal refactoring.
* `0.3`: Added `mongodump`, `mongolab_dump`, `mongohq_dump`.
* `0.2`: Added `rake` command.
* `0.1`: First version. Available commands : `console`, `migrate`, `tail`.
