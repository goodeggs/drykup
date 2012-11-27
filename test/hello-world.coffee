expect = require 'expect.js'
{fragment, head, title, body} = require '../tags'

describe 'hello world', ->
  it 'renders am html string from drykup tag functions', ->
    template = fragment ->
      head ->                     
      	title 'Hello World'
      body ->

    expect(template()).to.contain '<title>Hello World</title>'
