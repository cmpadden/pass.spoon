local obj = {}

obj.__index = obj

obj.name = "Pass"
obj.version = "0.2"
obj.author = "Colton Padden <colton.padden@fastmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj.pass(name, command, attribute)
    command = obj.command or 'show'
    attribute = obj.attribute or 'password'
    local output, _ = hs.execute("pass " .. command .. " " .. name, true)
    local record = {
        password = output:match("([^\n]+)\n"),
        login = output:match("login: ([^\n]+)\n"),
        url = output:match("url: ([^\n]+)\n"),
    }
    return record[attribute]
end

function obj.choices()
    local output, _ = hs.execute("find ~/.password-store -name *.gpg")
    local choices = {}
    for line in output:gmatch("([^\n]+)\n") do
        choices[#choices + 1] = {
            text = line:match("%.password%-store/(.*).gpg"),
        }
    end
    table.sort(choices, function(k1, k2)
        return k1.text < k2.text
    end)
    return choices
end

function obj.callback(selection)
    local attr = obj.pass(selection.text, obj.command, obj.attribute)
    if attr ~= nil then
        hs.pasteboard.setContents(attr)
    else
        hs.alert.show("No password or OTP code found!")
    end
    hs.timer.doAfter(10, function()
        hs.pasteboard.clearContents()
    end)
end

function obj:toggleChooser()
    if not self.chooser:isVisible() then
        self.chooser:show()
    else
        self.chooser:hide()
    end
end

function obj:bindHotkeys(mapping)
    if mapping["toggle_pass"] ~= nil and #mapping["toggle_pass"] == 2 then
        hs.hotkey.new(mapping["toggle_pass"][1], mapping["toggle_pass"][2], function()
            obj.command = "show"
            obj.attribute = "password"
            obj:toggleChooser()
        end):enable()
    end
    if mapping["toggle_otp"] ~= nil and #mapping["toggle_otp"] == 2 then
        hs.hotkey.new(mapping["toggle_otp"][1], mapping["toggle_otp"][2], function()
            obj.command = "otp"
            obj.attribute = "password"
            obj:toggleChooser()
        end):enable()
    end
    if mapping["toggle_login"] ~= nil and #mapping["toggle_login"] == 2 then
        hs.hotkey.new(mapping["toggle_login"][1], mapping["toggle_login"][2], function()
            obj.command = "show"
            obj.attribute = "login"
            obj:toggleChooser()
        end):enable()
    end
    return self
end

function obj:init()
    self.chooser = hs.chooser.new(obj.callback)
    self.chooser:rows(5)
    self.chooser:choices(obj.choices)
end

return obj
