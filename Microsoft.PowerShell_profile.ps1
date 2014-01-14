function Get-GitBranch
{
	$branch = git branch -a 2> $null | Where-Object {$_ -match "^\*"}
	if ($branch -eq $null) {
		return $null;
	}
	
	$branch = $branch.Substring(2)
	
	if ($branch -match "^\(.*\)$") {
		$branch = (git name-rev HEAD 2> $null).Substring(5)
	}
	
	$workdir = ([io.fileinfo](git workdir 2> $null)).basename
	
	"$($workdir):$($branch)"
}

function prompt
{
	$git = Get-GitBranch
	if ($git -ne $null) { 
		$git = "[$git] "
	}
	"$($git)$($executionContext.SessionState.Path.CurrentLocation) $('$' * ($nestedPromptLevel + 1)) "
}