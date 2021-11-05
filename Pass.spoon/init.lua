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
    hs.pasteboard.setContents(obj.pass(selection.text))
end

function obj:bindHotkeys(mapping)
    hs.hotkey.new(mapping["toggle"][1], mapping["toggle"][2], function()
        if self.chooser:isVisible() then
            self.chooser:hide()
        else
            self.chooser:show()
        end
    end):enable()
    return self
end

function obj:init()
    self.chooser = hs.chooser.new(obj.callback)
    self.chooser:rows(5)
    self.chooser:choices(obj.entries())
end

return obj
