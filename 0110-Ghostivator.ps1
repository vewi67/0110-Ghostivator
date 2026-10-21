# 0110 Ghostivator
$ErrorActionPreference = 'Stop'
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class GhostivatorWindow {
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
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
        if ($window -ne [IntPtr]::Zero) { [void][GhostivatorWindow]::ShowWindow($window, 3) }
    } catch {}
    $Host.UI.RawUI.WindowTitle = '0110 Ghostivator | Ghost Series'
    try { Clear-Host } catch {}
    $artPath = Join-Path $PSScriptRoot 'assets\ghost-series-art.txt'
    if (Test-Path -LiteralPath $artPath) {
        $art = Get-Content -LiteralPath $artPath -Raw -Encoding UTF8
        Write-Host $art -ForegroundColor Cyan
    } else {
        Write-Host 'Ghost Series Presents:' -ForegroundColor Cyan
        Write-Host '0110 Ghostivator' -ForegroundColor Cyan
        Write-Host '[The ASCII art file was not found beside the executable.]' -ForegroundColor DarkGray
    }
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
