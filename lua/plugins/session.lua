local config = require("session_manager.config")
local session = require("session_manager")
session.setup({
	autoload_mode = config.AutoloadMode.Disabled,
})
