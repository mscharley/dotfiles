function turbo
	if test -f (git workdir)/pnpm-lock.yaml
		corepack pnpm exec turbo $argv
	else
		corepack npx turbo $argv
	end
end
