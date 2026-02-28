# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# OPTS
setopt NO_NOTIFY

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF Theme
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# Grim
export GRIM_DEFAULT_DIR="$HOME/Pictures/Screenshots"

# Default Editor
export EDITOR="nvim"

# Eclipse Enterprise
alias eclipse="~/Downloads/eclipse-jee-2022-06-R-linux-gtk-x86_64/eclipse/eclipse"

# Alias nv for NeoVim
alias nv="nvim"

# Zoxide as cd
alias cd="z"

# Judge Alias
alias judge="python3 ~/Coding/python/judge/index.py"

# Alias for GitHub Opener script
alias gop="~/.scripts/zsh/gh_open.sh"

# Scrcpy Alias
alias scopen="scrcpy --no-audio"

# LAMPP Alias
alias lampp="sudo /opt/lampp/lampp"

# Git alias
alias gic="git init && git add . && git commit -m 'feat: project setup' && git branch -M main"
alias gp="git push -u origin main"

# Alias
alias ls="judge exa --icons -la"
alias pokemon-icat="~/.cache/pokemon-icat/pokemon-icat"
alias insomnia="~/Downloads/Insomnia.Core-11.2.0.AppImage"
alias tlauncher="java -jar ~/Downloads/TLauncher.v16/TLauncher.jar"
alias discord="~/Downloads/Discord/Discord"

# Rofi Aliases
alias rofi-launch="/home/aether/.config/rofi/launchers/type-6/launcher.sh"
alias rofi-powermenu="/home/aether/.config/rofi/powermenu/type-6/powermenu.sh"

# Startup Commands
# Startup message display
if [[ -z $TMUX ]]; then
  # toilet "obscura" -f pagga
  # fortune | cowthink
  kotofetch --centered false
  echo
fi

# Start ssh-agent
eval "$(ssh-agent -s)" >/dev/null
ssh-add ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_devsoc >/dev/null 2>&1

# Z Shell Extensions
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Powerlevel10k Theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH=/usr/lib/jvm/java-23/openjdk/bin:$PATH

# bun completions
[ -s "/home/aether/.bun/_bun" ] && source "/home/aether/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Glint Alias
alias glint="source ~/Coding/python/glint/glint/bin/activate && python3 ~/Coding/python/glint/index.py && deactivate"

# ################ Widgets & Scripts ########################

# FILE OPENER (NEOVIM) ######################################
bindkey -s '^N' 'source ~/.scripts/zsh/nvim_opener.sh\n'


eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
. "/home/aether/.deno/env"

# Terminal sounds
precmd() {
    if [[ $? -ne 0 ]]; then
        paplay ~/Documents/Sounds/faah.mp3 --volume=32768 >/dev/null 2>&1 &!
    else
        paplay ~/Documents/Sounds/mouse-click.mp3 --volume=32768 >/dev/null 2>&1 &!
    fi
}
