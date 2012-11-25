expect = require 'expect.js'
DryKup = require '../drykup'

describe 'text', ->
  it 'renders text verbatim', ->
    template = -> @text 'foobar'
    expect(DryKup.render template).to.equal 'foobar\n'
