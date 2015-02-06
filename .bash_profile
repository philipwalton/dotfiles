# Add `~/bin` and `./bin` to the `$PATH`
export PATH="$HOME/bin:./bin:$PATH"

# Use local node modules as if they're global
export PATH="$PATH:./node_modules/.bin"

# RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# This loads nvm
[ -s "/Users/philipwalton/.nvm/nvm.sh" ] && . "/Users/philipwalton/.nvm/nvm.sh"

# Load aliases from .bash_aliases.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Functions
server() {
  python -m SimpleHTTPServer $1
}

