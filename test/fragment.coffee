expect = require 'expect.js'
{fragment, div} = require '../tags'

describe 'fragment', ->
  it 'collects nested tag function results', ->
    template = fragment (letters) ->
      for letter in letters
        div letter

    expect(template ['a', 'b', 'c'])
      .to.equal '<div>a</div><div>b</div><div>c</div>'
