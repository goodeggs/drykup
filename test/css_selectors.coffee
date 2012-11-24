expect = require 'expect.js'
Drykup = require '../drykup'

describe 'CSS Selectors', ->
  drykup = null
  {div, img} = {}

  beforeEach ->
    {div, img} = drykup = Drykup()

  describe 'id selector', ->
    it 'sets the id attribute', ->
      div '#myid', 'foo'
      expect(drykup.htmlOut).to.equal '<div id="myid">foo</div>\n'

  describe 'one class selector', ->
    it 'adds an html class', ->
      div '.myclass', 'foo'
      expect(drykup.htmlOut).to.equal '<div class="myclass">foo</div>\n'

  describe 'multi-class selector', ->
    it 'adds all the classes', ->
      div '.myclass.myclass2.myclass3', 'foo'
      expect(drykup.htmlOut).to.equal '<div class="myclass myclass2 myclass3">foo</div>\n'

  describe 'wihout contents', ->
    it 'still adds attributes', ->
      img '#myid.myclass', src: '/pic.png'
      expect(drykup.htmlOut).to.equal '<img id="myid" class="myclass" src="/pic.png" />\n'
