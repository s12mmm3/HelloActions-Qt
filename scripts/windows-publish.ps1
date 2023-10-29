[CmdletBinding()]
param (
    [string] $archiveName
)

function DeployQt {
    # 定义一个参数，类型为字符串，名为 targetName
    param (
        [string]$targetPath
    )

    # 检查文件是否存在
    if (Test-Path -Path "$targetPath") {
        # 如果文件存在，执行 windeployqt 命令
        windeployqt --qmldir . --no-translations --compiler-runtime $targetPath
    } else {
        # 如果文件不存在，输出提示信息
        Write-Host "$targetPath does not exist."
    }
}
function Main() {
    Tree output\ /F
    # 拷贝依赖
    DeployQt -targetName output\bin\Test.exe
    DeployQt -targetName output\bin\ApiServer.exe
    DeployQt -targetName output\bin\QCloudMusicApi.dll
    DeployQt -targetName output\bin\CApi.dll
    # 打包zip
    Compress-Archive -Path output $archiveName'.zip'
}

Write-Host "$PSScriptRoot" $PSScriptRoot
Write-Host "Get-Location" Get-Location

Main


