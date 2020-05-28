function match(open_tag, close_tag)
  return string.match(open_tag, '^<(%w+)>$') == string.match(close_tag, '^</(%w+)>$')
end

function create_close_tag(open_tag)
  return '</' .. string.match(open_tag, '^<(%w+)>$') .. '>'
end

function parser_html(html)
  local stack = {}
  local result = {}

  for _, v in ipairs(html) do
    if string.find(v, '^<(%w+)>$') then
      table.insert(stack, v)
      table.insert(result, v)
    else
      if string.find(v, '^</(%w+)>$') then
        if #stack == 0 then break end

        local last_item = stack[#stack]

        if match(last_item, v) then
          table.remove(stack)
          table.insert(
            result,
            v
          )
        else
          for i = #stack, 1, -1 do
            local opened = stack[i]
            local closed = create_close_tag(opened)

            table.insert(result, closed)
            table.remove(stack)

            if closed == v then
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
