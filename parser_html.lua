local tags = {
  ['<div>'] = '</div>',
  ['<h1>'] = '</h1>',
  ['<p>'] = '</p>',
}

local closed_tags = {
  ['</div>'] = '<div>',
  ['</h1>'] = '<h1>',
  ['</p>'] = '<p>'
}

function parser_html(html)
  local stack = {}
  local result = {}

  for _, v in ipairs(html) do
    if tags[v] then
      table.insert(stack, v)
      table.insert(result, v)
    else
      if closed_tags[v] then
        if #stack == 0 then break end

        local last_item = stack[#stack]

        if closed_tags[v] == last_item then
          table.remove(stack)
          table.insert(
            result,
            v
          )
        else
          for i = #stack, 1, -1 do
            local opened = stack[i]
            local closed = tags[opened]

            table.insert(result, closed)
            table.remove(stack)

            if closed_tags[closed] == v then
              ::continue::
            end
          end
        end
      else
        table.insert(result, v)
      end
    end
  end

  return table.concat(result, '')
end

return parser_html
