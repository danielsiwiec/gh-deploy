meow = require 'meow'
app = require './gh-deploy'

cli = meow
  help: ['Usage',
          'cli.coffee name password'
        ].join '\n'

app cli.input[0], cli.input[1], cli.input[2]
