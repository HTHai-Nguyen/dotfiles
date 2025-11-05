# oh-my-posh
# oh-my-posh init pwsh --config "D:\Application\Scoop\apps\oh-my-posh\current\themes\montys.omp.json" | Invoke-Expression
# -------------------------------
# Oh My Posh theme switcher
# -------------------------------
# Directory where your theme JSON files are stored
$themeDir = "D:\Application\Scoop\apps\oh-my-posh\current\themes"

# File to store the default theme name
$themeConfig = "D:\Application\Scoop\apps\oh-my-posh\default-omp-theme.txt"

# Function to switch theme
function theme {
    param([string]$name)

    if (-not $name) {
        # List all available themes
        Get-ChildItem $themeDir -Filter *.omp.json | ForEach-Object { $_.BaseName }
        return
    }

    $path = Join-Path $themeDir "$name.omp.json"
    if (Test-Path $path) {
        # Apply theme immediately
        oh-my-posh init pwsh --config $path | Invoke-Expression
        Write-Host "Theme set to '$name'" -ForegroundColor Green

        # Save as default for future sessions
        Set-Content -Path $themeConfig -Value $name
    } else {
        Write-Host "Theme '$name' not found!" -ForegroundColor Red
        Write-Host "Available themes:" -ForegroundColor Yellow
        Get-ChildItem $themeDir -Filter *.omp.json | ForEach-Object { $_.BaseName }
    }
}

# -------------------------------
# Load default theme on terminal startup
# -------------------------------

if (Test-Path $themeConfig) {
    $defaultTheme = Get-Content $themeConfig
    $themePath = Join-Path $themeDir "$defaultTheme.omp.json"
    if (Test-Path $themePath) {
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
    }
}


# Icons
# Import-Module Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistoryNoDuplicates:$true
Set-PSReadLineKeyHandler -Chord 'Ctrl+h' -Function ClearHistory
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' `
    -BriefDescription RemoveFromHistory `
    -LongDescription "Removes the content of the current line from history" `
    -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    $toRemove = [Regex]::Escape(($line -replace "\n", "```n"))
    $history = Get-Content (Get-PSReadLineOption).HistorySavePath -Raw
    $history = $history -replace "(?m)^$toRemove\r\n", ""
    Set-Content (Get-PSReadLineOption).HistorySavePath $history
}

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# eza
Remove-Alias ll -Force -ErrorAction SilentlyContinue 
function ll { eza -l --icons --color=auto --color-scale=size --total-size --group-directories-last --no-permissions $args }
function la { eza -la --icons --color=auto --color-scale=size --total-size --group-directories-last --no-permissions $args }
function ls { eza -G --icons --color=auto --group-directories-last --no-permissions $args }
function lt { eza -T -a --icons --color=auto --group-directories-last --no-permissions --hyperlink $args }

# Aliases
Set-Alias -Name "vi"-Value "nvim"
Set-Alias vim nvim
Set-Alias "g" "git"
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias np notepad
Set-Alias tr tree
Set-Alias cls clear
Set-Alias rm 'Remove-Item'

# Aliases for scoop 
function install { scoop install $args }
function search { scoop search $args }
  
# Utilities
function which ($command) 
{
	Get-Command -Name $command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

$env:POWERSHELL_UPDATECHECK = "Off"
