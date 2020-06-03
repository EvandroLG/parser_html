local patterns = require('patterns')
local utils = require('utils')

function parser_html(html)
  local stack = {}
  local result = {}

  for _, v in ipairs(html) do
    if utils.match_special_tag(v) then
      table.insert(result, v)
    elseif string.find(v, patterns.match_open) then
      table.insert(stack, v)
      table.insert(result, v)
    else
      if string.find(v, patterns.match_close) then
        if #stack == 0 then break end

        local last_item = stack[#stack]

        if utils.match(last_item, v) then
          table.remove(stack)
          table.insert(
            result,
            v
          )
        else
          for i = #stack, 1, -1 do
            local opened = stack[i]
            local closed = utils.create_close_tag(opened)

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
