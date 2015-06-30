GithubApi = require 'github'
q = require 'q'

github = new GithubApi
  version: '3.0.0'
  headers:
    'user-agent': 'gh-uploader'

content = '<b>Hello world</b>'

toBase64 = (string) -> (new Buffer string).toString 'base64'

module.exports = (reponame, username, password) ->

  isMainGithubIo = -> return reponame is "#{username}.github.io"
  repoUrl = -> "git@github.com:#{username}/#{reponame}.git"

  branch = -> if isMainGithubIo username, reponame then 'master' else 'gh-pages'

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

  createRepo: ->
    q.denodeify(github.repos.create)
      name: reponame

  addIndexPage: ->
    q.denodeify(github.repos.createFile)
      user: username
      repo: reponame
      branch: branch()
      path: 'index.html'
      message: 'Add index.html'
      content: toBase64 content

  clone: ->
    exec = require('child_process').exec
    q.denodeify(exec "git clone #{repoUrl()}")
