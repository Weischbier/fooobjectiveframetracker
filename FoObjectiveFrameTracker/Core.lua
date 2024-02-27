-- Create a frame to respond to events
local aName = ...                                                                                 -- AddOn Name
local f, e = CreateFrame("FRAME", aName, ObjectiveTrackerFrame, "BackdropTemplate", 30091987), {} -- Our Frame
local tracker = ObjectiveTrackerFrame
local version, build, _, tocversion = GetBuildInfo()

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Default settings
local defaults = {
    stateSaved = false,
}

-- This function will be run when the player enters the world
function e:PLAYER_ENTERING_WORLD(...)
    ToggleObjectiveTrackerFrame(self.db.stateSaved)
end

-- This function will be run when your addon is loaded
function e:ADDON_LOADED(...)
    FoOFTDB = FoOFTDB or defaults
    self.db = FoOFTDB

    for k, v in pairs(defaults) do -- copy the defaults table and possibly any new options
        if self.db[k] == nil then  -- avoids resetting any false values
            self.db[k] = v
        end
    end

    ToggleObjectiveTrackerFrame(self.db.stateSaved)
end

f:SetScript("OnEvent", function(self, event, arg1)
    --print(event, arg1)   -- Let's see if our events fire
    e[event](self, arg1) -- call one of the functions above
end)

function ToggleObjectiveTrackerFrame(arg)
    f.db.stateSaved = arg
    if f.db.stateSaved then
        tracker:Hide()
    else
        tracker:Show()
    end
end

-- Function to handle keypress events
function FoObjectiveFrameTracker_HotkeyPressed(keystate)
    if keystate == 'down' then
        ToggleObjectiveTrackerFrame(tracker:IsVisible())
    end
end

-- Function to handle keypress events
function FoObjectiveFrameTracker_Reload_HotkeyPressed(keystate)
    if keystate == 'down' then
        C_UI.Reload()
    end
end
