local test = require('simple_test')
local parser_html = require('parser_html')
local utils = require('utils')

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

test('utils.match_special_tag', function(a)
  a.ok(
    utils.match_special_tag('<br>')
  )

  a.ok(
    utils.match_special_tag('<img src="image.jpg" alt="lua" />')
  )
end)
