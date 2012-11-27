expect = require 'expect.js'
{text} = require '../tags'

describe 'text', ->
  it 'renders text verbatim', ->
    expect(text 'foobar').to.equal 'foobar'
