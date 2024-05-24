
-- Network convar change
if SERVER then
	util.AddNetworkString("FMNWCVarChanged")
	net.Receive("FMNWCVarChanged", function(_,ply)
		local cvarname = net.ReadString()
		local old = net.ReadString()
		hook.Run("PlayerConvarChanged", ply, cvarname, old, ply:GetInfo(cvarname))
	end)
else
	function cvars.NetworkConvarChange(cvar)
		cvars.AddChangeCallback(cvar, function(_,old,new)
			net.Start("FMNWCVarChanged")
				net.WriteString(cvar)
				net.WriteString(old)
			net.SendToServer()
		end)
	end
end
