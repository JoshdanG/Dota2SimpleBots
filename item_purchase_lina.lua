require( GetScriptDirectory().."/utility/self_status" )
require( GetScriptDirectory().."/utility/item_purchase" )

local tableItemsToBuy = { 
				"item_tango",
				"item_clarity",
				"item_clarity",
				"item_branches",
				"item_branches",
				"item_magic_stick",
				"item_circlet",
				"item_boots",
				"item_energy_booster",
				"item_staff_of_wizardry",
				"item_ring_of_regen",
				"item_recipe_force_staff",
				"item_point_booster",
				"item_staff_of_wizardry",
				"item_ogre_axe",
				"item_blade_of_alacrity",
				"item_mystic_staff",
				"item_ultimate_orb",
				"item_void_stone",
				"item_staff_of_wizardry",
				"item_wind_lace",
				"item_void_stone",
				"item_recipe_cyclone",
			};

local doStartup = true;

---------------------------------------------------------------------------------------------------

function ItemPurchaseThink()
  local npcBot = GetBot();
  
  -- Clumsy way to buy TP to go back to lane.  If we find ourself in a shop within the first 5 minutes,
  -- it's probably because we died
  if ( DotaTime() > 60 )
  then
    item_purchase.EnsureTpScrolls( npcBot, 1 );
  
  -- Start buying TPs after 5 minutes.  Buy until carrying two whenever convenient
  elseif ( DotaTime() > 300 )
  then    
    item_purchase.EnsureTpScrolls( npcBot, 2 );
  end


  item_purchase.ProcessPurchaseTable ( npcBot, tableItemsToBuy );

end



----------------------------------------------------------------------------------------------------
