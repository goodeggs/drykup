expect = require 'expect.js'
DryKup = require '../drykup'

describe 'HereDocs', ->
  it 'preserves line breaks', ->
    template = -> @script """
      $(document).ready(function(){
        alert('test');
      });
    """
    expect(DryKup.render template).to.equal '<script>$(document).ready(function(){\n  alert(\'test\');\n});</script>\n'
