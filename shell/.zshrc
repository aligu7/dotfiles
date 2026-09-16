# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    # zsh-syntax-highlighting will be sourced manually later for performance
)

# source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh
# plugins=(git archlinux)  # minimal core plugins
#
# # Lazy-load extra plugins
# zsh-defer source ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-defer source ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZSH/oh-my-zsh.sh

# Manually source zsh-syntax-highlighting last (for speed and correct behavior)
[[ -f ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
# fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/folders in terminal
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias cdcode='cd ~/Documents/code'
alias cdlama='cd ~/Documents/code/lama-trader'
alias cdobs="cd ~/Documents/Obsidian\ Vault/Personal/"
alias night-light-toggle="~/scripts/night-light-toggle.sh"
alias nvim-book-notes="nvim ~/Documents/personal/Books/notes"
alias snvim='sudo -E nvim'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
# Use fzf's own script if installed (faster than subprocess)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

export PATH="$HOME/.local/bin:$PATH"

# Force the calibre-server-pausing wrapper regardless of PATH order
alias calibre="$HOME/.local/bin/calibre"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#a8a8a8'

export MANPAGER="nvim +Man!"
