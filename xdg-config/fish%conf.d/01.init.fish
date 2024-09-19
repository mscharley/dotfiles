if test -f /var/mail/$USER
  export MAILPATH=/var/mail/$USER
end

# Load some overrides for bash scripts.
export BASH_ENV="$HOME/.bashenv"

# Set a default CODE_HOME directory in case one hasn't been configured in zshenv
set -q CODE_HOME || set CODE_HOME "$HOME/Code"
export CODE_HOME

# Configure xz compression to smartly use available processing capacity
export XZ_DEFAULTS="-T 0"

