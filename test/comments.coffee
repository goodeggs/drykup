expect = require 'expect.js'
DryKup = require '../drykup'

describe 'Comments', ->
  it 'renders HTML <!--comments-->', ->
    template = -> @comment "Comment"
    expect(DryKup.render template).to.equal '<!--Comment-->\n'
