expect = require 'expect.js'
{img, br, link} = require '../tags'

describe 'Self Closing Tags', ->
  describe '<img />', ->
    it 'should render', ->
      expect(img()).to.equal '<img />'
    it 'should render with attributes', ->
      expect(img src: 'http://foo.jpg.to')
        .to.equal '<img src="http://foo.jpg.to" />'
  describe '<br />', ->
    it 'should render', ->
      expect(br()).to.equal '<br />'
  describe '<link />', ->
    it 'should render with attributes', ->
      expect(link href: '/foo.css', rel: 'stylesheet')
        .to.equal '<link href="/foo.css" rel="stylesheet" />'
