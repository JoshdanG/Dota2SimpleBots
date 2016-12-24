require( GetScriptDirectory().."/utility/self_status" )

function GetDesire()
  local npcBot = GetBot();
  local sNextItem =   self_status.GetNextItemPurchase ( npcBot );
  
  if ( IsItemPurchasedFromSecretShop ( sNextItem ) and npcBot:GetGold() >= GetItemCost( sNextItem ) )
  then
    return BOT_MODE_DESIRE_MODERATE;
  else
    return BOT_MODE_DESIRE_NONE;
  end
  
end

