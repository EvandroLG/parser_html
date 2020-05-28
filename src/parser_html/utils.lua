local patterns = require('patterns')

function match(open_tag, close_tag)
  return string.match(open_tag, patterns.match_open) == string.match(close_tag, patterns.match_close)
end

function create_close_tag(open_tag)
  return '</' .. string.match(open_tag, patterns.match_open) .. '>'
end

return {
  match = match,
  create_close_tag = create_close_tag
}
