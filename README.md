# Noveku

A collection of aliases we use when interacting with heroku.
This gem was inspired by [a collection of thoughtbot aliases](https://github.com/thoughtbot/dotfiles/commit/86494030441e88ef9c2e2ceaa00a4da82023e445).

## Prerequisites

This gem depends on no other gems. However :

* the presence of the command `heroku` (either via the gem, or the toolbelt) is assumed;
* the `hrs` tool assumes there is a heroku git remote named `staging`;
* the `hrp` tool assumes there is a heroku git remove named `production`.

## Installation

`gem install noveku`. Since it will not be part of your application, only of your workflow,
you should install it globally, not via bundler and your project's Gemfile.

## Usage

This gem exposes two executables : 

* `hrs` (heroku staging) : will execute the given commands for the `staging` remote
* `hrp` (heroku production) : will execute the given commands for the `production` remote

## Commands

Supported commands and their equivalent : 

* `console`: `heroku run console --remote ENV`
* `restart`: `heroku restart --remote ENV`
* `tail`: `heroku logs --tail --remote ENV`

## What's next

Commands that will be soon supported : `releases`, `maintenance`, commands for dumping mongolab database.

## Contributions

1. Check for open issues or open a fresh issue to start a discussion around a feature idea or a bug. In the first case, please include a use-case.
2. Fork the repository on Github, make a feature branch, work on this branch.
3. If necessary, write a test which shows that the bug was fixed or that the feature works as expected.
4. Send a pull request and annoy us until we notice it. :)

## Changelog

* `0.1`: First version. Available commands : `console`, `restart`, `tail`
