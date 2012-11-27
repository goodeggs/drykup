expect = require 'expect.js'
{cede, div, p, strong, a} = require '../tags'

describe 'cede', ->
  describe 'nested in a template', ->
    it 'returns the nested template without clobbering the parent result', ->
      template = -> 
        p "This text could use #{cede -> strong -> a href: '/', 'a link'}."
      expect(template()).to.equal '<p>This text could use <strong><a href="/">a link</a></strong>.</p>'
