<div align="center">
    <img src="https://user-images.githubusercontent.com/5807118/140546479-7d826707-8312-4c73-b2e7-9c3952f14cd8.png" width="100" height="100">
</div>

# Pass.spoon

[Hammerspoon](https://www.hammerspoon.org) integration for the [password-store](https://www.passwordstore.org) password manager.

Easily select a password or OTP authentication code to your clipboard with a chooser menu.

## Usage

Install the spoon, and configure the hotkeys for toggling the selection menu.

```
hs.loadSpoon("Pass")

spoon.Pass:bindHotkeys({
    toggle_pass = { { "cmd", "ctrl" }, "p" },
    toggle_otp = { { "cmd", "ctrl" }, "o" },
})
```

## Warning

This utility is still evolving, and should be used at your own risk.

### `pinentry-tty` is not supported

If your _gpg-agent_ is configured to use `pinentry-tty`, you will not be prompted to enter your key's password. To circumvent this, you can either remove the password on your GPG key (_not recommended_) or use a GUI based entry program such as `pinentry-mac`. To enable `pinentry-mac` you can modify `.gnupg/gpg-agent.conf` like so:

```
pinentry-program /usr/local/bin/pinentry-mac
```

## Task List

Planned features:

- [x] Add user-configuration for hotkeys
- [x] Support the `pass-otp` extension
- [ ] Add user-configuration for chooser style
- [ ] Support handling `pinentry-tty`
- [ ] Automatically clear clipboard after a period of time
- [ ] Handle subfolders of passwords, possibly setting the chooser `subText`
- [ ] Lazy load passwords for faster initialization
- [ ] Automatically update entires using a `pathwatcher` on `~/.password-store/`
- [ ] Stylized alerts for errors using logo
- [x] Generate zipped released with GitHub actions


