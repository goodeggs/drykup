expect = require 'expect.js'
{tag} = require '../tags'

describe 'custom tag', ->
  it 'should render', ->
    template = -> tag 'custom'
    expect(template()).to.equal '<custom></custom>'
  it 'should render with attributes', ->
    template = -> tag 'custom', foo: 'bar', ping: 'pong'
    expect(template()).to.equal '<custom foo="bar" ping="pong"></custom>'
  it 'should render with attributes and content', ->
    template = -> tag 'custom', foo: 'bar', ping: 'pong', 'zag'
    expect(template()).to.equal '<custom foo="bar" ping="pong">zag</custom>'
