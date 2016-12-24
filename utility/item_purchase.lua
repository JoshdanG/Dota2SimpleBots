----------------------------------------------------------------------------------------------------
require( GetScriptDirectory().."/utility/self_status" )

_G._savedEnv = getfenv()
module( "item_purchase", package.seeall )

----------------------------------------------------------------------------------------------------

function BuyItemFromList ( npcBot, tableItemsToBuy, sItemName )
      local iResult = 0;
      iResult = npcBot:Action_PurchaseItem( sItemName );
      if( iResult == PURCHASE_ITEM_SUCCESS )   
      then
        table.remove( tableItemsToBuy, 1 );
      end
end


----------------------------------------------------------------------------------------------------

function SellItemByName ( npcBot, sItemName )    
    local i = 0;    
    local bItemSold = false;
    
    while ( bItemSold == false and i <= 14 )   -- 0-5 = carried, 6-8 = backpack, 9-14 = stash
    do
      local itemCurrentItem = npcBot:GetItemInSlot ( i );
            
      if ( itemCurrentItem ~= nil and itemCurrentItem:GetName() == sItemName )
      then
          print ( "Selling item " .. itemCurrentItem:GetName() .. " in slot " .. i );
          npcBot:Action_SellItem ( itemCurrentItem );
          bItemSold = true;
      end
      i = i + 1;
    end
end

----------------------------------------------------------------------------------------------------

function ProcessPurchaseTable ( npcBot, tableItemsToBuy )
	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local sNextItem = tableItemsToBuy[1];
	npcBot:SetNextItemPurchaseValue ( GetItemCost( sNextItem ) );
  self_status.SetNextItemPurchase ( npcBot, sNextItem );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
    -- If the item is not available at fountain, make sure we can purchase before trying to buy
    -- If we are not able to purchase immediately, then mode_secret_shop will set a desire
    if ( IsItemPurchasedFromSecretShop( sNextItem ) )
    then
      -- TODO: Consider side shop as well
      --IsItemPurchasedFromSideShop( cstring ) : bool
      
      if ( npcBot:DistanceFromSecretShop( ) == 0 )
      then
        BuyItemFromList ( npcBot, tableItemsToBuy, sNextItem )
      end
      
    else      
      BuyItemFromList ( npcBot, tableItemsToBuy, sNextItem )
    end
	end
end

----------------------------------------------------------------------------------------------------


-- TODO slot numbers should be in globals


-- Returns:
--   * Level of Boots of Travel in possession (inventory + backpack), 
--   * Count of TP scrolls in possession 
--   * Level of Boots of Travel elsewhere 
--   * Count of TP scrolls elsewhere 
--   ("elsewhere" currently only includes stash, but should count on courier)
function GetTpCounts( npcBot )  
  local iPossessionTravelBootsLevel = 0;
  local iPossessionScrollCount = 0;
  local iElsewhereTravelBootsLevel = 0;
  local iElsewhereScrollCount = 0;

  -- Count current number of TP scrolls and highest level of BoTs in possession
  for i = 0 , 8
  do
    local itemCurrent = npcBot:GetItemInSlot ( i );

    if ( itemCurrent ~= nil )
    then
      sCurrentItemName = itemCurrent:GetName();

      if ( sCurrentItemName == "item_tpscroll" )
      then 
        iPossessionScrollCount = iPossessionScrollCount + itemCurrent:GetCurrentCharges();

      elseif ( sCurrentItemName == "item_travel_boots" )
      then
        iPossessionTravelBootsLevel = math.max(iPossessionTravelBootsLevel, 1);

      elseif ( sCurrentItemName == "item_travel_boots_2" )
      then
        iPossessionTravelBootsLevel = math.max(iPossessionTravelBootsLevel, 2);
      end          
    end
  end

  -- Count current number of TP scrolls and highest level of BoTs elsewhere
  for i = 9 , 14
  do
    local itemCurrent = npcBot:GetItemInSlot ( i );

    if ( itemCurrent ~= nil )
    then
      sCurrentItemName = itemCurrent:GetName();

      if ( sCurrentItemName == "item_tpscroll" )
      then 
        iElsewhereScrollCount = iElsewhereScrollCount + itemCurrent:GetCurrentCharges();

      elseif ( sCurrentItemName == "item_travel_boots" )
      then
        iElsewhereTravelBootsLevel = math.max(iElsewhereTravelBootsLevel, 1);

      elseif ( sCurrentItemName == "item_travel_boots_2" )
      then
        iElsewhereTravelBootsLevel = math.max(iElsewhereTravelBootsLevel, 2);
      end          
    end
  end

  return iPossessionTravelBootsLevel, iPossessionScrollCount, iElsewhereTravelBootsLevel, iElsewhereScrollCount;

end

----------------------------------------------------------------------------------------------------

-- If we are at a shop that sells TP scrolls, buy until we are carrying at least iMinScrollCount
-- If we have Boots of Travel, then no need to buy
-- Will only buy one TP per pass
function EnsureTpScrolls( npcBot, iMinScrollCount )
  
  iBoots, iScrollCount = item_purchase.GetTpCounts(npcBot);
  
  -- Already have Boots of Travel, nothing to do
  if ( iBoots > 0 )
  then
    return
  end
  
  -- Do we need to buy TPs, and can we afford one?
  if ( iScrollCount < iMinScrollCount and npcBot:GetGold() >= GetItemCost( "item_tpscroll" ) )
  then
    -- Are we somewhere TP scrolls are available?
    if(  npcBot:DistanceFromSideShop() == 0 or  npcBot:DistanceFromFountain() == 0 )    
    then
      npcBot:Action_PurchaseItem( "item_tpscroll" );
    end
  end
end


----------------------------------------------------------------------------------------------------

for k,v in pairs( item_purchase ) do _G._savedEnv[k] = v end

----------------------------------------------------------------------------------------------------
