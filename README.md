# SilenTeams
<div align="center">
    <img src="https://github.com/Hypfer/SilenTeams/blob/master/img/header.png" width="704" alt="SilenTeams">
    <p align="center"><h2>Finally, a way to disable taskbar flashing</h2></p>
</div>

# Preamble

So as many of us are painfully aware of, there is _no_ way of disabling taskbar flashing for Microsoft Teams.

Furthermore, it completely ignores the `HKEY_CURRENT_USER\Control panel\Desktop\ForegroundFlashCount` registry key by
just calling `FlashWindowEx` multiple times in a row. Why they do that is beyond me.

This is of course completely unacceptable and insanely harmful to the productivity of a workforce which - caused by
a **pandemic** - is using Teams more than ever.

Even though that it's now December of 2020 with a [Feedback Thread](https://microsoftteams.uservoice.com/forums/555103-public/suggestions/18871387-allow-us-to-turn-of-flashing-taskbar-notifications)
being open since April 2017, nothing about this situation changed.

Therefore, the nuclear option was chosen.

# Description

This repository's release section contains a .dll file, which you can simply throw into your MS Teams installation folder
to forcefully stop it from annoying you any further.

You are of course encouraged to build it yourself instead of just downloading a binary file.
After all, this DLL could in theory inject anything into your Teams Process.

# Installation

Download the SilenTeamsInstaller.ps1 and run it.

# Manual Installation
1. Place the fake `dbghelp.dll` in `%LOCALAPPDATA%\Microsoft\Teams\current` and also copy `C:\Windows\System32\dbghelp.dll`
to `%LOCALAPPDATA%\Microsoft\Teams\current\dbghelp_orig.dll`.

2. Start Teams

3. Enjoy not being disturbed by never-ending taskbar flashing.


Note that this will not survive a Teams updates.
In that case, simply repeat step 1 and be happy again. :)

# How it works

This project is a DLL which pretends to be another DLL which is used by MS Teams and proxys all calls to the original one.

This allows us to inject our own code into Teams which simply overwrites first byte of the `FlashWindowEx` function of
the `user32.dll` in memory with a `0xC3` which is the x86 opcode for `RETN` or something like that.

So basically this no-ops `FlashWindowEx` without any additional functions, trampolines etc, because when building this,
it was discovered that those broke for reasons that are beyond my understanding of computers.

# Misc

Be advised that I usually use JavaScript to solve all my problems. This solution might be very bad, cause crashes and whatnot.
Still, it solves a problem I had, and I'm happy to share it with you.

Feel free to open a PR to enhance it :)

# Sources/Inspiration

[Mutegram](https://github.com/mxs42/mutegram) by [mxs42](https://github.com/mxs42) <br/>
[Windows Privilege Escalation - DLL Proxying](https://itm4n.github.io/dll-proxying/) by [itm4n](https://github.com/itm4n) <br/>
[NoFlashWindow](https://github.com/mrexodia/NoFlashWindow) by [mrexodia](https://github.com/mrexodia) <br/>

[https://en.wikipedia.org/wiki/X86_instruction_listings](https://en.wikipedia.org/wiki/X86_instruction_listings)
