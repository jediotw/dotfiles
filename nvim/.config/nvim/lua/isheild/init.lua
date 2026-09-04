local M = {}

local current_phase = nil
local timer = nil

local function get_phase()
    local hour = tonumber(os.date("%H"))

    if hour >= 6 and hour < 12 then
        return "morning"
    end

    if hour >= 12 and hour < 18 then
        return "day"
    end

    return "night"
end

local function apply_phase()
    local phase = get_phase()

    if phase == current_phase then
        return
    end

    current_phase = phase

    vim.cmd("colorscheme isheild-" .. phase)

    vim.notify("iSheild → " .. phase)
end

function M.start()
    if timer then
        return
    end

    apply_phase()

    timer = vim.uv.new_timer()

    timer:start(
        1000,
        1000,
        vim.schedule_wrap(function()
            apply_phase()
        end)
    )
end

function M.stop()
    if not timer then
        return
    end

    timer:stop()
    timer:close()
    timer = nil
end

return M
