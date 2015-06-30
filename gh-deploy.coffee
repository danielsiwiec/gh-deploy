require 'colors'

module.exports = (reponame, username, password) ->

  github = require('./github.coffee') reponame, username, password

  errorToMessage = (error) -> JSON.parse(error.message).message

  doWhenPageReady = (url,callback) ->
      require('request')
        url: url
        headers:
          'Cache-Control': 'no-cache'
          'Pragma': 'no-cache'
      .on 'response', (response) ->
        if response.statusCode is 200
          callback url
        else
          setTimeout(->
            doWhenPageReady(url, callback)
          , 500)
      .on 'error', (error) ->
        console.log error

  github.getRepo (err,res) ->
    if res
      console.log "Repository #{reponame} already exists. Pick a different reponame".red
    else
      github.createRepo()
      .then -> github.addIndexPage()
      .then -> github.clone()
      .then -> console.log 'Repo cloned'.green
      .then ->
          console.log "Page created. Waiting for page to be ready...".green
          doWhenPageReady github.pageUrl(), require('opn')
      .catch (err) -> console.log "Error: #{err}"
      .done()
