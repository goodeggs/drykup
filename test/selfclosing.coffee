expect = require 'expect.js'
DryKup = require '../drykup'

describe 'Self Closing Tags', ->
  describe '<img />', ->
    it 'should render', ->
      template = -> @img()
      expect(DryKup.render template).to.equal '<img />\n'
    it 'should render with attributes', ->
      template = -> @img src: 'http://foo.jpg.to'
      expect(DryKup.render template).to.equal '<img src="http://foo.jpg.to" />\n'
  describe '<br />', ->
    it 'should render', ->
      template = -> @br()
      expect(DryKup.render template).to.equal '<br />\n'
  describe '<link />', ->
    it 'should render with attributes', ->
      template = -> @link href: '/foo.css', rel: 'stylesheet'
      expect(DryKup.render template).to.equal '<link href="/foo.css" rel="stylesheet" />\n'
