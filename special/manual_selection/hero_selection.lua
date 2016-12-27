
local tableRadiantHeroes =  { 
        { "npc_dota_hero_crystal_maiden",      LANE_MID },
        { "npc_dota_hero_axe",                 LANE_MID },
        { "npc_dota_hero_bane",                LANE_BOT },
        { "npc_dota_hero_shredder",            LANE_TOP },
        { "npc_dota_hero_lina",                LANE_BOT },
  };

local tableDireHeroes =  { 
        { "npc_dota_hero_drow_ranger",         LANE_TOP },
        { "npc_dota_hero_earthshaker",         LANE_MID },
        { "npc_dota_hero_juggernaut",          LANE_BOT },
        { "npc_dota_hero_mirana",              LANE_TOP },
        { "npc_dota_hero_nevermore",           LANE_TOP },
  };

local tableTeamHeroes = {};
tableTeamHeroes [ TEAM_RADIANT ] = tableRadiantHeroes;
tableTeamHeroes [ TEAM_DIRE ]    = tableDireHeroes;

----------------------------------------------------------------------------------------------------

function Think()

    local tableHeroes = tableTeamHeroes[ GetTeam() ];
    local tablePlayers = GetTeamPlayers( GetTeam() );
    
    for i , iPlayer in ipairs( tablePlayers )
    do
      if ( IsPlayerBot( iPlayer ) )
      then 
        SelectHero( iPlayer , tableHeroes[ i ][ 1 ] );
      end
    end
    
end

----------------------------------------------------------------------------------------------------
function UpdateLaneAssignments()    

    local tableHeroes = tableTeamHeroes[ GetTeam() ];
    local tableLaneAssignments = {};
    
    for i , tableHeroLane in ipairs( tableHeroes )
    do
      tableLaneAssignments[ i ] = tableHeroLane[ 2 ];
    end
    
    return tableLaneAssignments;    
end

-- Bots with a default implementation:
--   npc_dota_hero_axe
--   npc_dota_hero_bane
--   npc_dota_hero_bloodseeker
--   npc_dota_hero_bounty_hunter
--   npc_dota_hero_bristleback
--   npc_dota_hero_chaos_knight
--   npc_dota_hero_crystal_maiden
--   npc_dota_hero_dazzle
--   npc_dota_hero_death_prophet
--   npc_dota_hero_dragon_knight
--   npc_dota_hero_drow_ranger
--   npc_dota_hero_earthshaker
--   npc_dota_hero_jakiro
--   npc_dota_hero_juggernaut
--   npc_dota_hero_kunkka
--   npc_dota_hero_lich
--   npc_dota_hero_lina
--   npc_dota_hero_lion
--   npc_dota_hero_luna
--   npc_dota_hero_necrolyte   
--   npc_dota_hero_nevermore           (Shadow Fiend)
--   npc_dota_hero_omniknight
--   npc_dota_hero_oracle
--   npc_dota_hero_phantom_assassin
--   npc_dota_hero_pudge
--   npc_dota_hero_razor
--   npc_dota_hero_sand_king
--   npc_dota_hero_skeleton_king       (Wraith King)
--   npc_dota_hero_skywrath_mage
--   npc_dota_hero_sniper
--   npc_dota_hero_sven
--   npc_dota_hero_tidehunter
--   npc_dota_hero_tiny
--   npc_dota_hero_vengefulspirit
--   npc_dota_hero_viper
--   npc_dota_hero_warlock
--   npc_dota_hero_windrunner
--   npc_dota_hero_witch_doctor
--   npc_dota_hero_zuus
