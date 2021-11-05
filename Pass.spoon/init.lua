local obj = {}

obj.__index = obj

obj.name = "Pass"
obj.version = "0.1"
obj.author = "Colton Padden <colton.padden@fastmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj.pass(name)
    local output, _ = hs.execute("pass " .. name, true)
    local pass = output:match("([^\n]+)\n")
    return pass
end

function obj.otp(name)
    local output, _ = hs.execute("pass otp " .. name, true)
    local pass = output:match("([^\n]+)\n")
    return pass
end

function obj.entries()
    local output, _ = hs.execute("find ~/.password-store -name *.gpg")
    local entries = {}
    for line in output:gmatch("([^\n]+)\n") do
        entries[#entries + 1] = {
            text = line:match("%.password%-store/(.*).gpg"),
        }
    end
    table.sort(entries, function(k1, k2)
        return k1.text < k2.text
    end)
    return entries
end

function obj.callback(selection)
    local target = obj.target or "pass"
    if target == "pass" then
        local p = obj.pass(selection.text)
        if p ~= nil then
            hs.pasteboard.setContents(p)
        end
    elseif target == "otp" then
        local o = obj.otp(selection.text)
        if o ~= nil then
            hs.pasteboard.setContents(o)
        end
    end
    hs.timer.doAfter(10, function()
        hs.pasteboard.clearContents()
    end)
end

function obj:bindHotkeys(mapping)
    if mapping["toggle_pass"] ~= nil and #mapping["toggle_pass"] == 2 then
        hs.hotkey.new(mapping["toggle_pass"][1], mapping["toggle_pass"][2], function()
            obj.target = "pass"
            if not self.chooser:isVisible() then
                self.chooser:show()
            else
                self.chooser:hide()
            end
        end):enable()
    end
    if mapping["toggle_otp"] ~= nil and #mapping["toggle_otp"] == 2 then
        hs.hotkey.new(mapping["toggle_otp"][1], mapping["toggle_otp"][2], function()
            obj.target = "otp"
            if not self.chooser:isVisible() then
                self.chooser:show()
            else
                self.chooser:hide()
            end
        end):enable()
    end
    return self
end

function obj:init()
    self.chooser = hs.chooser.new(obj.callback)
    self.chooser:rows(5)
    self.chooser:choices(obj.entries())
end

return obj
