# 0110 Ghostivator
$ErrorActionPreference = 'Stop'
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class GhostivatorWindow {
    [StructLayout(LayoutKind.Sequential)]
    public struct COORD { public short X; public short Y; }
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("kernel32.dll")] private static extern IntPtr GetStdHandle(int nStdHandle);
    [DllImport("kernel32.dll", SetLastError = true)] private static extern bool SetConsoleDisplayMode(IntPtr hConsoleOutput, uint dwFlags, out COORD lpNewScreenBufferDimensions);
    public static bool TryFullscreen() {
        COORD dimensions;
        return SetConsoleDisplayMode(GetStdHandle(-11), 1, out dimensions);
    }
}
'@
function Show-GhostivatorError {
    param([System.Exception]$Exception)
    Write-Host ""
    Write-Host "[GHOST SIGNAL LOST] 0110 Ghostivator could not complete the operation." -ForegroundColor Red
    Write-Host ("Technical details: {0}" -f $Exception.Message) -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "The ghost hit a wall. No mystery: the details above are the clue." -ForegroundColor Gray
    Write-Host "Press any key to exit..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}
try {
    try {
        $window = [GhostivatorWindow]::GetConsoleWindow()
        if ($window -ne [IntPtr]::Zero) {
            [void][GhostivatorWindow]::ShowWindow($window, 3)
            # Request true console fullscreen where the Windows host supports it.
            [void][GhostivatorWindow]::TryFullscreen()
        }
    } catch {}
    $Host.UI.RawUI.WindowTitle = '0110 Ghostivator | Ghost Series'
    try { Clear-Host } catch {}
    $embeddedArt = @'
                                 .',;+ijti<-;,`.
                             ,>cZh#W8B@@$B%8&MapCu>:.
                          ;x0a8@B%%%%88888888%%B@$BMkU+            -,
                        ,ub%B%88&&&&&888888&&&&&&&&&8B$8qn:   '.    +~
                      'tq8%88888%%%%8888&&&&&8888888&88%B%*v. ,i;``;>;-`
                     ,co%%%B@$@BB%%%8888%B@@B%8&&&88&8888&8#v. ~;      ``
                    `v*%%8Map0JQdW88888&*kdb*8@@B%8888888888*n'`<`
                   `xh&kCj!i//xYpW%%%8%Mwci<!jvJdM888888888&&d<
                  .>m8Wh00paW@$B8%%%BBB@%MapLvjvZW88888888&&bi   .
                  `na8&8%BB&kCvnttjtnOhw0wo%@B@8MW888888888&8hx`'~+    ':
                  ~Q&888&&&#L<;;;----+/<-~nd&88%%%%88888888&8*u,,<'    '~
                 'xd&%88888#L!~~~~~~~~-~+>Xa88888888888888888p>';+..   '>.
         ..''''.`+Xb&%88%%8Mqx~~~~~~~~~~+tOW8888888888888&88#J:.        .
       .`;+!i/xXZa**W%888888&wj-;------+x0*8888888888888888&k/`'`.
     `<xzU0wbaW%B8&&&&88&&&88&hLx!<+>tvJbW888888888888888&8oz;,-<,.
  .!Z*&BBBB%%8&&&&&&&&&&&&&&&&8B8*hkh*W88&8888&&&&&&&&&&&&#C+;+!,     .
  `X&B8&&&WWW&&88%%88&&&&&&&&&&&&8%%8&&WW&&&&&&&&&&&&&&&&MO/+<i+`.    -+
   ./OhM88%%%8W#hqZbW&&&&&&&&&&&&&&WWWW&&&&&&&&&&&&&&&&&&Mqu!!<-:`'.  '<'
       ,+>!i/!+-:`;X*WWW&&WWWWW&&&&&&&WWWWWWW&&&&&&&&&&WWW&kUti!><+-;:,~;
                  `uaWWWWW&WWWWW&WWWWWWWWWWWWWWWWWWWWWWWW&WWMdUvuvvcuji<-,.
                  ./bWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW&Mkm0CLLCUvj>~;.
                  .+ZMWWWWMWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW&&&WWWW&Wohkkbpdbh*bz,
                   ,zaWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM#pZpoWWWWWWWWWWWWWWW&8&u
                   .!qM#MMM#MMM#MM##MM###MM#####MM##MM#aZ0wwpdho#MWW&WWW&WW#qv,
                    ,zoM#############################M#kOmbkkdwmZZmwmmZLYvt+'
                    .~C*#*############################*qLOmmwwwmOLUXvx/>-,'
                     .~C*#*##****###**##############**omJJYvvcvvvuun/!+;,'.
                      .~L*#***************************hZzcvuXznjtt/!+-:,..
                        ;Ua*o*************************hOvxjtxjt/!>~;:,'.
                         `nb*ooo******ooooo*********ooawz/i!!>+-::,`..
                           !OooaaoooooaaaaaooooooooooaadYi><+~-::-,
                            -zpooaaaaaaaaaaaaaaaaaaaaaak0x><+>><+;.  .
                              ;zdoohhaaaaaaaaaaaaaaaaaaabL/++<>;. .  ':
                                ,uqoahhhaaahhaaaaahhaaahhdU!~++.      `,  .'.
                                  'jZhahkhhhhhhhhhhhhhhhhkqX<:`.      .-:'
                                    .iLbhhkkkkhhhhhhhhhhhkhdJ>'      ',
                                      .>Jphhhkbbbbkkkkkkkkkkb0i.   .,.
                                        .:jJmbhhkbbbbbbbbbbbbbqz-
                                           .,+xUZbhahkbdddddddbkpC/.
                                               .,~/vCmdkhkkbbdpppdbmc+.
                                                     .,+/vU0wbkkhkkhhhpQu+.
                                                             `-</txvXUCOwqw0Jzx!~:,,'.  ..`,`,:;;`
                                                                          .`:>uuvcnjt!~-+~:`.
Ghost Series Presents:
0110 Ghostivator
'@
    $artPath = Join-Path $PSScriptRoot 'assets\ghost-series-art.txt'
    if (Test-Path -LiteralPath $artPath) {
        $art = Get-Content -LiteralPath $artPath -Raw -Encoding UTF8
    } else {
        $art = $embeddedArt
    }
    Write-Host $art -ForegroundColor Cyan
    Write-Host ""
    Write-Host "A message is waiting. Its meaning will not appear on this screen." -ForegroundColor Gray
    Write-Host "The file will be written as a continuous stream of binary digits." -ForegroundColor Gray
    Write-Host ""
    Write-Host "Press any key to begin..." -ForegroundColor White
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    $messages = @(
        "You do not need to feel ready before you begin. Readiness often follows action, not the other way around. Choose one meaningful step, do it carefully, and let that completed step become evidence that you can move forward.",
        "Discipline is not a promise that every day will feel easy. It is the decision to keep your commitments when motivation becomes quiet. Make the next task small enough to start, then give it your full attention.",
        "Your future is shaped less by one dramatic moment than by the ordinary choices you repeat. Protect your time, learn from mistakes without turning them into your identity, and keep choosing what matters over what merely distracts you.",
        "Progress can be slow and still be real. A difficult chapter does not define the whole story, and a setback does not erase what you have learned. Take an honest look at what happened, adjust your approach, and continue with purpose.",
        "You are responsible for the effort you bring, not for controlling every outcome. Prepare well, ask for help when you need it, and act with integrity even when nobody is watching. That is how trust in yourself is built.",
        "Do not confuse discomfort with impossibility. New skills often feel awkward before they feel natural. Stay curious, practice deliberately, and measure yourself by what you are learning rather than by how quickly someone else appears to succeed.",
        "A goal becomes more than a wish when you give it a place in your schedule. Decide what matters today, remove one avoidable distraction, and finish the next useful piece of work. Small actions are not beneath ambition; they are how ambition becomes real.",
        "You cannot rewrite yesterday, but you can use its information. Own the mistake, repair what you can, and make a better decision next time. Accountability is not punishment; it is the ability to turn experience into a wiser action.",
        "When the whole problem feels too large, stop trying to solve the whole problem at once. Identify the next step that is clear, safe, and within reach. Do that step, reassess, and let progress reveal the next one.",
        "The work that matters may not earn immediate praise. Do it because the result is worth building, because your word matters, and because the person you become through the process matters too. Keep your standards even when the audience is absent.",
        "Confidence is not certainty that you will never fail. It is trust that you can respond honestly when things go wrong, learn what the experience teaches, and try again with a better plan. Build that trust through actions you can repeat.",
        "You are allowed to change your method without abandoning your purpose. If the current approach is not working, study the evidence and adapt. Persistence means staying committed to meaningful progress, not repeating the same mistake forever."
    )
    $message = Get-Random -InputObject $messages
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    $bytes = $utf8.GetBytes($message)
    $binaryBuilder = New-Object System.Text.StringBuilder
    foreach ($byte in $bytes) {
        [void]$binaryBuilder.Append([Convert]::ToString($byte, 2).PadLeft(8, '0'))
    }
    $binaryMessage = $binaryBuilder.ToString()
    $downloads = Join-Path $env:USERPROFILE 'Downloads'
    if (-not (Test-Path -LiteralPath $downloads)) {
        New-Item -ItemType Directory -Path $downloads -Force | Out-Null
    }
    $zipPath = Join-Path $downloads 'YourMessageIsHere.zip'
    $stageRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('0110-Ghostivator-' + [guid]::NewGuid().ToString('N'))
    $messageFolder = Join-Path $stageRoot 'Your File is Here'
    New-Item -ItemType Directory -Path $messageFolder -Force | Out-Null
    [System.IO.File]::WriteAllText((Join-Path $messageFolder 'message.txt'), $binaryMessage, $utf8)
    Write-Host ""
    Write-Host "Generating your message..." -ForegroundColor Cyan
    $frames = @('[..........]', '[#.........]', '[##........]', '[###.......]', '[####......]', '[#####.....]', '[######....]', '[#######...]','[########..]', '[#########.]', '[##########]')
    for ($i = 0; $i -lt $frames.Count; $i++) {
        Write-Progress -Activity 'Preparing the message' -Status $frames[$i] -PercentComplete ([int](($i + 1) * 100 / $frames.Count))
        Write-Host ("{0}  Encoding message" -f $frames[$i]) -ForegroundColor Cyan
        Start-Sleep -Milliseconds 115
    }
    Write-Progress -Activity 'Preparing the message' -Completed
    if (Test-Path -LiteralPath $zipPath) { Remove-Item -LiteralPath $zipPath -Force }
    Compress-Archive -LiteralPath $messageFolder -DestinationPath $zipPath -CompressionLevel Optimal -Force
    Write-Host ""
    Write-Host "[OK] Your message has been created." -ForegroundColor Green
    Write-Host ("Location: {0}" -f $zipPath) -ForegroundColor White
    Write-Host "The message itself remains hidden from this terminal." -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "Press any key to close 0110 Ghostivator..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}
catch {
    Show-GhostivatorError -Exception $_.Exception
    exit 1
}
