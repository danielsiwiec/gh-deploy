GithubApi = require 'github'

github = new GithubApi
  version: '3.0.0'
  headers:
    'user-agent': 'gh-uploader'

content = '<b>Hello world</b>'

toBase64 = (string) -> (new Buffer string).toString 'base64'

module.exports = (reponame, username, password) ->

  isMainGithubIo = -> return reponame is "#{username}.github.io"
  repoUrl = -> "git@github.com:#{username}/#{reponame}.git"

  github.authenticate
      type: 'basic'
      username: username
      password: password

  pageUrl: ->
    "https://#{username}.github.io/#{if isMainGithubIo reponame then '' else reponame}"

  getRepo: (callback) ->
    github.repos.get
      user: username
      repo: reponame
    , callback

  createRepo: (callback) ->
    github.repos.create
      name: reponame
    , callback

  addIndexPage: (callback) ->
    github.repos.createFile
      user: username
      repo: reponame
      branch: if isMainGithubIo username, reponame then 'master' else 'gh-pages'
      path: 'index.html'
      message: 'Add index.html'
      content: toBase64 content
    , callback

  clone: (callback) ->
    exec = require('child_process').exec
    child = exec "git clone #{repoUrl()}", callback
