$ErrorActionPreference='Stop'
& "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319\csc.exe" /nologo /target:winexe /platform:x64 /r:System.Web.Extensions.dll /out:"$PSScriptRoot\Servidor.exe" "$PSScriptRoot\Servidor.cs"
if($LASTEXITCODE -ne 0){throw 'Falha ao compilar serviço'}
