expect = require 'expect.js'
DryKup = require '../drykup'

describe 'IE conditionals', ->
  it 'renders conditional comments', ->
    template = -> 
      @ie 'gte IE8', -> 
        @link href: 'ie.css', rel: 'stylesheet'
    expect(DryKup.render template).to.equal '<!--[if gte IE8]>\n  <link href="ie.css" rel="stylesheet" />\n<![endif]-->\n'
