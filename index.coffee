#!/usr/bin/env coffee

console.log ['-------------------------------------------',
             '          GitHub Pages Deployer',
             'https://github.com/danielsiwiec/gh-deploy/',
             '-------------------------------------------',
             ''].join '\n'

app = require './gh-deploy'
read = require 'read'
q = require 'q'

reader = q.denodeify read

username = ''
password = ''

reader
  prompt: 'GitHub username:'
.then (input) -> username = input[0]
.then -> reader
  prompt: 'GitHub password (not stored):'
  silent: true
  replace: '*'
  edit: true
.then (input) -> password = input[0]
.then -> reader
  prompt: 'Page name (defines page URL):'
  default: "#{username}.github.io"
.then (input) -> app input[0], username, password
.done()
