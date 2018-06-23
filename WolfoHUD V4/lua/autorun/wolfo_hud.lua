if CLIENT then
local enableHUD = CreateClientConVar ("hud_toggle", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local enablePing = CreateClientConVar ("hud_enable_ping", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE});
local enablePropCounter = CreateClientConVar ("hud_enable_propcounter", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE});
local enablePropPos = CreateClientConVar ("hud_enable_propposition", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE});
local enablePropPath = CreateClientConVar ("hud_enable_propmodelpath", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE});
local enableAmmo = CreateClientConVar ("hud_enable_ammo", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE});
local enablePropAng = CreateClientConVar ("hud_enable_propangles", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE});
local disableHUD = CreateClientConVar ("hud_remove_default", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE});

local hudwidth = CreateClientConVar("hud_width","0",true,false)
local hudheight = CreateClientConVar("hud_height","0",true,false)
local pingwidth = CreateClientConVar("ping_width","0",true,false)
local pingheight = CreateClientConVar("ping_height","0",true,false)
local propwidth = CreateClientConVar("prop_width","0",true,false)
local propheight = CreateClientConVar("prop_height","0",true,false)

---------------------------------

function HUDOptions(Panel)
	Panel:ClearControls()
	
	local ConVarsDefault = {
		hud_toggle = "1",
		hud_enable_ping = "1",
		hud_enable_propcounter = "1",
		hud_enable_propposition = "1",
		hud_enable_propmodelpath = "1",
		hud_enable_ammo = "1",
		hud_enable_ping = "1",
		hud_enable_propangles = "1",
		hud_remove_default = "1",
		hud_width = "0.00",
		hud_height = "0.00",
		ping_width = "0.00",
		ping_height = "0.00",
		prop_width = "0.00",
		prop_height = "0.00"
	}

	Panel:AddControl( "ComboBox", { MenuButton = 1, Folder = "wolfohud", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

	CheckBox = {}
	CheckBox.Label = "Enable HUD"
	CheckBox.Command = "hud_toggle";
	Panel:AddControl("CheckBox", CheckBox)
	
	CheckBox = {}
	CheckBox.Label = "Enable Ping"
	CheckBox.Command = "hud_enable_ping";
	Panel:AddControl("CheckBox", CheckBox)
	
	CheckBox = {}
	CheckBox.Label = "Enable Objects Counter"
	CheckBox.Command = "hud_enable_propcounter";
	Panel:AddControl("CheckBox", CheckBox)
	
	CheckBox = {}
	CheckBox.Label = "Enable Ammo Counter"
	CheckBox.Command = "hud_enable_ammo";
	Panel:AddControl("CheckBox", CheckBox)
	
	CheckBox = {}
	CheckBox.Label = "Enable Prop Angles Information"
	CheckBox.Command = "hud_enable_propangles";
	Panel:AddControl("CheckBox", CheckBox)
	
	CheckBox = {}
	CheckBox.Label = "Enable Prop Position Information"
	CheckBox.Command = "hud_enable_propposition";
	Panel:AddControl("CheckBox", CheckBox)
	
	CheckBox = {}
	CheckBox.Label = "Enable Prop Model Path"
	CheckBox.Command = "hud_enable_propmodelpath";
	Panel:AddControl("CheckBox", CheckBox)
	
	--CheckBox = {}
	--CheckBox.Label = "Remove Default HUD"
	--CheckBox.Command = "hud_remove_default";
	--Panel:AddControl("CheckBox", CheckBox)
	
	Panel:AddControl("Slider", {
			Label = "HUD's Width",
			Type = "Float",
			Min = "0",
			Max = tostring(ScrW()),
			Command = "hud_width"
		}
	)
	
	Panel:AddControl("Slider", {
			Label = "HUD's Height",
			Type = "Float",
			Min = "0",
			Max = tostring(ScrH()),
			Command = "hud_height"
		}
	)
	
	Panel:AddControl("Slider", {
			Label = "Ping Meter's Width",
			Type = "Float",
			Min = "0",
			Max = tostring(ScrW()),
			Command = "ping_width"
		}
	)
	
	Panel:AddControl("Slider", {
			Label = "Ping Meter's Height",
			Type = "Float",
			Min = "0",
			Max = tostring(ScrH()),
			Command = "ping_height"
		}
	)
	
	Panel:AddControl("Slider", {
			Label = "Objects Counter's Width",
			Type = "Float",
			Min = "0",
			Max = tostring(ScrW()),
			Command = "prop_width"
		}
	)
	
	Panel:AddControl("Slider", {
			Label = "Objects Counter's Height",
			Type = "Float",
			Min = "0",
			Max = tostring(ScrH()),
			Command = "prop_height"
		}
	)
end

function MenuLoading()
	spawnmenu.AddToolMenuOption("Utilities", "User", "HUDMenu", "Wolfo's HUD", "", "", HUDOptions)
end
hook.Add( "PopulateToolMenu", "HUDMenuLoading", MenuLoading )
end

if CLIENT then
local main = surface.GetTextureID("VGUI/main_hud")
local secondary = surface.GetTextureID("VGUI/ammo_hud")
local health = surface.GetTextureID("VGUI/hpbar")
surface.CreateFont( "ScoreboardText", {
	font = "Tahoma", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 16,
	weight = 1000,
	antialias = true
} )

function WeaponInfo()
local pl = LocalPlayer()
if pl:GetNWBool("hud_toggle") != false then
if GetConVarNumber("hud_enable_ammo") == 1 then

	if pl:Alive() and pl:GetActiveWeapon():IsValid() /*and Clip != nil and SecondaryAmmo != nil and OutOfClip != nil */then
	local Clip = pl:GetActiveWeapon():Clip1()
	local OutOfClip = pl:GetAmmoCount(pl:GetActiveWeapon():GetPrimaryAmmoType())
	local SecondaryAmmo = pl:GetAmmoCount(pl:GetActiveWeapon():GetSecondaryAmmoType())
		if not (Clip <= 0 and OutOfClip <= 0) then
		-------------------------
		surface.SetTexture( secondary )  
		surface.SetDrawColor( 0, 0, 0, 200 )
		surface.DrawTexturedRect( 107 + GetConVarNumber("hud_width"), ScrH() - (122 + GetConVarNumber("hud_height")), 120, 24 )
		-------------------------
		surface.SetTexture( secondary )  
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 110 + GetConVarNumber("hud_width"), ScrH() - (125 + GetConVarNumber("hud_height")), 120, 24 )
		draw.WordBox( 8, 135 + GetConVarNumber("hud_width"), ScrH() - (130 + GetConVarNumber("hud_height")), Clip.."/"..OutOfClip.. " | "..SecondaryAmmo,"ScoreboardText",Color(200,0,0,0),Color(0,0,0,255))
		--draw.SimpleText(pl:GetActiveWeapon():GetPrintName(), "ScoreboardText", ScrW() - 215 , ScrH() - 50, Color(0, 25, 143, 255), 110, 110)
		end
	end
end
end
end
hook.Add( "HUDPaint", "DrawSecondaryHUD", WeaponInfo )

function MainHUD() 
if LocalPlayer():GetNWBool("hud_toggle") != false then
	if GetConVarNumber("hud_toggle") == 1 then
	
	local playerhp = LocalPlayer():Health()
	if playerhp >= 100 then
	playerhp = 100
	end
			---------------------------
			surface.SetTexture( main )  
			surface.SetDrawColor ( 0, 0, 0, 200 )  
			surface.DrawTexturedRect( 6 + GetConVarNumber("hud_width"), ScrH() - (124 + GetConVarNumber("hud_height")), 252, 115 )
			---------------------------
			surface.SetTexture( main )  
			surface.SetDrawColor ( 255, 255, 255, 255 )  
			surface.DrawTexturedRect( 12 + GetConVarNumber("hud_width"), ScrH() - (132 + GetConVarNumber("hud_height")), 252, 115 )
			
			local R = 0; G = 255; B = 0;

			if (LocalPlayer():Health() <= 10) then
				R = 255; G = 0; B = 0;
			elseif (LocalPlayer():Health() <= 50) then
				R = 255; G = 200; B = 0;
			elseif (LocalPlayer():Health() <= 75) then
				R = 0; G = 120; B = 0;
			end
			surface.SetTexture( health )  
			surface.SetDrawColor( R, G, B, 150 )
			surface.DrawTexturedRect( 118 + GetConVarNumber("hud_width"), ScrH() - (71 + GetConVarNumber("hud_height")), playerhp + 8, 21 )
			
			draw.WordBox( 8, 150 + GetConVarNumber("hud_width"), ScrH() - (77 + GetConVarNumber("hud_height")), LocalPlayer():Health(),"ScoreboardText",Color(0,0,0,0),Color(255,255,255,255))
			draw.WordBox( 8, 135 + GetConVarNumber("hud_width"), ScrH() - (100 + GetConVarNumber("hud_height")), LocalPlayer():Armor(),"ScoreboardText",Color(0,0,0,0),Color(255,255,255,255))
			draw.WordBox( 8, 175 + GetConVarNumber("hud_width"), ScrH() - (100 + GetConVarNumber("hud_height")), os.date( "%H:%M" ),"ScoreboardText",Color(0,0,0,0),Color(255,255,255,255))
	end
end

end
hook.Add( "HUDPaint", "DrawMainHUD", MainHUD )

hook.Add("HUDShouldDraw", "NoHudFFS", function(Element) if LocalPlayer():GetNWBool("hud_toggle") == true and
(Element == "CHudHealth" or 
Element == "CHudBattery" or 
Element == "CHudAmmo" or 
Element == "CHudSecondaryAmmo") then
return false 
end 
end);



function HUD_MENU()

    local ToggleMenu = vgui.Create("DFrame")
	ToggleMenu:SetPos(25,25)
	ToggleMenu:SetSize(200,75)
	ToggleMenu:SetTitle("Simple Sanbox HUD Menu")
	ToggleMenu:ShowCloseButton( true );
	ToggleMenu:MakePopup()
	
	local toggle = vgui.Create( "DButton", ToggleMenu ) 
	toggle:SetText( "Enable HUD" )
	toggle:SetSize( 100, 50 ) 
	toggle:SetPos(0,25)
	toggle.DoClick = function( ) 
		surface.PlaySound( "ui/buttonclickrelease.wav" ) 
		LocalPlayer():SetNWBool("hud_toggle", true)
	end
	
	local toggle = vgui.Create( "DButton", ToggleMenu ) 
	toggle:SetText( "Disable HUD" )
	toggle:SetSize( 100, 50 ) 
	toggle:SetPos(100,25)
	toggle.DoClick = function( ) 
		surface.PlaySound( "ui/buttonclickrelease.wav" ) 
		LocalPlayer():SetNWBool("hud_toggle", false)
	end
end
concommand.Add( "sbox_hud_menu", HUD_MENU )


function MoreInformations()
	local trace = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	if LocalPlayer():GetNWBool("hud_toggle") != false then
	if trace.Entity~=nil then
		local Angles = tostring(trace.Entity:GetAngles())
		local Position = tostring(trace.Entity:GetPos())
		local Modelinfo = tostring(trace.Entity:GetModel())
		local Ping = tostring(LocalPlayer():Ping())
		local Obj = tostring(LocalPlayer():GetCount( "props" )+LocalPlayer():GetCount( "sents" ))
		
		if trace.Entity:IsValid() then
			if GetConVarNumber("hud_enable_propmodelpath") == 1 then
				draw.WordBox( 8, 25, 25, "Model Path: "..Modelinfo,"ScoreboardText",Color(0,169,255,150),Color(255,255,255,255))
			end
			if GetConVarNumber("hud_enable_propposition") == 1 then
				draw.WordBox( 8, 25, 60, "Posistion: "..Position,"ScoreboardText",Color(0,169,255,150),Color(255,255,255,255))
			end
			if GetConVarNumber("hud_enable_propangles") == 1 then
				draw.WordBox( 8, 25, 95, "Angles: "..Angles,"ScoreboardText",Color(0,169,255,150),Color(255,255,255,255))
			end
		end
			if GetConVarNumber("hud_enable_ping") == 1 then
				draw.WordBox( 8, ScrW()-(100 + GetConVarNumber("ping_width")), 25 + GetConVarNumber("ping_height"), "Ping: "..Ping,"ScoreboardText",Color(0,169,255,100),Color(255,255,255,255))
			end
			if GetConVarNumber("hud_enable_propcounter") == 1 then
				draw.WordBox( 8, ScrW()-(100 + GetConVarNumber("prop_width")), 60 + GetConVarNumber("prop_height"), "Objects: "..Obj,"ScoreboardText",Color(0,169,255,100),Color(255,255,255,255))
			end
	end
	end
end
hook.Add("HUDPaint", "MoreInformations", MoreInformations)
end

if SERVER then
function OMGHALP(pl)
		pl:SetNWBool("hud_toggle", true)
end
hook.Add("PlayerInitialSpawn", "omghalp", OMGHALP)
end
