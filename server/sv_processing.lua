--- Events

RegisterNetEvent('ps-weedplanting:server:ProcessBranch', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    for itemName, itemData in pairs(Shared.WeedBranchItems) do
        local item = Player.Functions.GetItemByName(itemName)
        if item and item.info.health then
            if Player.Functions.RemoveItem(itemName, 1, item.slot) then                                             
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove', 1)
                Player.Functions.AddItem(itemData.rewardItem, item.info.health, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemData.rewardItem], 'add', item.info.health)
            end
        elseif item then -- fallback if item.info.health is nil
            if Player.Functions.RemoveItem(itemName, 1, item.slot) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove', 1)
                Player.Functions.AddItem(itemData.rewardItem, Shared.ProcessingHealthFallback, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemData.rewardItem], 'add', Shared.ProcessingHealthFallback)
            end
        end
    end

    ------------------------------- edited parts --------------------------------------------
    local emptyWeedBag = Player.Functions.GetItemByName(Shared.GearItems.EMPTY_WEED_BAG)
    if emptyWeedBag then
        if Player.Functions.RemoveItem(Shared.GearItems.EMPTY_WEED_BAG, 20, emptyWeedBag.slot) then        -- 20 ks vrecusok na travu                                      
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.GearItems.EMPTY_WEED_BAG], 'remove', 20)
        end
    end
    
    -----------------------------------------------------------------------------------------

end)

RegisterNetEvent('ps-weedplanting:server:PackageWeed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    for itemName, itemData in pairs(Shared.WeedItems) do
        local item = Player.Functions.GetItemByName(itemName)
        if item and item.amount >= Shared.PackageAmount then
            Player.Functions.RemoveItem(itemName, Shared.PackageAmount, item.slot)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove', Shared.PackageAmount)
            Player.Functions.AddItem(itemData.rewardItem, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemData.rewardItem], 'add', 1)
        -- else
        --     TriggerClientEvent('QBCore:Notify', src,_U('not_enough_dryweed'), 'error')
        end
    end

    ------------------------------- edited parts --------------------------------------------
    local emptyWeedBag = Player.Functions.GetItemByName(Shared.GearItems.EMPTY_WEED_BAG)
    if emptyWeedBag then
        if Player.Functions.RemoveItem(Shared.GearItems.EMPTY_WEED_BAG, 20, emptyWeedBag.slot) then                                             
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.GearItems.EMPTY_WEED_BAG], 'remove', 20)
        end
    end
    -----------------------------------------------------------------------------------------
end)