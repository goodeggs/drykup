expect = require 'expect.js'
{script} = require '../tags'

describe 'HereDocs', ->
  it 'preserves line breaks', ->
    template = -> script """
      $(document).ready(function(){
        alert('test');
      });
    """
    expect(template()).to.equal '<script>$(document).ready(function(){\n  alert(\'test\');\n});</script>'
