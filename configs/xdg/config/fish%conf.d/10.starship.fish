if status is-interactive
	# Load starship if it's available
	if type starship &> /dev/null
		function starship_transient_prompt_func
			starship module character
		end
		function starship_transient_rprompt_func
			starship module time
		end
		starship init fish | source
		enable_transience
	end
end
