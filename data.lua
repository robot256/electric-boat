GRAPHICSPATH = "__cargo-ships-graphics__/graphics/"


local eboat_icon = {
  {
    icon = GRAPHICSPATH .. "icons/boat.png",
    icon_size = 64,
    icon_mipmaps = 1,
  },
  {
    icon = "__base__/graphics/icons/battery.png",
    icon_size = 64,
    icon_mipmaps = 4,
    scale = 0.35,
    shift = util.mul_shift(util.by_pixel_hr(-32,-32), 0.35)
  },
}


local speed_modifier = settings.startup["speed_modifier"].value
local fuel_modifier = settings.startup["fuel_modifier"].value
local indep_boat_power = 300 + (speed_modifier -1) * 150

eboat1 = table.deepcopy(data.raw["car"]["indep-boat"])
eboat1.name = "indep-eboat"
eboat1.minable.result = "eboat"
eboat1.icons = eboat_icon
eboat1.burner.fuel_category = "battery"
eboat1.burner.fuel_inventory_size = 1
eboat1.burner.burnt_inventory_size = eboat1.burner.fuel_inventory_size
eboat1.weight = 12000
eboat1.consumption = (indep_boat_power*0.8).."kW"
eboat1.inventory_size = 60
table.remove(eboat1.burner.smoke, 1)

eboat2 = table.deepcopy(data.raw["cargo-wagon"]["boat"])
eboat2.name = "eboat"
eboat2.minable.result = "eboat"
eboat2.icons = eboat_icon
eboat2.placeable_by[1].item = "eboat"
eboat2.placeable_by[2].item = "indep-eboat"
eboat2.inventory_size = 60

eboat_eng = table.deepcopy(data.raw["locomotive"]["boat_engine"])
eboat_eng.name = "eboat_engine"
eboat_eng.burner.fuel_category = "battery"
eboat_eng.burner.fuel_inventory_size = 1
eboat_eng.burner.burnt_inventory_size = eboat_eng.burner.fuel_inventory_size
eboat_eng.consumption = eboat1.consumption
eboat_eng.weight = 7000
table.remove(eboat_eng.burner.smoke, 1)

data:extend{ eboat1, eboat2, eboat_eng }

-- Support for  Schallfalke's Schall Transport Group mod
local subgroup_ship = "water_transport"
local subgroup_shipequip = "water_transport"

if mods["SchallTransportGroup"] then
  subgroup_ship = "water_transport2"
  subgroup_shipequip = "water_equipment"
end


data:extend{
  {
    type = "item-with-entity-data",
    name = "indep-eboat",
    icons = eboat_icon,
    flags = {},
    subgroup = subgroup_ship,
    order = "a[water-system]-f[eboat]",
    place_result = "eboat",
    stack_size = 5,
  },
  {
    type = "item-with-entity-data",
    name = "eboat",
    icons = eboat_icon,
    flags = {},
    subgroup = subgroup_ship,
    order = "a[water-system]-f[eboat]",
    place_result = "indep-eboat",
    stack_size = 5,
  },
  {
    type = "item-with-entity-data",
    name = "eboat_engine",
    icon = "__base__/graphics/icons/engine-unit.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"hidden"},
    subgroup = subgroup_ship,
    order = "a[water-system]-z[eboat_engine]",
    place_result = "eboat_engine",
    stack_size = 5,
  },
    {
    type = "recipe",
    name = "eboat",
    enabled = false,
    energy_required = 3,
    ingredients = {
      {"steel-plate", 40},
      {"engine-unit", 15},
      {"iron-gear-wheel", 15},
      {"electronic-circuit", 6}
    },
    result = "eboat"
  },
  {
    type = "technology",
    name = "electric-boat",
    icons = {
      {
        icon = GRAPHICSPATH .. "technology/water_transport.png",
        icon_size = 256,
        icon_mipmaps = 1,
      },
      {
        icon = "__base__/graphics/icons/battery.png",
        icon_size = 64,
        icon_mipmaps = 4,
        scale = 0.3,
        shift = util.by_pixel(16,16)
      }
    },
    effects = {
      {type="unlock-recipe", recipe="eboat"},
    },
    prerequisites = {"water_transport"},
    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "c-g-a",
  },
}
