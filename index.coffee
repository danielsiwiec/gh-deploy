#!/usr/bin/env coffee

meow = require 'meow'
app = require './gh-deploy'

cli = meow
  help: ['Usage:',
          'cli.coffee <reponame> <username> <password>',
          ''
        ].join '\n'

if cli.input.length is 3
  app cli.input[0], cli.input[1], cli.input[2]
else
  cli.showHelp()
