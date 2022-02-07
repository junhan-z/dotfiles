# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Import-Module posh-git
Import-Module oh-my-posh
oh-my-posh --init --shell pwsh --config $HOME/Documents/dotfiles/themes/nahnuj.omp.json | Invoke-Expression

# PSReadline
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Alias
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Git
function gloga { git log --all --oneline --graph }
function gst { git status }
function gd { git diff }
function gdca { git diff --cached }

###################################################
# Note: Keep fzf at the bottom, otherwise it fails #
# Somehow :(                                      #
###################################################
# fzf
# installation
# Install-Module -Name PSFzf -Scope CurrentUser -Force 
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'