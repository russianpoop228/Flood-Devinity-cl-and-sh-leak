if SERVER then
RunConsoleCommand("tfaDamageMultiplier", "1")                -- Multiplier for tfa bullet damage.
RunConsoleCommand("tfaAmmoDetonation", "1")                  -- Enable detonatable tfa Ammo crates? 1 for true, 0 for false.
RunConsoleCommand("tfaDynamicRecoil", "1")                   -- Use Aim-modifying recoil? 1 for true, 0 for false
RunConsoleCommand("tfaDisablePenetration", "1")              -- Disable Penetration and Ricochets? 1 for true, 0 for false
RunConsoleCommand("tfaWeaponStrip", "0")                     -- Allow empty weapon stripping? 1 for true, 0 for false

RunConsoleCommand("Debugtfa", "0")                           -- Debugging for some tfa stuff, turning it on won't change much.

RunConsoleCommand("mp_tfa_precache_sounds", "0")             -- Precache weapon sounds?
RunConsoleCommand("mp_tfa_precache_materials", "0")          -- Precache weapon materials?
RunConsoleCommand("mp_tfa_precache_models", "0")             -- Precache weapon models?
RunConsoleCommand("mp_tfa_precache_icons", "1")              -- Precache spawn/hud icons?

RunConsoleCommand("sv_tfa_attachments_alphabetical", "0")    -- Override weapon attachment order to be alphabetical.
RunConsoleCommand("sv_tfa_attachments_enabled", "1")         -- Display attachment picker?

RunConsoleCommand("sv_tfa_reloads_enabled", "1")             -- Enable reloading? Disabling this allows shooting from ammo pool.
RunConsoleCommand("sv_tfa_sprint_enabled", "1")              -- Enable sprinting? Disabling this allows shooting while IN_SPEED.
RunConsoleCommand("sv_tfa_ironsights_enabled", "1")          -- Enable ironsights? Disabling this still allows scopes.

RunConsoleCommand("sv_tfa_fx_penetration_decal", "1")        -- Enable decals on the other side of a penetrated object?

RunConsoleCommand("sv_tfa_reloads_legacy", "0")              -- -1 to leave unculled.  Anything else is feet*16.

RunConsoleCommand("sv_tfa_worldmodel_culldistance", "-1")    -- -1 to leave unculled.  Anything else is feet*16.

RunConsoleCommand("sv_tfa_arrow_lifetime", "30")             -- Arrow lifetime.

RunConsoleCommand("sv_tfa_holdtype_dynamic", "1")            -- Allow dynamic holdtype?
RunConsoleCommand("sv_tfa_bullet_ricochet", "0")             -- Allow bullet ricochet?
RunConsoleCommand("sv_tfa_bullet_penetration", "0")          -- Allow bullet penetration?

RunConsoleCommand("sv_tfa_scope_gun_speed_scale", "0")       -- Scale player sensitivity based on player move speed?

RunConsoleCommand("sv_tfa_ammo_detonation_chain", "1")       -- Ammo Detonation Chain?  (0=Ammo boxes don't detonate other ammo boxes, 1 you can chain them together)
RunConsoleCommand("sv_tfa_ammo_detonation_mode", "2")        -- Ammo Detonation Mode?  (0=Bullets,1=Blast,2=Mix)
RunConsoleCommand("sv_tfa_ammo_detonation", "1")             -- Ammo Detonation?  (e.g. shoot ammo until it explodes)

RunConsoleCommand("sv_tfa_dynamicaccuracy", "0")             -- Dynamic acuracy?  (e.g.more accurate on crouch, less accurate on jumping.

RunConsoleCommand("sv_tfa_force_multiplier", "1")            -- Arrow force multiplier (not arrow velocity, but how much force they give on impact).
RunConsoleCommand("sv_tfa_spread_multiplier", "1")           -- Increase for more spread, decrease for less.

RunConsoleCommand("sv_tfa_unique_slots", "0")                -- Give TFA-based Weapons unique slots? 1 for true, 0 for false. RESTART AFTER CHANGING.
RunConsoleCommand("sv_tfa_default_clip", "-1")               -- How many clips will a weapon spawn with? Negative reverts to default values.

RunConsoleCommand("sv_tfa_melee_blocking_stun_time", "0.65") -- How long to stun NPCs on block.
RunConsoleCommand("sv_tfa_melee_blocking_stun_enabled", "1") -- Stun NPCs on block?
RunConsoleCommand("sv_tfa_melee_blocking_deflection", "1")   -- For weapons that can deflect bullets ( e.g. certain katans ), can you deflect bullets?  Set to 1 to enable for parries, or 2 for all blocks.
RunConsoleCommand("sv_tfa_melee_blocking_anglemult", "1")    -- Players can block attacks in an angle around their view.  This multiplies that angle.
RunConsoleCommand("sv_tfa_melee_blocking_timed", "1")        -- Enable timed blocking?
RunConsoleCommand("sv_tfa_melee_damage_ply", "0.65")         -- Damage multiplier against players using TFA Melees.
RunConsoleCommand("sv_tfa_melee_damage_npc", "1")            -- Damage multiplier against NPCs using TFA Melees.

RunConsoleCommand("sv_tfa_damage_mult_max", "1")             -- This is the lower range of a random damage factor.
RunConsoleCommand("sv_tfa_damage_mult_min", "1")             -- This is the lower range of a random damage factor.
RunConsoleCommand("sv_tfa_damage_multiplier", "1")           -- Multiplier for TFA base projectile damage.

RunConsoleCommand("sv_tfa_penetration_limit", "0")           -- Number of objects we can penetrate through.

RunConsoleCommand("sv_tfa_allow_dryfire", "0")               -- Allow dryfire?

RunConsoleCommand("sv_tfa_range_modifier", "0")            -- This controls how much the range affects damage.  0.5 means the maximum loss of damage is 0.5.

RunConsoleCommand("sv_tfa_cmenu_key", "-1")                  -- Override the inspection menu key?  Uses the KEY enum available on the gmod wiki. -1 to not.
RunConsoleCommand("sv_tfa_cmenu", "1")                       -- Allow custom context menu?

RunConsoleCommand("sv_tfa_spread_legacy", "0")               -- Use legacy spread algorithms?

RunConsoleCommand("sv_tfa_weapon_strip", "0")                -- Allow the removal of empty weapons? 1 for true, 0 for false

RunConsoleCommand("sv_tfa_soundscale", "1")                  -- Scale times in accordance to timescale?
end

if CLIENT then
RunConsoleCommand("cl_tfa_3dscope_overlay", "0")
RunConsoleCommand("cl_tfa_fx_rtscopeblur_mode", "0")
RunConsoleCommand("cl_tfa_fx_rtscopeblur_intensity", "0.01")
RunConsoleCommand("cl_tfa_fx_ejectionlife", "0.01")
RunConsoleCommand("cl_tfa_viewbob_animated", "0")

end