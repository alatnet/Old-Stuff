Stack = {}

function Stack.new()
  local c = setmetatable(
    {
      STACK = {}
    },
    {
      __index = Stack
    }
  )

  return c
end

function Stack:push(...)
  if table.getn(arg) == 0 then
    return
  end
  
  for i=1, table.getn(arg) do
    table.insert(self.STACK, arg[i])
  end
end

function Stack:pop(n)
  n = n or 1
  
  if n <= 0 then
    n=1
  end

  local ret = {}

  for i=1,n do
    table.insert(ret,table.remove(self.STACK,1))
  end
  
  return unpack(ret)
end

function Stack:peek(n)
  n = n or 1
  
  if n <= 0 then
    n=1
  end

  local ret = {}

  for i=1,n do
    table.insert(ret,self.STACK[i])
  end

  return unpack(ret)
end

function Stack:size()
  return table.getn(self.STACK)
end

function Stack:clear()
  while table.getn(self.STACK) ~= 0 do
    table.remove(self.STACK)
  end
end