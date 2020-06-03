local patterns = require('patterns')

function match(open_tag, close_tag)
  return string.match(open_tag, patterns.match_open) == string.match(close_tag, patterns.match_close)
end

function create_close_tag(open_tag)
  return '</' .. string.match(open_tag, patterns.match_open) .. '>'
end

function match_special_tag(value)
  local special_chars = { 'br', 'img', 'audio', 'video' }
  local char = string.match(value, patterns.match_special)

  for _, v in ipairs(special_chars) do
    if (char == v) then return true end
  end

  return false
end

return {
  match = match,
  create_close_tag = create_close_tag,
  match_special_tag = match_special_tag
}
