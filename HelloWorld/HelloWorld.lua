
TargetLogData = {} -- initial value (will be overwritten when/if SavedVariables load)
LoggedData = {}
SubmittedOnce = false

local f = CreateFrame("Frame")
f:SetScript("OnEvent",function(self, event, ...)
    if event == "UPDATE_BATTLEFIELD_STATUS" then
        --print('an event happened, we just want the end game one')
        local winner = GetBattlefieldWinner()
        if winner == nil then
            --print('nobody has won yet')
        else
            if SubmittedOnce == false then
                print('A winner has been decided: ' .. winner)
                message("Don't forget to /reload after leaving!")

                status, mapName, teamSize, registeredMatch, suspendedQueue, queueType, gameType, role, asGroup, shortDescription, longDescription = GetBattlefieldStatus(1)
    
                local random1 = math.random(1,5000)
                local random2 = math.random(1,5000)
                local random3 = math.random(1,5000)
                local randomid = (random1 .. random2 .. random3)
                local winner = tostring(GetBattlefieldWinner())
                local numScores = GetNumBattlefieldScores()
                local bgname = C_PvP.GetRandomBGInfo()
                --local time = GetBattlefieldInstanceRunTime()
            
                local battleGroundID = bgname.bgID

                LoggedData = {}
                
            for i=1, numScores do
                name, killingBlows, honorableKills, deaths, honorGained,
                 faction, race, class, classToken, damageDone, healingDone,
                  bgRating, ratingChange, preMatchMMR, mmrChange, talentSpec = GetBattlefieldScore(i);
            
                 local playerInfo = (name .. ", " .. killingBlows .. ", " .. honorableKills .. ", " ..
                deaths .. ", " .. honorGained .. ", " .. faction .. ", " .. race .. ", " .. class .. ", " ..
                classToken .. ", " .. damageDone .. ", " .. healingDone .. ", " .. bgRating .. ", " ..
                ratingChange .. ", " .. preMatchMMR .. ", " .. mmrChange .. ", " .. talentSpec)
            
                
                
            
                --local playerInfo = ("Stat1" .. ", " .. "Stat2")
                print(playerInfo)
                tinsert(LoggedData,format("%s,%s,%s,%s,%s",date(),playerInfo,winner,mapName,randomid))

                SubmittedOnce = true
                
            end

            
        end
        end
    end
    --if event == "PVP_MATCH_COMPLETE" then
      --  print('PVP MATCH COMPLETE fired')
       -- winner, duration = ...
       -- print(winner)
       -- print(duration)
    --end
end)
f:RegisterEvent("PLAYER_TARGET_CHANGED")
f:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
--f:RegisterEvent("PVP_MATCH_COMLETE")



SLASH_HELLO1 = "/helloworld"
SLASH_SCORE1 = "/scoreboard"
SLASH_PLAYER1 = "/playerscore"
--SLASH_CALLAPI1 = "/callapi"

-- /helloworld 
local function HelloWorldHandler(name)

    if(string.len(name) > 0) then
        message("Hello, " .. name .. "!")
    else
        local playerName = UnitName("player")
        message("Hello, " .. playerName .. "!")
    end
end



-- Important stuff here
local function scoreHandler()

end
-- End important stuff

local function playerHandler()

    local random1 = math.random(1,5000)
    local random2 = math.random(1,5000)
    local random3 = math.random(1,5000)
    local randomid = (random1 .. random2 .. random3)

    print(randomid)

    --local columnNames = ("name, killingBlows, honorableKills, deaths, honorGained, " ..
    --"faction, race, class, classToken, damageDone, healingDone, " ..
     --"bgRating, ratingChange, preMatchMMR, mmrChange, talentSpec")
    --print(columnNames)
    --tinsert(LoggedData,format("%s",columnNames))

 
    
end


SlashCmdList["HELLO"] = HelloWorldHandler
SlashCmdList["SCORE"] = scoreHandler
SlashCmdList["PLAYER"] = playerHandler
--SlashCmdList["CALLAPI"] = CallApiHandler

    

