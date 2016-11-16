Price = {}

function Price:toString()
  return "Price:\n" .. "-Purchase: " .. self.PURCHASE .. "\n" .. "-Sellback: " .. self.SELLBACK .. "\n"
end

function Price.new(purchase,sellback)
  purchase = purchase or 0
  sellback = sellback or 0

  local c = setmetatable(
    {
      PURCHASE = purchase,
      SELLBACK = sellback
    },
    {
      __index = Price,
      __tostring = Price["toString"]
    }
  )

  return c
end

function Price:getPurchase()
  return self.PURCHASE
end

function Price:getSellback()
  return self.SELLBACK
end

function Price:setPurchase(val)
  self.PURCHASE = val
end

function Price:setSellback(val)
  self.SELLBACK = val
end