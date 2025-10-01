function turbo
	if test -f (git workdir)/pnpm-lock.yaml
		corepack pnpm exec turbo $argv
	else
		corepack npx --no-install turbo $argv
	end
end
