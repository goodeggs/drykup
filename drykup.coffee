###
  File: drykup.coffee
  Author: Mark Hahn
  DryCup is a CoffeeScript html generator compatible with CoffeeKup but without the magic.
  DryKup is open-sourced via the MIT license.
  See https://github.com/mark-hahn/drykup
###

# ------------------- Constants stolen from coffeeKup (Release 0.3.2) ---------------------
# ----------------------------- See KOFFEECUP-LICENSE file --------------------------------

# Values available to the `doctype` function inside a template.
# Ex.: `doctype 'strict'`
doctypes =
  'default': '<!DOCTYPE html>'
  '5': '<!DOCTYPE html>'
  'xml': '<?xml version="1.0" encoding="utf-8" ?>'
  'transitional': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
  'strict': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
  'frameset': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">'
  '1.1': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">'
  'basic': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">'
  'mobile': '<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">'
  'ce': '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "ce-html-1.0-transitional.dtd">'

# Private HTML element reference.
# Please mind the gap (1 space at the beginning of each subsequent line).
elements =
  # Valid HTML 5 elements requiring a closing tag.
  # Note: the `var` element is out for obvious reasons, please use `tag 'var'`.
  regular: 'a abbr address article aside audio b bdi bdo blockquote body button
 canvas caption cite code colgroup datalist dd del details dfn div dl dt em
 fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header hgroup
 html i iframe ins kbd label legend li map mark menu meter nav noscript object
 ol optgroup option output p pre progress q rp rt ruby s samp script section
 select small span strong style sub summary sup table tbody td textarea tfoot
 th thead time title tr u ul video'

  # Valid self-closing HTML 5 elements.
  void: 'area base br col command embed hr img input keygen link meta param
 source track wbr'

  obsolete: 'applet acronym bgsound dir frameset noframes isindex listing
 nextid noembed plaintext rb strike xmp big blink center font marquee multicol
 nobr spacer tt'

  obsolete_void: 'basefont frame'

# Create a unique list of element names merging the desired groups.
merge_elements = (args...) ->
  result = []
  for a in args
    for element in elements[a].split ' '
      result.push element unless element in result
  result


class DryKup 
  constructor: ->
    # check if called without new for backwards compatibility
    unless @ instanceof DryKup
      return new DryKup()

    # can't use class => notation.  The binding happens before our missing 'new' shortcircuit
    # TODO: switch back to => methods once factory functionality is removed
    for method in 'coffeescript comment doctype escape render text'.split(' ') 
      do (method) =>
        @[method] = (args...) => DryKup::[method].apply @, args

    for tagName in merge_elements 'regular', 'obsolete'
      do (tagName) =>
        @[tagName] = (args...) => @tag tagName, args...
        
    for tagName in merge_elements 'void', 'obsolete_void'
      do (tagName) =>
        @[tagName] = (args...) => @selfClosingTag tagName, args...
    
  resetHtml: (html = '') -> @htmlOut = html
  
  defineGlobalTagFuncs: -> if window then for name, func of @ then window[name] = func
  
  quote: (value) ->
    q = (if '"' in value then "'" else '"')
    return q + value + q

  renderAttr: (name, value) -> 
    if not value? or value is false
      return ''
    
    if value is true
      value = name

    return " #{name}=#{@quote value.toString()}"

  attrOrder: ['id', 'class']
  renderAttrs: (obj) -> 
    result = ''
    
    # render explicitly ordered attributes first
    for name in @attrOrder when name of obj
      result += @renderAttr name, obj[name]
      delete obj[name]

    # then unordered attrs 
    for name, value of obj
      result += @renderAttr name, value

    return result

  renderContents: (contents) ->
    if not contents?
      return
    else if typeof contents is 'function'
      contents.call @
    else
      @htmlOut += contents.toString()

  isSelector: (string) ->
    string.length > 1 and string[0] in ['#', '.']  

  parseSelector: (selector) ->
    id = null
    classes = []
    for token in selector.split '.'
      if id
        classes.push token
      else
        [klass, id] = token.split '#'
        classes.push token unless klass is ''
    return {id, classes}
  
  normalizeArgs: (args) ->
    attrs = {}
    selector = null
    contents = null
    for arg, index in args
      switch typeof arg
        when 'string'
          if index is 0 and @isSelector(arg)
            selector = @parseSelector(arg)
          else
            contents = arg
        when 'function', 'number', 'boolean'
          contents = arg
        when 'object'
          attrs = arg
        else  
          console.log "DryKup: invalid argument: #{arg.toString()}"

    if selector?
      {id, classes} = selector
      attrs.id = id if id?
      attrs.class = classes.join(' ') if classes?.length

    return {attrs, contents}

  tag: (tagName, args...) ->
    {attrs, contents} = @normalizeArgs args

    @text "<#{tagName}#{@renderAttrs attrs}>"
    @renderContents contents
    @text "</#{tagName}>"

  selfClosingTag: (tag, args...) ->
    {attrs, contents} = @normalizeArgs args
    if contents
      throw new Error "DryKup: <#{tag}/> must not have content.  Attempted to nest #{content}"
    @text "<#{tag}#{@renderAttrs attrs} />"

  render: (template, data) ->
    oldOut = @htmlOut
    @resetHtml()
    template.call @, data
    result = @htmlOut
    @resetHtml(oldOut)
    return result

  @render: (template, data) ->
    drykup = new DryKup()
    return drykup.render template, data

  coffeescript: ->
    throw new Error 'DryKup: coffeescript tag not implemented'

  comment: (text) ->
    @text "<!--#{text}-->"

  doctype: (type=5) ->
    @text doctypes[type]

  escape: (text) ->
    text.toString().replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')

  ie: (condition, contents) ->
    @text "<!--[if #{condition}]>"
    @renderContents contents
    @text "<![endif]-->"

  include: (template, data) ->
    template.call @, data

  text: (s) ->
    if s 
      @htmlOut += s

if module?.exports
  module.exports = DryKup
else 
  window.drykup = DryKup
  
