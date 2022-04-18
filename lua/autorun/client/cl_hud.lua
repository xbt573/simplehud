local scrW = ScrW()
local scrH = ScrH()
hook.Add("HUDPaint", "DrawHUD", function ()
	local player = LocalPlayer()

	if not player:Alive() then
		return
	end

	local max_width = (scrW / 5)
	local max_sub_width = max_width + 4
	local max_height = 30
	local max_sub_height = max_height + 4

	local x = 10
	local sub_x = 8

	local health_y = scrH - 115
	local suit_y = scrH - 75
	local ammo_y = scrH - 35

	local suitpower = player:Armor()
	local health = player:Health()

	-- Set text color and font
	surface.SetFont("Trebuchet18")
	surface.SetTextColor(255, 255, 255)

	-- Nickname
	surface.SetTextPos(10, scrH - 150)
	surface.DrawText(player:Nick())

	-- Sub-health rect
	surface.SetDrawColor(40, 40, 40)
	surface.DrawRect(sub_x, (scrH - 120) - 2, max_sub_width, max_sub_height)

	-- Available health bar
	surface.SetDrawColor(255, 0, 0)

	local width = (scrW / 5) / 100 -- 1 HP
	surface.DrawRect(x, scrH - 120, width * health, max_height)

	-- Health text
	surface.SetTextPos(12, health_y)
	surface.DrawText("Health: ")

	surface.SetTextPos(max_width - 42, health_y)
	surface.DrawText(health .. "HP")

	-- Sub-suit rect
	surface.SetDrawColor(40, 40, 40)
	surface.DrawRect(sub_x, (scrH - 80) - 2, max_sub_width, max_sub_height)

	-- Suit energy
	surface.SetDrawColor(0, 0, 255)
	surface.DrawRect(x, scrH - 80, width * suitpower, max_height)

	-- Suit text
	surface.SetTextPos(12, suit_y)
	surface.DrawText("Suit: ")

	surface.SetTextPos(max_width - 42, suit_y)
	surface.DrawText(math.floor(suitpower) .. "%")

	-- Sub-ammo rect
	surface.SetDrawColor(40, 40, 40)
	surface.DrawRect(sub_x, (scrH - 40) - 2, max_sub_width, max_sub_height)

	-- Ammo count
	local weapon = player:GetActiveWeapon()

	local ammo_max = weapon:GetMaxClip1() or 0
	local ammo_curr = weapon:Clip1() or 0

	if weapon ~= nil then

		width = (scrW / 5) / ammo_max

		surface.SetDrawColor(255, 205, 1)
		surface.DrawRect(x, scrH - 40, width * ammo_curr, max_height)
	end

	-- Ammo text
	surface.SetTextPos(12, ammo_y)
	surface.DrawText("Ammo: ")

	surface.SetTextPos(max_width - 42, ammo_y)
	surface.DrawText(ammo_curr .. "/" .. ammo_max)


end)

hook.Add( "HUDShouldDraw", "HideHud", function( name )
	if ( name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo"
			or name == "CHudSuitPower" or name == "") then
		return false
	end
end)
