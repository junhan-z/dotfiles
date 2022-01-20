# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt bubblesline

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
function gc { git commit }

###################################################
# Note: Keep it at the bottom, otherwise it fails #
# Somehow :(                                      #
###################################################

# fzf
# installation
# Install-Module -Name PSFzf -Scope CurrentUser -Force 
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'