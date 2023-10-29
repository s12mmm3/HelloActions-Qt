[CmdletBinding()]
param (
    [string] $archiveName, [string] $targetName
)
# 外部环境变量包括:
# archiveName: ${{ matrix.qt_ver }}-${{ matrix.qt_arch }}
# winSdkDir: ${{ steps.build.outputs.winSdkDir }}
# winSdkVer: ${{ steps.build.outputs.winSdkVer }}
# vcToolsInstallDir: ${{ steps.build.outputs.vcToolsInstallDir }}
# vcToolsRedistDir: ${{ steps.build.outputs.vcToolsRedistDir }}
# msvcArch: ${{ matrix.msvc_arch }}


# winSdkDir: C:\Program Files (x86)\Windows Kits\10\ 
# winSdkVer: 10.0.19041.0\ 
# vcToolsInstallDir: C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Tools\MSVC\14.28.29333\ 
# vcToolsRedistDir: C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Redist\MSVC\14.28.29325\ 
# archiveName: 5.9.9-win32_msvc2015
# msvcArch: x86

$scriptDir = $PSScriptRoot
$currentDir = Get-Location
Write-Host "currentDir" $currentDir
Write-Host "scriptDir" $scriptDir

function DeployQt {
    # 定义一个参数，类型为字符串，名为 targetName
    param (
        [string]$targetName
    )

    # 检查文件是否存在
    if (Test-Path -Path "output\bin\$targetName") {
        # 如果文件存在，执行 windeployqt 命令
        windeployqt --qmldir . --plugindir output\plugins --no-translations --compiler-runtime output\bin\$targetName
    } else {
        # 如果文件不存在，输出提示信息
        Write-Host "$targetName does not exist."
    }
}
function Main() {

    # New-Item -ItemType Directory $archiveName
    # # 拷贝生成文件
    # Copy-Item output\\* $archiveName\

    Tree output\ /F
    # 拷贝依赖
    DeployQt -targetName Test.exe
    DeployQt -targetName ApiServer.exe
    DeployQt -targetName QCloudMusicApi.dll
    DeployQt -targetName CApi.dll
    # windeployqt --qmldir . --plugindir output\plugins --no-translations --compiler-runtime output\bin\$targetName
    # # 删除不必要的文件
    # $excludeList = @("*.qmlc", "*.ilk", "*.exp", "*.lib", "*.pdb")
    # Remove-Item -Path $archiveName -Include $excludeList -Recurse -Force
    # # 拷贝vcRedist dll
    # $redistDll="{0}{1}\*.CRT\*.dll" -f $env:vcToolsRedistDir.Trim(),$env:msvcArch
    # Copy-Item $redistDll $archiveName\
    # # 拷贝WinSDK dll
    # $sdkDll="{0}Redist\{1}ucrt\DLLs\{2}\*.dll" -f $env:winSdkDir.Trim(),$env:winSdkVer.Trim(),$env:msvcArch
    # Copy-Item $sdkDll $archiveName\
    # 打包zip
    Compress-Archive -Path output $archiveName'.zip'
}

if ($null -eq $archiveName || $null -eq $targetName) {
    Write-Host "args missing, archiveName is" $archiveName ", targetName is" $targetName
    return
}
Main


