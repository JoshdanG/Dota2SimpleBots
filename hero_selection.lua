
globalTest = 10;

----------------------------------------------------------------------------------------------------

function Think()


	if ( GetTeam() == TEAM_RADIANT )
	then
		print( "selecting radiant" );
		SelectHero( 0, "npc_dota_hero_antimage" );
		SelectHero( 1, "npc_dota_hero_axe" );
		SelectHero( 2, "npc_dota_hero_bane" );
		SelectHero( 3, "npc_dota_hero_shredder" );
		SelectHero( 4, "npc_dota_hero_lina" );
	elseif ( GetTeam() == TEAM_DIRE )
	then
		print( "selecting dire" );
		SelectHero( 5, "npc_dota_hero_drow_ranger" );
		SelectHero( 6, "npc_dota_hero_earthshaker" );
		SelectHero( 7, "npc_dota_hero_juggernaut" );
		SelectHero( 8, "npc_dota_hero_mirana" );
		SelectHero( 9, "npc_dota_hero_nevermore" );
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