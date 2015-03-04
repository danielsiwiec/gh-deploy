module.exports = (name, username, password) ->
  GithubApi = require 'github'

  github = new GithubApi
    version: '3.0.0'
    headers:
      'user-agent': 'gh-uploader'

  content = 'Hello world'

  toBase64 = (string) -> (new Buffer string).toString 'base64'
  errorToMessage = (error) -> JSON.parse(error.message).message

  github.authenticate
    type: 'basic'
    username: username
    password: password

  github.repos.create
    name: name
  , (err, res) ->
    if err
      console.log "Error creating repository: #{errorToMessage err}"
    else
      github.repos.createFile
        user: username
        repo: name
        branch: 'gh-pages'
        path: 'index.html'
        message: 'Add index.html'
        content: toBase64 content
      , (err, res) ->
          if err
            console.log "Error creating file: #{errorToMessage err}"
          else
            console.log "Repository created. Go to http://#{username}.github.io/#{name}"
