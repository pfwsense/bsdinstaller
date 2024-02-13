--
-- This file cleans up after a normal install.
--

return {
	id = "after_install_routines",
	name = _("Post-installation tasks"),
	effect = function(step)
		local cmds = CmdChain.new()

		-- Execute post-install scripts
		App.state.target:cmds_post_install(cmds)

		-- Remove currently active swap used for installation
		if App.state.storage:get_activated_swap():in_units("K") > 0 then
			local spd

			for spd in App.state.sel_part:get_subparts() do
				if spd:get_fstype() == "swap" then
					local dev = spd:get_device_name()
					if App.state.sel_part:set_uefi() == 1 then
						-- only one partition matches
						dev = App.state.sel_part:get_parent():get_device_name() .. "p4"
					end
					-- swap may or may not be mounted
					cmds:add("${root}${SWAPOFF} ${root}dev/" .. dev .. " || true");
				end
			end
		end

		if not cmds:execute() then
			return nil
		end

		-- Force a password change
		TargetSystemUI.set_root_password(App.state.target)

		local cmds2 = CmdChain.new()

		-- Run the necessary cleanups
		App.state.target:cmds_post_cleanup(cmds2)

		if not cmds2:execute() then
			return nil
		end

		return step:next()
	end
}
