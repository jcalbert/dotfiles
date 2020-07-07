#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell:
#   * One line.
#   * VCS info on the right prompt.
#   * Only shows the path on the left prompt by default.
#   * Crops the path to a defined length and only shows the path relative to
#     the current VCS repository root.
#   * Wears a different color wether the last command succeeded/failed.
#   * Shows user@hostname if connected through SSH.
#   * Shows if logged in as root or not.
# ------------------------------------------------------------------------------

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END=❯
PROMPT_ROOT_END=❯❯❯
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b %u%c"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

zstyle ':vcs_info:*+set-message:*' hooks emodir


#zstyle ':vcs_info:*+*:*' debug true
# 127744 Start Emoji block
# 128288 End Emoji block
function str_to_emo() {
  USTART=127744
  UEND=128511
  HASHSTR=$1
  HASHSIZE=$UEND-$USTART

  HASHVAL=0

  for i in {1..${#HASHSTR}}; do;
    THISCHAR=$HASHSTR[$i]
    HASHVAL=$(( $HASHVAL + $((#THISCHAR)) ))
  done
  
  # Avoid 0 as that's black
  HASHSIZE=$(( $HASHSIZE - 1 ))
  HASHVAL=$(( $HASHVAL % $HASHSIZE ))
  HASHVAL=$(( $HASHVAL + 1 ))
  
  HASHHEX=$(echo "obase=16; $USTART+$HASHVAL" | bc)
  echo "\U$HASHHEX"
}

function +vi-emodir() {
    if [[ $1 == 0 ]]
    then
        local emo=$(str_to_emo ${hook_com[base]})
        hook_com[subdir]="${emo}/${hook_com[subdir]}"
        ret=0
    fi
}


# Define prompts.
PROMPT="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
