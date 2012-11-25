expect = require 'expect.js'
DryKup = require '../drykup'

describe 'Template convention candidates', ->
  {drykup} = {}

  render = (template) ->
    out = drykup.render template, user:
      first: 'Huevo'
      last: 'Bueno'
    expect(out).to.contain '<p>Huevo</p>'

  describe 'gratuitous @', ->
    beforeEach -> 
      drykup = new DryKup()

    it 'works', ->
      render ({user}) ->
        @div '.header', ->
          @a href: '/logout', 'Log out'
        @div '.body', ->
          @p user.first
          @p user.last

  describe 'destructuring assignment', ->
    beforeEach -> 
      drykup = new DryKup()
      
    it 'works', ->
      render ({user}) ->
        {div, a, p} = @

        div '.header', ->
          a href: '/logout', 'Log out'
        div '.body', ->
          p user.first
          p user.last

  describe 'DryKup singleton', ->
    {div, p, a, drykup} = {} 

    before ->
      {div, p, a} = drykup = DryKup()

    afterEach ->
      drykup.resetHtml()

    it 'works', ->
      render ({user}) ->
        div '.header', ->
          a href: '/logout', 'Log out'
        div '.body', ->
          p user.first
          p user.last

