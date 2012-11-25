expect = require 'expect.js'
DryKup = require '../drykup'

describe 'Attributes', ->

  describe 'with a hash', ->
    it 'renders the corresponding HTML attributes', ->
      template = -> @a href: '/', title: 'Home'
      expect(DryKup.render template).to.equal '<a href="/" title="Home"></a>\n'

  describe 'Boolean true value', ->
    it 'is replaced with the attribute name.  Useful for attributes like disabled', ->
      template = -> @br foo: yes, bar: true
      expect(DryKup.render template).to.equal '<br foo="foo" bar="bar" />\n'

  describe 'Boolean false value', ->
    it 'is omitted', ->
      template = -> @br foo: no, bar: false
      expect(DryKup.render template).to.equal '<br />\n'

  describe 'null or undefined value', ->
    it 'is omitted', ->
      template = -> @br foo: null, bar: undefined
      expect(DryKup.render template).to.equal '<br />\n'

  describe 'string value', ->
    it 'is used verbatim', ->
      template = -> @br foo: 'true', bar: 'str'
      expect(DryKup.render template).to.equal '<br foo="true" bar="str" />\n'

  describe 'number value', ->
    it 'is stringified', ->
      template = -> @br foo: 2, bar: 15.55
      expect(DryKup.render template).to.equal '<br foo="2" bar="15.55" />\n'

  describe 'array value', ->
    it 'is comma separated', ->
      template = -> @br foo: [1, 2, 3]
      expect(DryKup.render template).to.equal '<br foo="1,2,3" />\n'
