expect = require 'expect.js'
{div} = require '../tags'

describe 'Template with top level siblings', ->
  it 'returns only the last sibling', ->
    template = ->
      div 'a'
      div 'b'

    expect(template()).to.equal '<div>b</div>'
