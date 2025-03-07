local assets = { -- The assets table for our mob, using spider assets as a template
    Asset("ANIM", "anim/locust_mob.zip")
}

local function fn()
    local inst = CreateEntity()     -- This function is what creates our entity, we refer to this entity as 'inst' below
                                    -- \/ These are in engine functions used to add the core attributes to our mob
    inst.entity:AddTransform()      -- Transform allows our entity to exist in the world, have a set position, rotation, etc.
    inst.entity:AddAnimState()      -- AnimState allow our entity to exist visually, it also manages animations
    inst.entity:AddSoundEmitter()   -- SoundEmitter allows our entity to create sounds
    inst.entity:AddDynamicShadow()  -- DynamicShadow add a shadow for our entity
    inst.entity:AddNetwork()        -- Network is required for networking purposes

    MakeCharacterPhysics(inst, 10, .5)  -- Basic global function that adds the Physics attribute to our entity,
                                        -- allowing it to interact with the world and other entities
    inst.DynamicShadow:SetSize(1.5, 0.5) -- Here we're setting a shadow for our mob
    inst.Transform:SetFourFaced() -- Here we set how many faced/sides our mob has

    inst.AnimState:SetBank("locust_mob") -- This method sets our mobs bank file (what animations it has)
    inst.AnimState:SetBuild("locust_mob") -- This method sets our mobs build file (what assets it uses)
    inst.AnimState:PlayAnimation("idle") -- This method simply plays the given animation
    
    inst.entity:SetPristine() -- SetPristine tells the game that up to this point we want everything to be set up exactly the same on the server as on the client
    
    
    
    if not TheWorld.ismastersim then -- Here we're checking whether we're running on the server or not
        return inst -- If we're on the client we return our entity
    end
    
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst:AddComponent("locomotor")
    inst:AddComponent("eater")
    -- inst.components.inspectable
    -- Code here will only be run on the server
    

    inst:SetBrain(require("brains/locust_brain"))


  
    return inst -- At the end we return our entity
end
 
return Prefab("locust_mob", fn, assets) -- And we end the file by returning our prefab with the correct fn and assets

