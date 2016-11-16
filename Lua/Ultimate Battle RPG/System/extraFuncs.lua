if _G.Socket["sendToPHP"] == nil then
  _G.Socket["sendToPHP"] = function (phppage,tableVars)
  --function _G.Socket:sendToPHP(phppage,tableVars)

    if type(phppage) ~= "string" then
      error("string expected, got " .. type(phppage),2)
    end

    if type(tableVars) ~= "table" or type(tableVars) ~= "nil" then
      error("table or nil expected, got " .. type(tableVars),2)
    end

    local str = "GET " .. phppage .. "?"

    if type(tableVars) ~= "nil" or tableVars ~= nil then
      for k,v in pairs(tableVars) do
        str = str .. k .. "=" .. v .. "&"
      end
    end

    str = string.sub(str, 1,-2)

    str = str .. " HTTP/1.0\r\n"

    return str

    --return self:send(str)
  end
end

if _G.Wlan["getSwitchState"] == nil then
  _G.Wlan["getSwitchState"] = function ()
    return 1
  end
end