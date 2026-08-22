# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
if [[ -z "$FASTFETCH_SHOWN" ]]; then
    fastfetch
    export FASTFETCH_SHOWN=1
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH


# Activate homebrew on startup
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Editor env variable

export EDITOR="nvim"

# Custom functions

export_notes() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Использование: export_notes <строка_для_поиска> <папка_назначения>"
    return 1
  fi

  # 1. Используем $HOME вместо ~ — это железно работает в любых кавычках
  # 2. Обязательно заворачиваем весь путь в кавычки из-за пробелов
  local vault_path="$HOME/Obsidian vaults/Main Vault"
  local dest_path="$2"

  if [ ! -d "$vault_path" ]; then
    echo "Ошибка: База Обсидиана не найдена по пути: $vault_path"
    return 1
  fi

  # Ищем файлы. Флаг -F (Fixed strings) отключает регулярные выражения.
  # Теперь скобки [[ ]] будут восприниматься как обычный текст, а не синтаксис regex.
  local files_found
  files_found=$(grep -rlF "$1" "$vault_path" 2>/dev/null)

  if [ -z "$files_found" ]; then
    echo "Файлы по запросу '$1' не найдены."
    return 0
  fi

  # Создаем целевую папку и копируем
  mkdir -p "$dest_path"
  echo "$files_found" | tr '\n' '\0' | xargs -0 -I {} cp "{}" "$dest_path/"
  
  echo "Готово! Файлы скопированы в $dest_path"
}

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	poetry
)

# For brew-installed apps correct autocompletion
fpath=(/home/linuxbrew/.linuxbrew/share/zsh/site-functions $fpath)

# For zellij autocompletions
fpath=(~/.zsh/completions $fpath)

# Custom function for opencode usage inside zellij
opencode_launcher() {
  echo "Choose OpenCode mode:"
  echo "1) New Session"
  echo "2) Continue Last Session"
  echo "3) Pick from Session History"
  read "choice?Enter choice [1-3]: "
  
  case $choice in
    2) opencode --continue ;;
    3) 
       # Pulls recent sessions via OpenCode CLI and uses fzf to let you pick visually
       local session_id
       session_id=$(opencode session list --format json 2>/dev/null | python3 -c '
import sys, json
try:
data = json.load(sys.stdin)
for s in data:
    print(f"{s.get(\"id\")} | {s.get(\"title\", \"No title\")} | {s.get(\"time\", \"\")}}")
except:
pass
       ' | fzf | awk '{print $1}')
       
       if [ -n "$session_id" ]; then
         opencode --session "$session_id"
       else
         opencode
       fi
       ;;
    *) opencode ;;
  esac
}

source $ZSH/oh-my-zsh.sh

# Shortcut to launch Zellij with a layout
zl() {
  # Defaults to the 'default' layout if no argument is provided
  zellij --layout "${1:-default}"
}

# Autocompletion logic for the 'zl' command
_zl_layouts() {
  local -a layouts
  # Scans the layout directory silently and strips the .kdl extension
  for file in ~/.config/zellij/layouts/*.kdl(N); do
    layouts+=($(basename "$file" .kdl))
  done
  compadd "$@" -a layouts
}

# Bind the autocompletion logic to the 'zl' function
compdef _zl_layouts zl

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias dns-switch="~/.toggle-dns.sh"
alias sp="spotify_player"
alias venv-activate='eval $(poetry env activate)'
alias open="xdg-open"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=~/.npm-global/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# opencode
export PATH=/home/tetrogame/.opencode/bin:$PATH

# Auto cd to pwd when exit yazi
function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}
