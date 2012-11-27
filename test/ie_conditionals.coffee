expect = require 'expect.js'
{ie, link} = require '../tags'

describe 'IE conditionals', ->
  it 'renders conditional comments', ->
    template = -> 
      ie 'gte IE8', -> 
        link href: 'ie.css', rel: 'stylesheet'
    expect(template()).to.equal '<!--[if gte IE8]><link href="ie.css" rel="stylesheet" /><![endif]-->'
