require 'colors'

module.exports = (name, username, password) ->
  GithubApi = require 'github'

  github = new GithubApi
    version: '3.0.0'
    headers:
      'user-agent': 'gh-uploader'

  content = 'Hello world'

  toBase64 = (string) -> (new Buffer string).toString 'base64'
  errorToMessage = (error) -> JSON.parse(error.message).message
  isMainGithubIo = -> return name is "#{username}.github.io"
  pageUrl = -> "https://#{username}.github.io/#{if isMainGithubIo() then '' else name}"
  repoUrl = -> "git@github.com:#{username}/#{name}.git"

  github.authenticate
    type: 'basic'
    username: username
    password: password

  github.repos.get
    user: username
    repo: name
  , (err,res) ->
    if res
      console.log "Repository #{name} already exists. Pick a different reponame".red
    else
      github.repos.create
        name: name
      , (err, res) ->
        if err
          console.log "Error creating repository: #{errorToMessage err}".red
        else
          github.repos.createFile
            user: username
            repo: name
            branch: if isMainGithubIo() then 'master' else 'gh-pages'
            path: 'index.html'
            message: 'Add index.html'
            content: toBase64 content
          , (err, res) ->
              if err
                console.log "Error creating file: #{errorToMessage err}".red
              else

                exec = require('child_process').exec

                child = exec "git clone #{repoUrl()}" , (error, stdout, stderr) ->
                  console.log stdout.toString()
                  console.log 'stderr: ' + stderr.toString()
                  console.log if error then "exec error: #{error}" else 'Repo cloned'.green

                console.log "Page created. You might need to refresh the page".green
                require('opn') pageUrl()
