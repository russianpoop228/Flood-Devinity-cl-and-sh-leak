
-- Copyright (c) 2018 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local tmpsp = game.SinglePlayer()
local gas_cl_enabled = GetConVar("cl_tfa_fx_gasblur")
local oldshell_cl_enabled = GetConVar("cl_tfa_legacy_shells")

local ScrW, ScrH = ScrW, ScrH
local l_FT = FrameTime
local l_mathClamp = math.Clamp
local sv_cheats_cv = GetConVar("sv_cheats")
local host_timescale_cv = GetConVar("host_timescale")
local ft = 0.01
local LastSys

local BindToKeyTBL = {
	["ctrl"] = KEY_LCONTROL,
	["rctrl"] = KEY_LCONTROL,
	["alt"] = KEY_LALT,
	["ralt"] = KEY_RALT,
	["space"] = KEY_SPACE,
	["caps"] = KEY_CAPSLOCK,
	["capslock"] = KEY_CAPSLOCK,
	["tab"] = KEY_TAB,
	["back"] = KEY_BACKSPACE,
	["backspace"] = KEY_BACKSPACE,
	[0] = KEY_0,
	[1] = KEY_1,
	[2] = KEY_2,
	[3] = KEY_3,
	[4] = KEY_4,
	[5] = KEY_5,
	[6] = KEY_6,
	[7] = KEY_7,
	[8] = KEY_8,
	[9] = KEY_9
}

local alphabet = "abcdefghijklmnopqrstuvwxyz"

for i = 1, string.len(alphabet) do
	local sstr = string.sub( alphabet, i, i )
	BindToKeyTBL[ sstr ] =  string.byte( sstr ) - 86
end


local SoundChars = {
	["*"] = "STREAM",--Streams from the disc and rapidly flushed; good on memory, useful for music or one-off sounds
	["#"] = "DRYMIX",--Skip DSP, affected by music volume rather than sound volume
	["@"] = "OMNI",--Play the sound audible everywhere, like a radio voiceover or surface.PlaySound
	[">"] = "DOPPLER",--Left channel for heading towards the listener, Right channel for heading away
	["<"] = "DIRECTIONAL",--Left channel = front facing, Right channel = read facing
	["^"] = "DISTVARIANT",--Left channel = close, Right channel = far
	["("] = "SPATIALSTEREO_LOOP",--Position a stereo sound in 3D space; broken
	[")"] = "SPATIALSTEREO",--Same as above but actually useful
	["}"] = "FASTPITCH",--Low quality pitch shift
	["$"] = "CRITICAL",--Keep it around in memory
	["!"] = "SENTENCE",--NPC dialogue
	["?"] = "USERVOX"--Fake VOIP data; not that useful
}
local DefaultSoundChar = ")"

local SoundChannels = {
	["shoot"] = CHAN_WEAPON,
	["shootwrap"] = CHAN_STATIC,
	["misc"] = CHAN_AUTO
}


--Scope

local cv_rt

function TFA.RTQuality()
	if not cv_rt then cv_rt = GetConVar("cl_tfa_3dscope_quality") end
	if ( not cv_rt ) or ( cv_rt:GetInt() == -1 ) then
		return math.max( 3 - math.floor( math.min( ScrH(), ScrW() ) / 512 ), 0 )
	elseif cv_rt then
		return math.Clamp( cv_rt:GetInt(), 0, 3 )
	end
end

--Sensitivity

local ss, fov_og, resrat, fov_cv

fov_cv = GetConVar("fov_desired")
function TFA.CalculateSensitivtyScale( fov_target, fov_src, screenscale )
	if not LocalPlayer():IsValid() then return 1 end
	resrat = ScrW() / ScrH()
	fov_og = fov_src or TFADUSKFOV or fov_cv:GetFloat()
	ss = screenscale or 1
	return math.atan( resrat * math.tan(math.rad( fov_target / 2  ) ) ) / math.atan( resrat * math.tan( math.rad( fov_og / 2) ) ) / ss
end

--Ammo

local AmmoTypes = {}

function TFA.AddAmmo( id, name )
	if AmmoTypes[name] then return AmmoTypes[name] end
	AmmoTypes[name] = id

	game.AddAmmoType( {
		name  = id
	})

	if language then
		language.Add( id .. "_ammo", name )
	end

	return id
end

--Particles

function TFA.ParticleTracer( name,startPos,endPos,doWhiz,ent,att)
	if type(ent) ~= "number" and IsValid(ent) and ent.EntIndex then
		ent = ent:EntIndex()
	end
	if ent then
		att = att or -1
		return util.ParticleTracerEx(name,startPos,endPos,doWhiz,ent,att)
	else
		return util.ParticleTracerEx(name,startPos,endPos,doWhiz,0,-1)
	end
end

--Binds

function TFA.BindToKey( bind, default )
	return BindToKeyTBL[ string.lower( bind ) ] or default or KEY_C
end

--Sounds

function TFA.PatchSound( path, kind )
	local pathv
	local c = string.sub(path,1,1)

	if SoundChars[c] then
		pathv = string.sub( path, 2, string.len(path) )
	else
		pathv = path
	end

	local kindstr = kind
	if not kindstr then
		kindstr = DefaultSoundChar
	end
	if string.len(kindstr) > 1 then
		local found = false
		for k,v in pairs( SoundChars ) do
			if v == kind then
				kindstr = k
				found = true
				break
			end
		end
		if not found then
			kindstr = DefaultSoundChar
		end
	end

	return kindstr .. pathv
end

function TFA.AddFireSound( sndname, sndpath)
		sound.Add({
		name = sndname,
		channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
		sound = sndpath
		
	})
end

function TFA.AddWeaponSound( sndname, sndpath)
		sound.Add({
		name = sndname,
		channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
		sound = sndpath
		
	})
end

--Frametime

function TFA.FrameTime()
	return ft
end

--CVar Mediators

function TFA.GetGasEnabled()
end

function TFA.GetLegacyShellsEnabled()
end

local ejectionsmoke_cl_enabled = GetConVar("cl_tfa_fx_ejectionsmoke")
local muzzlesmoke_cl_enabled = GetConVar("cl_tfa_fx_muzzlesmoke")

function TFA.GetMZSmokeEnabled()
end

function TFA.GetEJSmokeEnabled()
end

local ricofx_cl_enabled = GetConVar("cl_tfa_fx_impact_ricochet_enabled")

function TFA.GetRicochetEnabled()
end

--Local function for detecting TFA Base weapons.
function TFA.PlayerCarryingTFAWeapon(ply)
	if not ply then
		if CLIENT then
			if LocalPlayer():IsValid() then
				ply = LocalPlayer()
			else
				return false, nil, nil
			end
		elseif game.SinglePlayer() then
			ply = Entity(1)
		else
			return false, nil, nil
		end
	end

	if not (IsValid(ply) and ply:IsPlayer() and ply:Alive()) then return end
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) then
		if (wep.IsTFAWeapon) then return true, ply, wep end

		return false, ply, wep
	end

	return false, ply, nil
end

function TFA.ScaleH(num)
	return num * (ScrH() / 1080)
end

hook.Add("Think","TFAFrameTimeThink",function()
	ft = (SysTime() - (LastSys or SysTime())) * game.GetTimeScale()

	if ft > l_FT() then
		ft = l_FT()
	end

	ft = l_mathClamp(ft, 0, 1 / 30)

	if sv_cheats_cv:GetBool() and host_timescale_cv:GetFloat() < 1 then
		ft = ft * host_timescale_cv:GetFloat()
	end

	LastSys = SysTime()
end)