#!/usr/bin/env zsh

if /usr/libexec/PlistBuddy -c "print ':Window Settings:Matthew'" ~/Library/Preferences/com.apple.Terminal.plist &> /dev/null; then
  print "Terminal settings are already installed."
  exit
fi

if pgrep 'Terminal' &> /dev/null ; then
  echo "Closing Terminal to install configuration..."
  sleep 2
  osascript -e 'tell app "Terminal" to quit'
  while pgrep 'Terminal' &> /dev/null ; do
    sleep 1
  done
fi

/usr/libexec/PlistBuddy -c "add ':Window Settings:Matthew' dict" ~/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "merge '${0:a:h}/Matthew.terminal' ':Window Settings:Matthew'" ~/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "set ':Default Window Settings' 'Matthew'"  ~/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "set ':Startup Window Settings' 'Matthew'" ~/Library/Preferences/com.apple.Terminal.plist

sleep 5
echo "Restarting Terminal."
unset USE_TMUX
unset TMUX
unset TERM
open -F /Applications/Utilities/Terminal.app

cat <<EOF

If you were already using tmux then your old session may still be attached.
To detach it ^A-: then "attach -dt login"
EOF
