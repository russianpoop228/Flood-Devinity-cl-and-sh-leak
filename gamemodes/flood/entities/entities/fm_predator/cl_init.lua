include("shared.lua")

function ENT:Draw()
  local wep = LocalPlayer():GetActiveWeapon()
  if wep && wep.IsAsmSWEP then
      if (wep.Status == 2) or (wep.Status == 3) then return end
  end

  local pre = self:GetRenderAngles()
  self:SetRenderAngles(self:GetVelocity():Angle())
  self:DrawModel()
  self:SetRenderAngles(pre)
end
