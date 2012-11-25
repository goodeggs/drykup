expect = require 'expect.js'
DryKup = require '../drykup'

describe 'custom tag', ->
  it 'should render', ->
    template = -> @tag 'custom'
    expect(DryKup.render template).to.equal '<custom></custom>'
  it 'should render with attributes', ->
    template = -> @tag 'custom', foo: 'bar', ping: 'pong'
    expect(DryKup.render template).to.equal '<custom foo="bar" ping="pong"></custom>'
  it 'should render with attributes and content', ->
    template = -> @tag 'custom', foo: 'bar', ping: 'pong', 'zag'
    expect(DryKup.render template).to.equal '<custom foo="bar" ping="pong">zag</custom>'
