function prompt{
  $path = (Get-Location)

  $command = Get-History -Count 1
  $result = FormatElapsedTime($command.EndExecutionTime - $command.StartExecutionTime)

  $branch = (git branch --show-current);
  $status = "";
  if($branch -eq "fatal: not a git repository (or any of the parent directories): .git")
  {
    $branch = "";
  }
  else {
    $changes = (git status -s)
    if($changes -ne $null)
    {
      $status = "*";
    }
  }

  $p = $path
  #$p += $result
  $username = $env:username
  $promptArrow = " >"
  Write-Host $p -NoNewline -ForegroundColor DarkBlue
  Write-Host " " -NoNewline -ForegroundColor Gray
  Write-Host $branch -NoNewline -ForegroundColor DarkGray
  Write-Host $status -NoNewline -ForegroundColor DarkGray
  Write-Host " " -NoNewline -ForegroundColor Gray
  Write-Host $result -ForegroundColor Yellow
  Write-Host $username -NoNewline -ForegroundColor Gray
  Write-Host $promptArrow  -NoNewline -ForegroundColor DarkMagenta
  return " "
}

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

function FormatElapsedTime($ts) 
{
    $elapsedTime = ""

    if($ts.Hours -gt 0)
    {
        $elapsedTime = [string]::Format( "{0:0}h {1:0}m {2:0}s", $ts.Hours, $ts.Minutes, $ts.Seconds);
    }
    if ( $ts.Minutes -gt 0 )
    {
        $elapsedTime = [string]::Format( "{0:0}m {1:0}s", $ts.Minutes, $ts.Seconds);
    }
    else
    {
        if($ts.Seconds -gt 5)
	{
            $elapsedTime = [string]::Format( "{0:0}s", $ts.Seconds);
	}
    }

    return $elapsedTime
}
