expect = require 'expect.js'
{render, a, br} = require '../tags'

describe 'Attributes', ->

  describe 'with a hash', ->
    it 'renders the corresponding HTML attributes', ->
      template = -> a href: '/', title: 'Home'
      expect(render template).to.equal '<a href="/" title="Home"></a>'

  describe 'Boolean true value', ->
    it 'is replaced with the attribute name.  Useful for attributes like disabled', ->
      template = -> br foo: yes, bar: true
      expect(render template).to.equal '<br foo="foo" bar="bar" />'

  describe 'Boolean false value', ->
    it 'is omitted', ->
      template = -> br foo: no, bar: false
      expect(render template).to.equal '<br />'

  describe 'null or undefined value', ->
    it 'is omitted', ->
      template = -> br foo: null, bar: undefined
      expect(render template).to.equal '<br />'

  describe 'string value', ->
    it 'is used verbatim', ->
      template = -> br foo: 'true', bar: 'str'
      expect(render template).to.equal '<br foo="true" bar="str" />'

  describe 'number value', ->
    it 'is stringified', ->
      template = -> br foo: 2, bar: 15.55
      expect(render template).to.equal '<br foo="2" bar="15.55" />'

  describe 'array value', ->
    it 'is comma separated', ->
      template = -> br foo: [1, 2, 3]
      expect(render template).to.equal '<br foo="1,2,3" />'
