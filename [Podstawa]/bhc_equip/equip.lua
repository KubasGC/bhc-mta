ITEM_TYPE_WEAPON 	= 1
ITEM_TYPE_CLIP		= 2
ITEM_TYPE_PARACHUTE	= 3
ITEM_TYPE_KEVLAR	= 4
ITEM_TYPE_APTECZKA 	= 5


local sW, sH = guiGetScreenSize()
local catchedItem = nil
local toggle = false
local confirm = false
local confirmItem = nil
local slotsData = {
	
	--[[ Pierwszy rząd ]]--

	[1] = {
		width = sW / 2 - 247,
		height = sH / 2 - 75
	},

	[2] = {
		width = sW / 2 - 122,
		height =  sH / 2 - 75
	},

	[3] = {
		width = sW / 2 + 3,
		height =  sH / 2 - 75
	},

	[4] = {
		width = sW / 2 + 128,
		height =  sH / 2 - 75
	},

	-- [[ Drugi rząd ]]--

	[5] = {
		width = sW / 2 - 247,
		height = sH / 2 - 5
	},

	[6] = {
		width = sW / 2 - 122,
		height = sH / 2 - 5
	},

	[7] = {
		width = sW / 2 + 3,
		height = sH / 2 - 5
	},

	[8] = {
		width = sW / 2 + 128,
		height = sH / 2 - 5
	},

	-- [[ Trzeci rząd ]]--

	[9] = {
		width = sW / 2 - 247,
		height = sH / 2 + 65
	},

	[10] = {
		width = sW / 2 - 122,
		height = sH / 2 + 65
	},

	[11] = {
		width = sW / 2 + 3,
		height = sH / 2 + 65
	},

	[12] = {
		width = sW / 2 + 128,
		height = sH / 2 + 65
	},

	-- [[ Główne sloty ]] --

	[13] = {
		width = sW / 2 - 232,
		height = sH / 2 - 208
	},

	[14] = {
		width = sW / 2 - 60,
		height = sH / 2 - 208
	},

	[15] = {
		width = sW / 2 + 112,
		height = sH / 2 - 208
	}

}

local dataGUI = {}

function isCursorGet(minX, maxX, minY, maxY)
	if(isCursorShowing() == false) then return end
	local cursorX, cursorY = getCursorPosition()
	cursorX = cursorX * sW
	cursorY = cursorY * sH
	if(cursorX > minX and cursorX < maxX and cursorY > minY and cursorY < maxY) then
		return true
	end
	return false
end

function createGUI()
	dataGUI.okno = guiCreateWindow(0.38, 0.36, 0.25, 0.17, "Potwierdzenie", true)
	guiWindowSetMovable(dataGUI.okno, false)
	guiWindowSetSizable(dataGUI.okno, false)

	dataGUI.label = guiCreateLabel(0.03, 0.20, 0.94, 0.17, "Czy chcesz usunąć ten przedmiot?", true, dataGUI.okno)
	guiLabelSetColor(dataGUI.label, 255, 0, 0)
	guiLabelSetHorizontalAlign(dataGUI.label, "center", false)
	guiLabelSetVerticalAlign(dataGUI.label, "center")
	dataGUI.TAK = guiCreateButton(0.14, 0.69, 0.23, 0.23, "TAK", true, dataGUI.okno)
	dataGUI.NIE = guiCreateButton(0.59, 0.69, 0.23, 0.23, "NIE", true, dataGUI.okno)

	addEventHandler("onClientGUIClick", dataGUI.NIE, hideGUI, false)
	addEventHandler("onClientGUIClick", dataGUI.TAK, deleteItem, false)

	guiSetVisible(dataGUI.okno, false)
end
addEventHandler("onClientResourceStart", resourceRoot, createGUI)

function hideGUI()
	confirmItem = nil
	confirm = false

	guiSetVisible(dataGUI.okno, false)
end

