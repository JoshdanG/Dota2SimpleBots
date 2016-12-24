require( GetScriptDirectory().."/utility/self_status" )
require( GetScriptDirectory().."/utility/item_purchase" )

local tableItemsToBuy = { 
				"item_tango",
        "item_flask",
        "item_enchanted_mango",
        "item_stout_shield",
				"item_branches",
				"item_boots",
				"item_magic_stick",
				"item_circlet",
				"item_branches",
				"item_energy_booster",        
				"item_sobi_mask",
				"item_ring_of_regen",
        "item_recipe_soul_ring",
				"item_point_booster",
        "item_vitality_booster",
				"item_energy_booster",        
        "item_recipe_bloodstone",
        "item_platemail",
        "item_mystic_staff",
        "item_recipe_shivas_guard",
        "item_ring_of_health",
        "item_void_stone",
        "item_platemail",
				"item_energy_booster",        
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
