if test (uname -s) = "Linux"
	function init-terminal
	end

	function init-syncthing
		function syncthing-xdg
			set -l dir_id $argv[1]
			set -l dir_name $argv[2]
			if test -e $HOME/Sync/$dir_name
				if ! test "$(builtin realpath "$HOME/$dir_name")" = "$HOME/Sync/$dir_name"
					if test -e "$HOME/$dir_name"
						echo ">>> $(set_color green)Preserving existing ~/$dir_name ~/$dir_name.bak...$(set_color reset)"
						mv "$HOME/$dir_name" "$HOME/$dir_name.bak"
					end
					echo ">>> $(set_color green)Linking $dir_name folder...$(set_color reset)"
					ln -rTs "./Sync/$dir_name" "$HOME/$dir_name"
				end
				echo ">>> $(set_color green)Updating XDG folder $dir_id...$(set_color reset)"
				xdg-user-dirs-update --set $dir_id "$HOME/Sync/$dir_name"
			end
		end

		if test -e "$HOME/Sync"
			echo ">> $(set_color green)Configuring XDG for Syncthing$(set_color reset)"
			syncthing-xdg DOCUMENTS Documents
			syncthing-xdg TEMPLATES Templates
			syncthing-xdg MUSIC Music
			syncthing-xdg PICTURES Pictures
			syncthing-xdg VIDEOS Videos
		else
			echo "$(set_color yellow)Syncthing appears to not be configured yet. Run $(set_color blue)init-syncthing$(set_color yellow) after setting up Syncthing.$(set_color reset)"
		end
	end

	function init-desktop
		init-terminal

		echo ">> $(set_color green)Ensuring GUI applications...$(set_color reset)"
		if test -e /usr/sbin/transactional-update
			sudo transactional-update -d --continue pkg install \
				kitty wl-clipboard kdeconnect-kde \
				qsyncthingtray syncthing \
				fira-code-fonts symbols-only-nerd-fonts rubjo-victormono-fonts \
				google-noto-fonts google-noto-serif-cjk-fonts google-noto-sans-cjk-fonts google-noto-coloremoji-fonts
		else if type zypper &> /dev/null
			sudo zypper install \
				kitty wl-clipboard kdeconnect-kde \
				qsyncthingtray syncthing \
				fira-code-fonts symbols-only-nerd-fonts rubjo-victormono-fonts \
				google-noto-fonts google-noto-serif-cjk-fonts google-noto-sans-cjk-fonts google-noto-coloremoji-fonts
		end
		sudo -K

		function ensure-flatpak
			if ! flatpak info --user "$argv[1]" &> /dev/null
				flatpak install --user "$argv[1]"
			end
		end

		echo ">> $(set_color green)Configuring Flatpak...$(set_color reset)"
		flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
		ensure-flatpak com.github.tchx84.Flatseal
		ensure-flatpak dev.deedles.Trayscale

		init-syncthing
	end
end
