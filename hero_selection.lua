
local tableRadiantHeroes =  { 
        { "npc_dota_hero_antimage",            LANE_MID },
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
