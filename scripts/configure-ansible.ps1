$ErrorActionPreference = 'SilentlyContinue'

$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "C:\temp\ConfigureRemotingForAnsible.ps1"
Write-Host "Download script [ $file ]"
New-Item -ItemType Directory -Force -Path C:\temp
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file -ForceNewSSLCert