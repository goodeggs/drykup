expect = require 'expect.js'
DryKup = require '../drykup'

describe 'include', ->
  it 'renders another template in the same output stream', ->
    user = 
      first: 'Huevo'
      last: 'Bueno'

    nameHelper = ({user}) ->
      @p "#{user.first} #{user.last}"

    template = ({user}) ->
      @div ->
        @include nameHelper, {user}

    expect(DryKup.render template, {user}).to.equal '<div><p>Huevo Bueno</p></div>'
