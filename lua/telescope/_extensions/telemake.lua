local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values

COMMAND = "grep -oP '^[a-zA-Z0-9_-]+(?=:)' Makefile | sort -u"

function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

return require("telescope").register_extension {
    exports = {
        telemake = function(opts)
            if file_exists("Makefile") == false then
                return false
            end

            local handle = io.popen(COMMAND)
            local result = handle:read("*a")
            handle:close()

            targets = {}
            for s in result:gmatch("[^\r\n]+") do
                table.insert(targets, s)
            end

            opts = opts or {}
            pickers.new(
                opts,
                {
                    prompt_title = "Makefile Target",
                    finder = finders.new_table {
                        results = targets
                    },
                    sorter = conf.generic_sorter(opts),
                    attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(
                            function()
                                actions.close(prompt_bufnr)
                                local selection = action_state.get_selected_entry()
                                vim.cmd("!make " .. selection[1])
                            end
                        )
                        return true
                    end
                }
            ):find()
        end
    }
}

