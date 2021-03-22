local settingItemID = 173202
local settingUnitPrice=1.5*10000

--/run C_AuctionHouse.StartCommoditiesPurchase(173202,1)

function getFirstRowCount()
  local info = C_AuctionHouse.GetCommoditySearchResultInfo(settingItemID,1)
  return info and info.quantity or 1
end


function scanItemID()
  print("StartCommoditiesPurchase")
  C_AuctionHouse.StartCommoditiesPurchase(settingItemID,getFirstRowCount())
end

local frame =CreateFrame("Frame")
frame:RegisterEvent("COMMODITY_PRICE_UPDATED")
frame:SetScript("OnEvent",function(self,event,...)
  local unitPrice,allPrice=...
  print(event,...)
  if unitPrice<=settingUnitPrice then
    print("购买",settingItemID,"单价=",unitPrice/10000)
    C_AuctionHouse.ConfirmCommoditiesPurchase(settingItemID,getFirstRowCount())
  else
    print("价格过高，不购买",settingItemID,"单价=",unitPrice/10000)
  end
end)