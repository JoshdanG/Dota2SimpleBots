local fPickThreshold = 10.0;  --seconds

local tableAvailableBotHeroes =  {
        "npc_dota_hero_axe",
        "npc_dota_hero_bane",
        "npc_dota_hero_bloodseeker",
        "npc_dota_hero_bounty_hunter",
        "npc_dota_hero_bristleback",
        "npc_dota_hero_chaos_knight",
        "npc_dota_hero_crystal_maiden",
        "npc_dota_hero_dazzle",
        "npc_dota_hero_death_prophet",
        "npc_dota_hero_dragon_knight",
        "npc_dota_hero_drow_ranger",
        "npc_dota_hero_earthshaker",
        "npc_dota_hero_jakiro",
        "npc_dota_hero_juggernaut",
        "npc_dota_hero_kunkka",
        "npc_dota_hero_lich",
        "npc_dota_hero_lina",
        "npc_dota_hero_lion",
        "npc_dota_hero_luna",
        "npc_dota_hero_necrolyte",
        "npc_dota_hero_nevermore",
        "npc_dota_hero_omniknight",
        "npc_dota_hero_oracle",
        "npc_dota_hero_phantom_assassin",
        "npc_dota_hero_pudge",
        "npc_dota_hero_razor",
        "npc_dota_hero_sand_king",
        "npc_dota_hero_skeleton_king",
        "npc_dota_hero_skywrath_mage",
        "npc_dota_hero_sniper",
        "npc_dota_hero_sven",
        "npc_dota_hero_tidehunter",
        "npc_dota_hero_tiny",
        "npc_dota_hero_vengefulspirit",
        "npc_dota_hero_viper",
        "npc_dota_hero_warlock",
        "npc_dota_hero_windrunner",
        "npc_dota_hero_witch_doctor",
        "npc_dota_hero_zuus",
  };
  

----------------------------------------------------------------------------------------------------


function Think()

    if( GetHeroPickState( ) == HEROPICK_STATE_CM_PICK and GetCMPhaseTimeRemaining() < fPickThreshold )
    then 
        local tableUnassignedBotPlayers = GetUnassignedBotPlayers();
        local tableUnassignedHeroes = GetUnassignedHeroes();
        
        -- Loop through unassigned heroes and assign them to unassigned bot players
        -- If we have too many heroes, then some will be left unassigned (humans still have to pick)
        -- If we have too few, then a bot will be left unassigned (humans didn't pick enough usable heroes for bots)
        for i , sHero in ipairs( tableUnassignedHeroes )
        do
          SelectHero( tableUnassignedBotPlayers [ i ] , sHero );
        end
    end

end

----------------------------------------------------------------------------------------------------

-- Look for any bots on our team that still need to be assigned
function GetUnassignedBotPlayers ()
  local tablePlayers = GetTeamPlayers( GetTeam() );

  local tableUnassignedPlayers = {};

  for _ , iPlayer in ipairs( tablePlayers )
  do
    if ( IsPlayerBot( iPlayer ) )
    then 
      if ( GetSelectedHeroName( iPlayer ) == "" )
      then
        table.insert( tableUnassignedPlayers, iPlayer );
      end
    end
  end
  
  return tableUnassignedPlayers;

end

-- Find picked heroes that have not been assigned
function GetUnassignedHeroes ()
  local tablePlayers = GetTeamPlayers( GetTeam() ); 
  
  local tableUnassignedHeroes = {};
  local bAssigned = false;
  
  for _ , sHero in ipairs( tableAvailableBotHeroes )
  do
    if ( IsCMPickedHero( GetTeam(), sHero ) )
    then
      -- Hero is picked, see if they are already assigned.
      bAssigned = false;
      
      for _ , iPlayer in ipairs( tablePlayers )
      do
        if ( GetSelectedHeroName( iPlayer ) == sHero )
        then 
          bAssigned = true;
        end
      end
      
      if ( not bAssigned )
      then
        table.insert ( tableUnassignedHeroes, sHero );
      end
    
    end
  end
  
  return tableUnassignedHeroes;
  
end
