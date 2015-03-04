#!/usr/bin/env coffee

console.log ['-------------------------------------------',
             '          GitHub Pages Deployer',
             'https://github.com/danielsiwiec/gh-deploy/',
             '-------------------------------------------',
             ''].join '\n'

meow = require 'meow'
app = require './gh-deploy'

cli = meow
  help: ['Usage:',
          'cli.coffee <reponame> <username>',
          ''
        ].join '\n'

if cli.input.length is not 2
  cli.showHelp()
else

require('read')
  prompt: 'GitHub password (not stored):'
  silent: true
  replace: '*'
  edit: true
, (err, password) ->
  if err
    console.log err
    exit 1
  else
    app cli.input[0], cli.input[1], password
