rconsoleclear()
local RBXLoaderDir = "/RBXLoader/"
local RBXModsDir = RBXLoaderDir .. "Mods"
local RBXPluginDir = RBXLoaderDir .. "Plugins"
makefolder(RBXLoaderDir)
makefolder(RBXModsDir)
makefolder(RBXPluginDir)
makefolder(RBXModsDir .. "/Disabled Mods")
local currentDate = os.date("*t")
local formattedDate = string.format("%02d-%02d-%04d", currentDate.month, currentDate.day, currentDate.year)
writefile(RBXLoaderDir .. formattedDate .. ".log", "RBXLoader Log")
getgenv().rbxloaderout = function(str)
    appendfile(RBXLoaderDir .. formattedDate .. ".log", str)
    rconsoleprint(str)
end
getgenv().rbxloaderout("\nMade directories required to run RBXLoader, move on to events.\n")
getgenv().RBXLoaderFuncs = {
    OnPlayerJoined = function(functoconnect)
        connection = game.Players.PlayerAdded:Connect(functoconnect)
        return connection
    end,
    OnPlayerLeft = function(functoconnect)
        connection = game.Players.PlayerRemoving:Connect(functoconnect)
        return connection
    end,
    OnGameLoaded = function(functoconnect)
        repeat wait() until game:IsLoaded()
        functoconnect()
    end,
    OnCharacterAdded = function(functoconnect)
        OnPlayerJoined(function(player)
            connection = player.CharacterAdded:Connect(functoconnect)
            return connection
        end)
    end,
    NewInstance = function(typetomake, properties)
        inst = Instance.new(typetomake, properties)
        return inst
    end,
    DestroyInstance = function(insttodestroy)
        insttodestroy:Destroy()
    end,
    ConsoleClear = function()
        rconsoleclear()
    end,
    ConsoleTitle = function(title)
        rconsoletitle(title .. " | Powered By RBXLoader")
    end,
    ConsolePrint = function(msg)
        rconsoleprint(msg .. "\n")
    end,
    ConsoleWarn = function(msg)
        rconsoleprint("[WARN]", msg .. "\n")
    end,
    ConsoleErr = function(msg)
        rconsoleprint("[ERROR]", msg .. "\n")
    end, 
    ConsoleInfo = function(msg)
        rconsoleprint("[INFO]", msg .. "\n")
    end,
    GetRBXLoaderInfo = function()
        local tabletoreturn = {
            toolname = "RBXLoader";
            toolver = "0.0.1";
            tooldesc = "A module loader by tornvrc.";
        }
        return tabletoreturn
    end,
}
getgenv().rbxloaderout("Initialized utilities!")
getgenv().rbxloaderout("Show welcome message...\n")
getgenv().rbxloaderout("-------------------------------------------------\n")
rconsoleclear()

local WorkspaceDirectory = "/../workspace"
local AutoexecDirectory = "/../autoexec"
rconsoletitle("RBXLoader V0.0.1 By tornvrc")
getgenv().rbxloaderout[[
			 _______   _______   __    __  __                                 __                     
			|       \ |       \ |  \  |  \|  \                               |  \                    
			| $$$$$$$\| $$$$$$$\| $$  | $$| $$       ______    ______    ____| $$  ______    ______  
			| $$__| $$| $$__/ $$ \$$\/  $$| $$      /      \  |      \  /      $$ /      \  /      \ 
			| $$    $$| $$    $$  >$$  $$ | $$     |  $$$$$$\  \$$$$$$\|  $$$$$$$|  $$$$$$\|  $$$$$$\
			| $$$$$$$\| $$$$$$$\ /  $$$$\ | $$     | $$  | $$ /      $$| $$  | $$| $$    $$| $$   \$$
			| $$  | $$| $$__/ $$|  $$ \$$\| $$_____| $$__/ $$|  $$$$$$$| $$__| $$| $$$$$$$$| $$      
			| $$  | $$| $$    $$| $$  | $$| $$     \\$$    $$ \$$    $$ \$$    $$ \$$     \| $$      
			 \$$   \$$ \$$$$$$$  \$$   \$$ \$$$$$$$$ \$$$$$$   \$$$$$$$  \$$$$$$$  \$$$$$$$ \$$                                                                                            
]]
getgenv().rbxloaderout("----------------\n")
getgenv().rbxloaderout("Initialize Plugins...\n")
plugsloaded = 0
for i,v in ipairs(listfiles(RBXPluginDir)) do
		if isfile(v) then
	        success, err = pcall(function() module = loadstring(readfile(v))() end)
	        if not success then
	            getgenv().rbxloaderout("Failed to load " .. v .. "\n Error: " .. err)
	        else
	    getgenv().rbxloaderout("---------------\n")
	    getgenv().rbxloaderout("File Path: " .. v .. "\n")
	    getgenv().rbxloaderout("Plugin Name: " .. module.getver()["name"].. "\n")
	    getgenv().rbxloaderout("Version: " .. module.getver()["version"].. "\n")
	    getgenv().rbxloaderout("Plugin Author(s): " .. module.getver()["author"].. "\n")
	    getgenv().rbxloaderout("---------------\n")
	    module.onmodstarted()
	    plugsloaded = plugsloaded + 1
	    end
	end 
end
getgenv().rbxloaderout("\nLoaded " .. plugsloaded .. " plugin(s)!")
getgenv().rbxloaderout("Waiting for game to load...\n")
while not game:IsLoaded() do
    wait()
end
getgenv().rbxloaderout("RBXLoader V0.0.1\n")
local placeinfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
getgenv().rbxloaderout("Game: " .. placeinfo.Name .. "\n")
getgenv().rbxloaderout("Game ID: " .. game.PlaceId .. "\n")
getgenv().rbxloaderout("User Name: " .. game.Players.LocalPlayer.Name)
getgenv().rbxloaderout("\nUser ID: " .. game.Players.LocalPlayer.UserId)
getgenv().rbxloaderout("\n----------------\n")
getgenv().rbxloaderout("Initialize mods... ")
local modsloaded = 0
for i,v in ipairs(listfiles(RBXModsDir)) do
			if isfile(v) then
			local module = nil
			getgenv().rbxloaderout("---------------\n")
	    getgenv().rbxloaderout("File Path: " .. v .. "\n")
	       success, fail =  xpcall(function() module = loadstring(readfile(v))() end, function(err) getgenv().rbxloaderout("Error loading mod! Error: " .. err) end)
			if not success then
				rconsoleprint("Failed to properly register mod!")
				else
	    getgenv().rbxloaderout("Mod Name: " .. module.getver()["name"].. "\n")
	    getgenv().rbxloaderout("Version: " .. module.getver()["version"].. "\n")
	    getgenv().rbxloaderout("Mod Author(s): " .. module.getver()["author"].. "\n")
	    getgenv().rbxloaderout("---------------\n")
	    module.onmodstarted()
	    modsloaded = modsloaded + 1
	    end
	end
end 
getgenv().rbxloaderout("\nLoaded " .. modsloaded .. " mod(s)!")