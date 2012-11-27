expect = require 'expect.js'
{doctype} = require '../tags'

describe 'doctype', ->
  it 'default should render html5 doctype', ->
    template = -> doctype()
    expect(template()).to.equal '<!DOCTYPE html>'
  it 'xml should render xml header', ->
    template = -> doctype 'xml'
    expect(template()).to.equal '<?xml version="1.0" encoding="utf-8" ?>'
  it '5 should render html 5 doctype', ->
    template = -> doctype 5
    expect(template()).to.equal '<!DOCTYPE html>'
  it 'transitional should render transitional doctype', ->
    template = -> doctype 'transitional'
    expect(template()).to.equal '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
