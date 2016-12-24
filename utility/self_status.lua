----------------------------------------------------------------------------------------------------

_G._savedEnv = getfenv()
module( "self_status", package.seeall )

----------------------------------------------------------------------------------------------------
local tableNextItemPurchase = {};

function SetNextItemPurchase (npcBot, value)
  tableNextItemPurchase[npcBot] = value;
end

function GetNextItemPurchase (npcBot)  
  return tableNextItemPurchase[npcBot];
end

----------------------------------------------------------------------------------------------------

for k,v in pairs( self_status ) do	_G._savedEnv[k] = v end

----------------------------------------------------------------------------------------------------
