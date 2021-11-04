# Pass Spoon

A [password-store](https://www.passwordstore.org) selection utility to be used
in [Hammerspoon](https://www.hammerspoon.org).

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

- [ ] Add user configuration for hotkeys and chooser
- [ ] Support the `pass-otp` extension
- [ ] Support handling `pinentry-tty`
- [ ] Automatically clear clipboard after a period of time
- [ ] Handle subfolders of passwords, possibly setting the chooser `subText`


