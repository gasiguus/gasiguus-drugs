local ESX = exports['es_extended']:getSharedObject()
local koksukerays = { `bkr_prop_coke_table01a` }
local pedi = { `a_m_y_dhill_01` }
local koksujatko = { `bkr_prop_coke_tablepowder` }
local koksupakkaus = { `bkr_prop_coke_mold_01a` }

exports.ox_target:addModel(koksukerays, {
    {
        name = 'koksukerays',
        label = 'Kerää kokaiinia',
        icon = 'fa-solid fa-cannabis',
        items = 'labralupa',
        onSelect = function()
            ExecuteCommand("e mechanic")
            if lib.progressCircle({
                duration = 15000,
                label = 'Keräät kokaiininlehtiä...',
                position = 'middle',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
            }) then
                ExecuteCommand("emotecancel")
            lib.callback.await('gasiguus-huumeet:saakoksua', source)
            end
        end,
    }
})

exports.ox_target:addModel(pedi, {
    {
        name = 'koksupedi',
        label = 'Juttele Ivanille',
        icon = 'fa-solid fa-coins',
        items = 'koksulappu',
        onSelect = function()
            local input = lib.inputDialog('Salasana', {'Syötä salasana:'})
						if not input then return end
						if tonumber(input[1]) > 0 then
							passu = tonumber(input[1])
                if passu == 45632 then
                    lib.notify({
                        title = 'Salasana oikein!!!',
                        type = 'success'
                    })
                    lib.callback.await('gasiguus-huumeet:saaluvat', source)
                        else
				lib.notify({
					title = 'Antamasi salasana ei kelpaa Ivanille...',
				    type = 'warning'
				})
              if not input then
                lib.notify({
                    id = 'wrongpassu',
                    title = 'Salasana',
                    description = 'Et antanut salasanaa...',
                    position = 'top',
                    style = {
                        backgroundColor = '#141517',
                        color = '#C1C2C5',
                        ['.description'] = {
                          color = '#909296'
                        }
                    },
                    icon = 'ban',
                    iconColor = '#C53030'
                })
                end
            end
            end
        end,
    }
})

exports.ox_target:addModel(koksujatko, {
    {
        name = 'koksunjatko',
        label = 'Jatka kokaiinia',
        icon = 'fa-solid fa-cannabis',
        items = 'labralupa',
        items = 'ruokasooda',
        items = 'kokaiinilehti',
        onSelect = function()
            ExecuteCommand("e mechanic")
            if lib.progressCircle({
                duration = 15000,
                label = 'Jatkat kokaiinia...',
                position = 'middle',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
            }) then
                ExecuteCommand("emotecancel")
            lib.callback.await('gasiguus-huumeet:jatkakokaiini', source)
            end
        end,
    }
})

exports.ox_target:addModel(koksupakkaus, {
    {
        name = 'koksunoakkaus',
        label = 'Pakkaa kokaiini',
        icon = 'fa-solid fa-cannabis',
        items = 'labralupa',
        items = 'pakkaus',
        items = 'jatkettukoksu',
        onSelect = function()
            ExecuteCommand("e mechanic")
            if lib.progressCircle({
                duration = 15000,
                label = 'Pakkaat kokaiinia...',
                position = 'middle',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
            }) then
                ExecuteCommand("emotecancel")
            lib.callback.await('gasiguus-huumeet:pakkaakoksu', source)
            end
        end,
    }
})

-- Luodaan pedi
local pedSpawned = {}
local pedPool = {}
CreateThread(function()
	while true do
		local sleep = 1500
        local playerPed = cache.ped
        local pos = GetEntityCoords(playerPed)
		for i=1, #Config.Pedi do
			local dist = #(pos - Config.Pedi[i].coords)
			if dist <= 20 and not pedSpawned[i] then
				pedSpawned[i] = true
                lib.requestModel(Config.Pedi[i].ped, 100)
                lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
				pedPool[i] = CreatePed(28, Config.Pedi[i].ped, Config.Pedi[i].coords.x, Config.Pedi[i].coords.y, Config.Pedi[i].coords.z, Config.Pedi[i].heading, false, false)
				FreezeEntityPosition(pedPool[i], true)
				SetEntityInvincible(pedPool[i], true)
				SetBlockingOfNonTemporaryEvents(pedPool[i], true)
				TaskPlayAnim(pedPool[i], 'mini@strip_club@idles@bouncer@base','base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			elseif dist >= 21 and pedSpawned[i] then
				local model = GetEntityModel(pedPool[i])
				SetModelAsNoLongerNeeded(model)
				DeletePed(pedPool[i])
				SetPedAsNoLongerNeeded(pedPool[i])
                pedPool[i] = nil
				pedSpawned[i] = false
			end
		end
		Wait(sleep)
	end
end)
