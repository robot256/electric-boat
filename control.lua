
local function RegisterBoats()
  -- Add boats to Cargo Ships API
  remote.call("cargo-ships", "add_ship", {
      name="eboat", 
      placing_item="eboat", 
      engine="eboat_engine", 
      engine_scale=0.3, 
      engine_at_front=true
    })
    
  remote.call("cargo-ships", "add_boat", {
      name="indep-eboat", 
      placing_item="eboat", 
      rail_version="eboat"
    })
end

local function init()
  RegisterBoats()
end


---- Register Default Events ----
-- init
--script.on_load(init_events)
script.on_init(function()
  log("electric boat on_init")
  init()
  end)
script.on_configuration_changed(function()
  log("electric boat on_configuration_changed")
  init()
  end)
--script.on_event(defines.events.on_runtime_mod_setting_changed, onModSettingsChanged)


------------------------------------------------------------------------------------
--                    FIND LOCAL VARIABLES THAT ARE USED GLOBALLY                 --
--                              (Thanks to eradicator!)                           --
------------------------------------------------------------------------------------
--[[setmetatable(_ENV,{
  __newindex=function (self,key,value) --locked_global_write
    error('\n\n[ER Global Lock] Forbidden global *write*:\n'
      .. serpent.line{key=key or '<nil>',value=value or '<nil>'}..'\n')
    end,
  __index   =function (self,key) --locked_global_read
    error('\n\n[ER Global Lock] Forbidden global *read*:\n'
      .. serpent.line{key=key or '<nil>'}..'\n')
    end ,
  })
--]]
