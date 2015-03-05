require 'colors'

module.exports = (reponame, username, password) ->

  github = require('./github.coffee') reponame, username, password

  errorToMessage = (error) -> JSON.parse(error.message).message

  github.getRepo (err,res) ->
    if res
      console.log "Repository #{reponame} already exists. Pick a different reponame".red
    else
      github.createRepo (err, res) ->
        if err
          console.log "Error creating repository: #{errorToMessage err}".red
        else
          github.addIndexPage (err, res) ->
              if err
                console.log "Error creating file: #{errorToMessage err}".red
              else
                github.clone (error) ->
                  console.log if error then "exec error: #{error}" else 'Repo cloned'.green

                console.log "Page created. You might need to refresh the page".green
                require('opn') github.pageUrl()