function deleteItem()
	triggerServerEvent("onClientRequestDeleteItem", localPlayer, slotsData[confirmItem].uid)
	hideGUI()
end

function renderEquip()
	if(confirm == true) then return end
	dxDrawRectangle(0, 0, sW, sH, tocolor(255, 255, 255, 150), true) -- białe tło
	dxDrawImage(sW / 2 - 275, sH / 2 - 290, 557, 519, "images/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	
	for k, v in ipairs(slotsData) do
		local alpha = 150
		if(isCursorGet(v.width, v.width + 125, v.height, v.height + 70)) then
			alpha = 255
		end
		dxDrawImage(slotsData[k].width, slotsData[k].height, 125, 70, "images/mid.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

		if(slotsData[k].type ~= nil) then
			if(slotsData[k].type == ITEM_TYPE_WEAPON) then
				dxDrawImage(slotsData[k].width + 4, slotsData[k].height + 4, 115, 66, "images/weapons/"..slotsData[k].val1..".png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
				dxDrawText(slotsData[k].name, slotsData[k].width + 8, slotsData[k].height + 50, slotsData[k].width + 115, slotsData[k].height + 65, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", true, false, true, false, false)
				dxDrawText("Amunicja: "..slotsData[k].val2, slotsData[k].width + 8, slotsData[k].height + 5, slotsData[k].width + 115, slotsData[k].height + 20, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", true, false, true, false, false)
			
				if(catchedItem == k) then
					local x, y = getCursorPosition()
					x = x * sW
					y = y * sH

					dxDrawImage(x - 57.5, y - 33, 115, 66, "images/weapons/"..slotsData[k].val1..".png", 0, 0, 0, tocolor(255, 255, 255, 100), true)
				end

			elseif(slotsData[k].type == ITEM_TYPE_CLIP) then
				dxDrawImage(slotsData[k].width + 4, slotsData[k].height + 4, 115, 66, "images/weapons/ammo.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
				dxDrawText(slotsData[k].name, slotsData[k].width + 8, slotsData[k].height + 50, slotsData[k].width + 115, slotsData[k].height + 75, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", true, false, true, false, false)
				--dxDrawText("Amunicja: "..slotsData[k].val2, slotsData[k].width + 8, slotsData[k].height + 5, slotsData[k].width + 115, slotsData[k].height, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
			
				if(catchedItem == k) then
					local x, y = getCursorPosition()
					x = x * sW
					y = y * sH

					dxDrawImage(x - 57.5, y - 33, 115, 66, "images/weapons/ammo.png", 0, 0, 0, tocolor(255, 255, 255, 100), true)
				end
			elseif(slotsData[k].type == ITEM_TYPE_APTECZKA) then
				dxDrawImage(slotsData[k].width + 4, slotsData[k].height + 4, 115, 66, "images/weapons/heal.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
				dxDrawText(slotsData[k].name, slotsData[k].width + 8, slotsData[k].height + 50, slotsData[k].width + 115, slotsData[k].height + 75, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", true, false, true, false, false)
				dxDrawText("Dodaje "..slotsData[k].val1.."% HP", slotsData[k].width + 8, slotsData[k].height + 5, slotsData[k].width + 115, slotsData[k].height, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
			
				if(catchedItem == k) then
					local x, y = getCursorPosition()
					x = x * sW
					y = y * sH

					dxDrawImage(x - 57.5, y - 33, 115, 66, "images/weapons/heal.png", 0, 0, 0, tocolor(255, 255, 255, 100), true)
				end
			end
		end

		

	end

	dxDrawText("Broń główna", sW / 2 - 234, sH / 2 - 137, sW / 2 - 110, sH / 2 - 119, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, true, false, false)
	dxDrawText("Broń dodatkowa", sW / 2 + 112, sH / 2 - 137, sW / 2 + 236, sH / 2 - 119, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, true, false, false)
	dxDrawText("Broń poboczna", sW / 2 - 59, sH / 2 - 137, sW / 2 + 65, sH / 2 - 119, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, true, false, false)

	if(toggle == true) then
		dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, 200), true)
		dxDrawText("Czekaj...", sW / 2  - 20, sH / 2 - 10, sW / 2 + 20, sH / 2 + 10, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	end
	
end

function onClientClick(button, state, absoluteX, absoluteY)
	if(confirm == true) then return end
	if(toggle == true) then return end
	if(getElementData(localPlayer, "playerSpawned") == false) then return end
	if(getElementData(localPlayer, "toggleEquip") == false) then return end

	if(button == "left") then
		if(state == "down") then
			for k,v in ipairs(slotsData) do
				if(isCursorGet(v.width, v.width + 125, v.height, v.height + 70)) then
					if(catchedItem == nil and slotsData[k].type ~= nil) then
						catchedItem = k
					end
					break
				end
			end
		elseif(state == "up") then
			if(catchedItem ~= nil) then
				if(isCursorGet(sW / 2 - 275, sW / 2 - 275 + 557, sH / 2 - 290, sH / 2 - 290 + 519)) then
					for k,v in ipairs(slotsData) do
						if(isCursorGet(v.width, v.width + 125, v.height, v.height + 70)) then
							if(catchedItem ~= k) then

								if(slotsData[k].type ~= nil) then
									if(slotsData[k].type == 1 and slotsData[catchedItem].type == 2 and slotsData[k].val1 == slotsData[catchedItem].val1) then
										triggerServerEvent("clipEvent", localPlayer, slotsData[catchedItem].uid, slotsData[k].uid)
										toggle = true
										break
									else
										exports.bhc_noti:showBox("Ten slot jest już zajęty.", "Błąd")
										break
									end
								end
								if(getElementData(localPlayer, "playerSpawned") == true) then
									triggerServerEvent("setItemSlot", localPlayer, slotsData[catchedItem].uid, k)
									toggle = true
									break
								end
							end
						end
					end
				else
					confirm = true
					confirmItem = catchedItem

					guiSetVisible(dataGUI.okno, true)

				end
				catchedItem = nil
			end
		end
	elseif(button == "right") then
		if(state == "up") then
			for k,v in ipairs(slotsData) do
				if(isCursorGet(v.width, v.width + 125, v.height, v.height + 70)) then
					if(catchedItem == nil and slotsData[k].type ~= nil) then
						if(slotsData[k].type == ITEM_TYPE_APTECZKA) then
							triggerServerEvent("useItem", localPlayer, slotsData[k].uid)
							toggle = true
							break
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, onClientClick)

function toggleEquip(state)
	if(state == true) then
		addEventHandler("onClientRender", root, renderEquip)
		showCursor(true)
	else
		removeEventHandler("onClientRender", root, renderEquip)
		showCursor(false)
		catchedItem = nil
	end
end
addEvent("toggleEquip", true)
addEventHandler("toggleEquip", root, toggleEquip)

function setToggleFalse()
	toggle = false
end
addEvent("setToggleFalse", true)
addEventHandler("setToggleFalse", root, setToggleFalse)

function setDataTable(table)
	for i=1,15 do
		slotsData[i].uid = nil
		slotsData[i].type = nil
		slotsData[i].name = nil
		slotsData[i].val1 = nil
		slotsData[i].val2 = nil
	end

	for k,v in ipairs(table) do
		slotsData[v.ownerSlot].uid = v.uid
		slotsData[v.ownerSlot].type = v.type
		slotsData[v.ownerSlot].name = v.name
		slotsData[v.ownerSlot].val1 = v.v1
		slotsData[v.ownerSlot].val2 = v.v2
	end
end
addEvent("setDataTable", true)
addEventHandler("setDataTable", root, setDataTable)

function onShoot(weapon)
	triggerServerEvent("playerShoot", localPlayer, weapon)
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onShoot)