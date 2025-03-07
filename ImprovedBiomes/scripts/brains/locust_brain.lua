

require "behaviours/wander"
require "behaviours/panic"

local MAX_WANDER_DIST = 32
local SEE_FOOD_DIST = 16

local EATFOOD_CANT_TAGS = { "outofreach" }
local function EatFoodAction(inst)
    local target = FindEntity(inst, -- Here we're trying to find an entity that meets our criteria
        SEE_FOOD_DIST,
        function(item)
            return inst.components.eater:CanEat(item)
                and item:IsOnValidGround()
        end,
        nil,
        EATFOOD_CANT_TAGS
    )
    return target and BufferedAction(inst, target, ACTIONS.EAT) or nil -- If it exists return an EAT action
end

local function ShouldPanic()
    return not TheWorld.state.isday -- Return true if it's night or dusk
end
  
local CMobBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)
  
function CMobBrain:OnStart()
    local root =
        PriorityNode({
            WhileNode(function() return ShouldPanic(self.inst) end, "PanicNight", Panic(self.inst)), -- This is the WhileNode,
                                                                                    -- it's run as long as the given condition is met
            DoAction(self.inst, function() return EatFoodAction(self.inst) end),    -- This node will perform an action returned by the given
            Wander(self.inst, nil, MAX_WANDER_DIST)                                 -- will set status to FAILED if there's no action
        }, 1)
       
    self.bt = BT(self.inst, root)
end
  
return CMobBrain

