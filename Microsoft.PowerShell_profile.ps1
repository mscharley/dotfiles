function Get-GitBranch
{
	$git = Get-Command git
	if ($git -eq $null) {
		return $null
	}

	$branch = git branch -a 2> $null | Where-Object {$_ -match "^\*"}
	if ($branch -eq $null) {
		return $null
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
	$exit = $LastExitCode
	if ($exit -eq $null) {
		$exit = 0
	}
	
	$git = Get-GitBranch
	if ($git -ne $null) { 
		$git = "[$git] "
	}
	
	# Reset $LastExitCode so we don't get confusing things happening because of stuff we've run
	cmd /c "exit $($exit)"
	
	# Right prompt
	$rprompt = "[$($exit)]"
	Write-Host (" " * ($host.ui.rawui.windowsize.width - $rprompt.length - 1) + "$($rprompt)`r") -NoNewline -ForegroundColor DarkGray
	
	# Left prompt
	Write-Host ("$($executionContext.SessionState.Path.CurrentLocation) ") -NoNewline -ForegroundColor DarkGreen
	Write-Host ($git) -NoNewline -ForegroundColor DarkRed
	"$('$' * ($nestedPromptLevel + 1)) "
}

function which($cmd)
{
	Get-Command $cmd | Format-List *
}

$env:EDITOR = "notepad++.exe"

Set-Alias ssh plink
Set-Alias scp pscp
# This is the same as ls, include for linux compat
Set-Alias ll Get-ChildItem
function la { Get-ChildItem -Force }
