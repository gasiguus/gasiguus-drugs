local ESX = exports['es_extended']:getSharedObject()

lib.callback.register('gasiguus-huumeet:saakoksua', function(source)
    local itemAmount = math.random(1, 2)
    exports.ox_inventory:AddItem(source, 'kokaiinilehti', itemAmount, nil, nil, nil)
    lib.notify(source, {
        title = 'Kokaiinin keräys',
        description = 'Keräsit kokaiininlehtiä..',
        position = 'top-center',
        type = 'success',
    })
    exports.ox_inventory:RemoveItem(source, 'labralupa', 1, nil, nil, nil)
end)

lib.callback.register('gasiguus-huumeet:saaluvat', function(source)
    exports.ox_inventory:AddItem(source, 'labralupa', 50, nil, nil, nil)
    lib.notify(source, {
        title = 'Ivanin juttelut',
        description = 'Sait labran lupalappuja 50! Kun teet kokaiinia Ivan vie sinulta yhden!',
        position = 'top-center',
        type = 'success',
    })
    exports.ox_inventory:RemoveItem(source, 'koksulappu', 1, nil, nil, nil)
end)

lib.callback.register('gasiguus-huumeet:jatkakokaiini', function(source)
    exports.ox_inventory:RemoveItem(source, 'kokaiinilehti', 10, nil, nil, nil)
    exports.ox_inventory:RemoveItem(source, 'ruokasuoda', 1, nil, nil, nil)
    lib.notify(source, {
        title = 'Kokaiinin jatkaminen',
        description = 'Jatkoit kokaiinia... Jos haluat myydä ne sinun täytyy vielä pakata ne, tarvitset ensin kaupasta jotain...',
        position = 'top-center',
        type = 'success',
    })
    exports.ox_inventory:AddItem(source, 'jatkettukoksu', 1, nil, nil, nil)
end)

lib.callback.register('gasiguus-huumeet:pakkaakoksu', function(source)
    exports.ox_inventory:RemoveItem(source, 'jatkettukoksu', 1, nil, nil, nil)
    exports.ox_inventory:RemoveItem(source, 'pakkaus', 1, nil, nil, nil)
    lib.notify(source, {
        title = 'Kokaiinin jatkaminen',
        description = 'Pakkasit kokaiinin... Nyt voit mennä myymään!',
        position = 'top-center',
        type = 'success',
    })
    exports.ox_inventory:AddItem(source, 'pakattukokaiini', 1, nil, nil, nil)
end)


--[[ESX.RegisterUsableItem('koksulappu', function(source)
    local alert = lib.alertDialog({
        header = 'Hei Reima!',
        content = 'Kirjoitin tämän lapun sinulle, tänään 16.5.2014, että muistaisit käydä meidän vanhalla laboratooriolla tehdäksesi muutaman pakatun kokaiinin, että maksat vihdoin laskusi senkin peijooni!!\nPS. Tässä sinulle salasana: 8EOQ2 Terveisin ystäväsi, Simo.\nLepää rauhassa Reima, 15.5.2014',
        centered = true,
    })
end)]]--
