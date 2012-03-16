PROMPT='%~> '

export EDITOR='vim'

# use vi keybindings (not the default, which is emacs)
bindkey -v

# interpret simultaneous jk smash as escape (for vi normal mode)
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# cd as if in home directory
cdpath=( ~ )

# allow comments in interactive mode (begin with a #)
setopt interactivecomments

# keep things quiet -- don't beep
setopt no_beep
