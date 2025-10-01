function changeset
	if test -f (git workdir)/pnpm-lock.yaml
		corepack pnpm exec changeset $argv
	else
		corepack npx --no-install changeset $argv
	end
end
