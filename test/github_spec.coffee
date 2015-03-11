assert = require "assert"

describe 'GitHub', ->
  it 'should return page URL for non-main repo', ->
    github = require('../github') 'repo', 'user', 'pass'
    assert.equal 'https://user.github.io/repo', github.pageUrl()

  it 'should return page URL for main repo', ->
    github = require('../github') 'user.github.io', 'user', 'pass'
    assert.equal 'https://user.github.io/', github.pageUrl()
