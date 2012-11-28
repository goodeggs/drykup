expect = require 'expect.js'
{render, head, title, body} = require '../tags'

describe 'hello world', ->
  it 'renders am html string from drykup tag functions', ->
    template = ->
      head ->                     
      	title 'Hello World'
      body ->

    expect(render template).to.contain '<title>Hello World</title>'
