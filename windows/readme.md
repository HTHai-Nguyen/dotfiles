# Create Symboliclink for Windows
### from (-Target) ./dotfiles/windows/ -> $HOME/...

#### Glazewm
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\.glzr\" -Target "S:\Xplat\dotfiles\windows\.glzr\"

```

#### Git
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\.bashrc" -Target "S:\Xplat\dotfiles\windows\git\.bashrc"
New-Item -ItemType SymbolicLink -Path "$HOME\.gitconfig" -Target "S:\Xplat\dotfiles\windows\git\.gitconfig"

```

#### Nushell
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\nushell\" -Target "S:\Xplat\dotfiles\windows\nushell\"

```

#### Powershell
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\Documents\PowerShell\default-omp-theme.txt" -Target "S:\Xplat\dotfiles\windows\powershell\default-omp-theme.txt"
New-Item -ItemType SymbolicLink -Path "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "S:\Xplat\dotfiles\windows\powershell\Microsoft.PowerShell_profile.ps1"

```

#### Scoop
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\.config\scoop\" -Target "S:\Xplat\dotfiles\windows\scoop\"

```

#### Starship
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\.config\starship\" -Target "S:\Xplat\dotfiles\windows\starship\"
New-Item -ItemType SymbolicLink -Path "$HOME\.config\starship.toml" -Target "S:\Xplat\dotfiles\windows\starship\starship.toml"

```

#### WezTerm
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\.config\wezterm\" -Target "S:\Xplat\dotfiles\windows\wezterm\"

```

#### Yasb
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\.config\yasb\" -Target "S:\Xplat\dotfiles\windows\yasb\"

```

#### Yazi
```pwsh
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\yazi\" -Target "S:\Xplat\dotfiles\windows\yazi\"

```

