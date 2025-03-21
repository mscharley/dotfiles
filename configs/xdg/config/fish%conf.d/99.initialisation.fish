if test $(uname -s) = "Linux"
	function init-terminal
	end

	function init-desktop
		init-terminal

		echo ">> $(set_color green)Ensuring GUI applications...$(set_color reset)"
		if test -e /usr/sbin/transactional-update
			sudo transactional-update -d --continue pkg install \
				kitty wl-clipboard kdeconnect-kde \
				fira-code-fonts symbols-only-nerd-fonts google-noto-sans-cjk-fonts rubjo-victormono-fonts
		else if type zypper &> /dev/null
			sudo zypper install \
				kitty wl-clipboard kdeconnect-kde \
				fira-code-fonts symbols-only-nerd-fonts google-noto-sans-cjk-fonts rubjo-victormono-fonts
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
		ensure-flatpak com.nextcloud.desktopclient.nextcloud
		ensure-flatpak dev.deedles.Trayscale

		function nextcloud-xdg
			set -l dir_id $argv[1]
			set -l dir_name $argv[2]
			if test -e $HOME/Nextcloud/$dir_name
				if ! test "$(builtin realpath "$HOME/$dir_name")" = "$HOME/Nextcloud/$dir_name"
					if test -e "$HOME/$dir_name"
						echo ">>> $(set_color green)Preserving existing ~/$dir_name ~/$dir_name.bak...$(set_color reset)"
						mv "$HOME/$dir_name" "$HOME/$dir_name.bak"
					end
					echo ">>> $(set_color green)Linking $dir_name folder...$(set_color reset)"
					ln -rTs "./Nextcloud/$dir_name" "$HOME/$dir_name"
				end
				echo ">>> $(set_color green)Updating XDG folder $dir_id...$(set_color reset)"
				xdg-user-dirs-update --set $dir_id "$HOME/Nextcloud/$dir_name"
			end
		end

		echo ">> $(set_color green)Configuring XDG for NextCloud if in use$(set_color reset)"
		if test -e $HOME/Nextcloud
			nextcloud-xdg DOCUMENTS Documents
			nextcloud-xdg TEMPLATES Templates
			nextcloud-xdg MUSIC Music
			nextcloud-xdg PICTURES Pictures
			nextcloud-xdg VIDEOS Videos
		else
			echo "$(set_color yellow)Nextcloud appears to not be configured yet. Run this command again after setting up Nextcloud.$(set_color reset)"
		end
	end
end
