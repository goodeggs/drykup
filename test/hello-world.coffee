expect = require 'expect.js'
{head, title, body} = drykup = require('../drykup')()

describe 'hello world', ->
  it 'renders am html string from drykup tag functions', ->
    head ->                     
    	title 'Hello World'
    body ->

    expect(drykup.htmlOut).to.contain '<title>Hello World</title>'
