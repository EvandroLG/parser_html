local test = require('simple_test')
local parser_html = require('parser_html')

test('parser_html', function(a)
  local result = parser_html({
    '<div>',
      '<h1>',
        'title',
      '<p>',
        'content',
      '</p>',
    '</div>'
  })

  a.equal(result, '<div><h1>title<p>content</p></h1></div>')
end)
