local Kunkka = {}

Kunkka.optionEnable = Menu.AddOptionBool({"Hero Specific", "Kunkka"}, "ТестовоеПереключение", false)
Kunkka.toggleKey = Menu.AddKeyOption({"Hero Specific", "Kunkka"}, "ТестоваяКнопка", Enum.ButtonCode.KEY_NONE)

local toggled1 = false
local myHero = nil
local dieTime = 0
local myTeam = 0
local StatucScreenPos = {}
StatucScreenPos.x = 0
StatucScreenPos.y = 0



function Kunkka.init()
	if Engine.IsInGame() then
		myHero = Heroes.GetLocal()
		myTeam = Entity.GetTeamNum(myHero)
		dieTime = 0
		if myTeam == 3 then
			base = Vector(7264.000000, 6560.000000, 512.000000)
		else
			base = Vector(-7317.406250, -6815.406250, 512.000000)
		end
		local x, y = Renderer.GetScreenSize()
		StatucScreenPos.x = math.floor(x * 0.594)
		StatucScreenPos.y = math.floor(y * 0.84)
	end
end

Kunkka.init()

function Kunkka.onGameStart()
	Kunkka.init()	
end

function Kunkka.OnUpdata()
	if not myHero or not Menu.IsEnabled(Kunkka.optionEnable) then return end
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_kunkka" then return end

	if Menu.IsKeyDownOnce(Kunkka.toggleKey) then
        if toggled1 == false then
            toggled1 = true
        else
            toggled1 = false
        end
    end

end

function Kunkka.OnDraw()
	if not Menu.IsEnabled(Kunkka.optionEnable) or not Heroes.GetLocal() then return end
	if toggled1 then
        Renderer.SetDrawColor(90, 255, 100)
        Renderer.DrawText(font, StatusScreenPos.x, StatusScreenPos.y, "Значение кнопки: Истина")
    else
        Renderer.SetDrawColor(255, 90, 100)
        Renderer.DrawText(font, StatusScreenPos.x, StatusScreenPos.y, "Значение кнопки: Ложь")
    end
end

return Kunkka
