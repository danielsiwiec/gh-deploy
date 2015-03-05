#!/usr/bin/env coffee

console.log ['-------------------------------------------',
             '          GitHub Pages Deployer',
             'https://github.com/danielsiwiec/gh-deploy/',
             '-------------------------------------------',
             ''].join '\n'

app = require './gh-deploy'

read = require('read')

read
  prompt: 'GitHub username:'
, (err, username) ->
  read
    prompt: 'GitHub password (not stored):'
    silent: true
    replace: '*'
    edit: true
  , (err, password) ->
    read
      prompt: 'Page name (defines page URL):'
      default: "#{username}.github.io"
    , (err, pageName) ->
      app pageName, username, password
