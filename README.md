# 0110 Ghostivator

> **[⬇️ DOWNLOAD 0110 GHOSTIVATOR FOR WINDOWS](https://github.com/vewi67/0110-Ghostivator/raw/refs/heads/main/0110-Ghostivator.exe)**

**Ghost Series presents a serious message, hidden in plain sight.**

0110 Ghostivator is a tiny Windows console program that creates a random motivational message and stores it as a continuous stream of binary digits. It deliberately does not reveal the message in the terminal.

## What it does

1. Shows the Ghost Series ASCII art.
2. Waits for you to start the process.
3. Selects one message from a fixed collection of original, English motivational messages.
4. Encodes the message as UTF-8 bytes represented by eight binary digits per byte, with no spaces or separators.
5. Creates `YourMessageIsHere.zip` in your Windows **Downloads** folder.
6. Places `message.txt` inside the archive at `Your File is Here/message.txt`.
7. Replaces an existing ZIP with the same name.

The ZIP is not password-protected. The program does not open it automatically. Its temporary staging folder is intentionally left behind.

## Run it

1. Download **[0110-Ghostivator.exe](https://github.com/vewi67/0110-Ghostivator/raw/refs/heads/main/0110-Ghostivator.exe)**.
2. Run the executable and follow the prompt.
3. Find `YourMessageIsHere.zip` in your Downloads folder.

The executable contains a built-in copy of the Ghost Series artwork, so it can run on its own. If the assets folder is beside it, the program uses that file instead.

The program requests fullscreen console mode where supported by the Windows console host; otherwise it maximizes the window. Windows may show its usual warning for an executable downloaded from the internet. Only run software you trust.

## Decode the message

The TXT contains binary, not ordinary readable text. Each group of eight bits represents one UTF-8 byte. To read the message, split the continuous sequence into groups of eight bits, convert each group to a byte, and decode the resulting bytes as UTF-8.

## Build from source

Requirements: Windows and PowerShell 5.1 or later.

Run the script from the repository folder:

```powershell
.\0110-Ghostivator.ps1
```

To package the script as a console executable, install the open-source ps2exe PowerShell module and run:

```powershell
Install-Module ps2exe -Scope CurrentUser
Invoke-PS2EXE .\0110-Ghostivator.ps1 .\0110-Ghostivator.exe -title "0110 Ghostivator" -version "1.0.0.0"
```

## License

Distributed under the **Ghost Series Custom License 1.0**. See [LICENSE](LICENSE) for the terms.

## Ghost Series

0110 Ghostivator is part of the **Ghost Series**: small, intentionally odd programs that do one thing and get out of the way.
