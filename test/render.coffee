expect = require 'expect.js'
DryKup = require '../drykup'

describe 'render', ->
  describe 'given a template function and some data', ->
    {template, data} = {}
    beforeEach ->
      data =
        name: 'foo'
      template = ({name}) -> @div name

    it 'returns the rendered HTML string', ->
      expect(DryKup.render template, data).to.equal '<div>foo</div>\n'

  describe 'nested in a template', ->
    it 'renders the nested template without clobbering the parent result', ->
      template = -> 
        {p, render, strong, a} = @
        p "This text could use #{render -> strong -> a href: '/', 'a link'}."
      expect(DryKup.render template).to.equal '<p>This text could use <strong>\n  <a href="/">a link  </a>\n</strong>\n.</p>\n'
