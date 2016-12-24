
local tableRadiantHeroes =  { 
				"npc_dota_hero_antimage",
        "npc_dota_hero_axe",
        "npc_dota_hero_bane",
        "npc_dota_hero_shredder",
				"npc_dota_hero_lina",
			};

local tableDireHeroes =  { 
        "npc_dota_hero_drow_ranger",
        "npc_dota_hero_earthshaker",
        "npc_dota_hero_juggernaut",
        "npc_dota_hero_mirana",
        "npc_dota_hero_nevermore",
			};

local tableTeamHeroes = {};
tableTeamHeroes [ TEAM_RADIANT ] = tableRadiantHeroes;
tableTeamHeroes [ TEAM_DIRE ]    = tableDireHeroes;        
        
----------------------------------------------------------------------------------------------------

function Think()

    local iTeam = GetTeam();

    local tableHeroes = tableTeamHeroes[ iTeam ];
    local tablePlayers = GetTeamPlayers( iTeam );
    
    local i = 0;
    
    for i, iPlayer in ipairs( tablePlayers )
    do
      if ( IsPlayerBot( iPlayer ) )
      then 
        SelectHero( iPlayer , tableHeroes[ i ] );
      end      
    end
    
end

----------------------------------------------------------------------------------------------------
function UpdateLaneAssignments()    

    if ( GetTeam() == TEAM_RADIANT )
    then
        --print( "Radiant lane assignments" );
        return {
        [1] = LANE_MID,
        [2] = LANE_MID,
        [3] = LANE_BOT,
        [4] = LANE_TOP,
        [5] = LANE_BOT,
        };
    elseif ( GetTeam() == TEAM_DIRE )
    then
        --print( "Dire lane assignments" );
        return {
        [1] = LANE_TOP,
        [2] = LANE_MID,
        [3] = LANE_BOT,
        [4] = LANE_TOP,
        [5] = LANE_TOP,
        };
    end
end