local versioninfo = {
    ["name"] = "Example Mod/Plugin",
    ["version"] = "1.0",
    ["author"] = "Tornvrc"
  }
  
local functable = {
  getver = function()
    return versioninfo
  end,
  onmodstarted = function()
    getgenv().rbxloaderout(versioninfo["name"] .. "Example Mod Loaded.")
   end,
}
return functable