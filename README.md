# Pass Spoon

A [password-store](https://www.passwordstore.org) selection utility to be used
in [Hammerspoon](https://www.hammerspoon.org).

## Usage

Install the spoon, and configure the hotkey for toggling the selection menu.

```
hs.loadSpoon("Pass")

spoon.Pass:bindHotkeys({
    toggle = { { "cmd", "ctrl" }, 'p' },
})
```

## Warning

This is beta software, and should be used at your own risk -- contributions are
welcome!

This plugin does not support `pinentry-tty`, but instead requires the use of a
GUI based _pinentry_ program like `pinentry-mac` which can be enabled in your
`.gnupg/gpg-agent.conf` like so:

```
pinentry-program /usr/local/bin/pinentry-mac
```

## Task List

Planned features:

- [x] Add user-configuration for hotkeys
- [ ] Add user-configuration for chooser style
- [ ] Support the `pass-otp` extension
- [ ] Support handling `pinentry-tty`
- [ ] Automatically clear clipboard after a period of time
- [ ] Handle subfolders of passwords, possibly setting the chooser `subText`


