----------------------------------------------------------------------------------------------------

_G._savedEnv = getfenv()
module( "team_status", package.seeall )

----------------------------------------------------------------------------------------------------

local teamHope = 0.5;

function SetTeamHope (value)
  teamHope = value;
end

function GetTeamHope ()
  return teamHope;
end

----------------------------------------------------------------------------------------------------

for k,v in pairs( team_status ) do	_G._savedEnv[k] = v end

----------------------------------------------------------------------------------------------------