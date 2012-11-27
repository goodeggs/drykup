expect = require 'expect.js'
{comment} = require '../tags'

describe 'Comments', ->
  it 'renders HTML <!--comments-->', ->
    template = -> comment "Comment"
    expect(template()).to.equal '<!--Comment-->'
