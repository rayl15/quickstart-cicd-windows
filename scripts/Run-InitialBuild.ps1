[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$BucketName,

    [Parameter(Mandatory=$true)]
    [string]$BuildFilePath
)

try {
    $ErrorActionPreference = "Stop"

    Start-Transcript -Path c:\cfn\log\Run-InitialBuild.ps1.txt -Append
    
    $Arguments = "$BuildFilePath", "/p:BucketName=$BucketName", "/t:Build;Deploy"
    Start-Process "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" -ArgumentList $Arguments -Wait

}
catch {
    Write-Verbose "$($_.exception.message)@ $(Get-Date)"
    $_ | Write-AWSQuickStartException
}