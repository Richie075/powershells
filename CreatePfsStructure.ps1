param(
    [string]$solutionDir = "D:\SVN\current\up2\global",
    [string]$targetdirectory = "D:\SVN\current\up2\line\bin\x64\Debug"
)

$global:sourceFiles
function GetAllFiles()
{
    $agentSearchPath = Join-Path $solutionDir.Trim(" ") -ChildPath "bin\x64\Debug\Agents"
    Write-Host $agentSearchPath 

    $commonSearchPath = Join-Path $solutionDir.Trim(" ") -ChildPath "bin\x64\Debug\Common"
    Write-Host $commonSearchPath 
    $filesToGather = @($agentSearchPath, $commonSearchPath)
    $info = [string]::Format("Executing: Get-ChildItem -Path {0}", $filesToGather -join ",")    
    $pathes = $filesToGather -join ',' 
    Write-Host $info
    Write-Host $pathes
    $global:sourceFiles = @(Get-ChildItem -Path $agentSearchPath -Recurse | %{$_.FullName})
    $global:sourceFiles += @(Get-ChildItem -Path $commonSearchPath -Recurse | %{$_.FullName})

}

function CopyToRoot()
{$fileList =@(
"Autofac.Configuration",
"Autofac",
"autofacconfig.json",
"autofacconfig.json.template",
"Azure.Core",
"Azure.Identity",
"Castle.Core",
"dds-1.log",
"e_sqlite3",
"JsonConverters",
"Laetus.Common.Dto.EC2Plant",
"Laetus.NT.Base.Common.Logger",
"Laetus.NT.Base.Platform.AgentCommon",
"Laetus.NT.Base.Platform.Contracts",
"Laetus.NT.Base.Platform.PlatformService",
"Laetus.NT.Base.Platform.SDE.DDS",
"Laetus.NT.Base.Platform.SDE.DDS.IDL",
"Laetus.NT.Base.Platform.SDE",
"Laetus.NT.Core.BarcodeParser.Contracts",
"Laetus.NT.Core.BarcodeParser",
"Laetus.NT.Core.Domain.Common",
"Laetus.NT.Core.PersistenceApi",
"Log4Net.Async",
"log4net",
"Microsoft.Bcl.AsyncInterfaces",
"Microsoft.Bcl.HashCode",
"Microsoft.Data.SqlClient",
"Microsoft.Data.SqlClient.SNI.x64",
"Microsoft.Data.SqlClient.SNI.x86",
"Microsoft.Data.Sqlite",
"Microsoft.DotNet.PlatformAbstractions",
"Microsoft.EntityFrameworkCore.Abstractions",
"Microsoft.EntityFrameworkCore",
"Microsoft.EntityFrameworkCore.InMemory",
"Microsoft.EntityFrameworkCore.Proxies",
"Microsoft.EntityFrameworkCore.Relational",
"Microsoft.EntityFrameworkCore.Sqlite",
"Microsoft.EntityFrameworkCore.SqlServer",
"Microsoft.Extensions.Caching.Abstractions",
"Microsoft.Extensions.Caching.Memory",
"Microsoft.Extensions.Configuration.Abstractions",
"Microsoft.Extensions.Configuration.Binder",
"Microsoft.Extensions.Configuration",
"Microsoft.Extensions.Configuration.FileExtensions",
"Microsoft.Extensions.Configuration.Json",
"Microsoft.Extensions.DependencyInjection.Abstractions",
"Microsoft.Extensions.DependencyInjection",
"Microsoft.Extensions.DependencyModel",
"Microsoft.Extensions.FileProviders.Abstractions",
"Microsoft.Extensions.FileProviders.Physical",
"Microsoft.Extensions.FileSystemGlobbing",
"Microsoft.Extensions.Logging.Abstractions",
"Microsoft.Extensions.Logging.Configuration",
"Microsoft.Extensions.Logging.Console",
"Microsoft.Extensions.Logging",
"Microsoft.Extensions.Options.ConfigurationExtensions",
"Microsoft.Extensions.Options",
"Microsoft.Extensions.Primitives",
"Microsoft.Identity.Client",
"Microsoft.Identity.Client.Extensions.Msal",
"Microsoft.IdentityModel.JsonWebTokens",
"Microsoft.IdentityModel.Logging",
"Microsoft.IdentityModel.Protocols",
"Microsoft.IdentityModel.Protocols.OpenIdConnect",
"Microsoft.IdentityModel.Tokens",
"nddsc",
"nddscore",
"nddscpp",
"nddsdotnet461",
"nddstransporttcp",
"NDDS_DISCOVERY_PEERS",
"Newtonsoft.Json",
"NodaTime",
"Optional",
"PlatformConsoleApp.exe",
"PlatformConsoleApp.exe.config",
"PlatformServiceWindowsService.exe",
"PlatformServiceWindowsService.exe.config",
"PlatformServiceWindowsService.exe.config.TEMPLATE",
"PortDomainPairs.config",
"rticonnextmsgdotnet461",
"SQLitePCLRaw.batteries_v2",
"SQLitePCLRaw.core",
"SQLitePCLRaw.nativelibrary",
"SQLitePCLRaw.provider.dynamic_cdecl",
"StartPo.exe",
"System.Buffers",
"System.Collections.Immutable",
"System.ComponentModel.Annotations",
"System.Configuration.ConfigurationManager",
"System.Diagnostics.DiagnosticSource",
"System.IdentityModel.Tokens.Jwt",
"System.Memory",
"System.Numerics.Vectors",
"System.Runtime.CompilerServices.Unsafe",
"System.Security.AccessControl",
"System.Security.Cryptography.ProtectedData",
"System.Security.Permissions",
"System.Security.Principal.Windows",
"System.Text.Encodings.Web",
"System.Text.Json",
"System.Threading.Tasks.Extensions",
"System.ValueTuple",
"USER_QOS_PROFILES.xml")
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $targetdirectory -force
    }
}
}
function CopyToCommon()
{
$fileList =@(
    "Autofac.Integration.Owin.dll",
    "Autofac.Integration.SignalR.dll",
    "Autofac.Integration.WebApi.dll",
    "Autofac.Integration.WebApi.Owin.dll",
    "Laetus.NT.Base.Platform.BaseAgent.dll",
    "Laetus.NT.Base.Platform.HmiAgent.dll",
    "Laetus.NT.Base.Platform.SdeContext.dll",
    "Laetus.NT.Core.Auth.Client.dll",
    "Laetus.NT.Core.Authentication.Contracts.dll",
    "Laetus.NT.Core.Domain.Common.dll",
    "Laetus.NT.Core.Domain.Repositories.dll",
    "Laetus.NT.Core.Domain.Services.dll",
    "Microsoft.AspNet.SignalR.Core.dll",
    "Microsoft.Owin.Cors.dll",
    "Microsoft.Owin.dll",
    "Microsoft.Owin.FileSystems.dll",
    "Microsoft.Owin.Host.HttpListener.dll",
    "Microsoft.Owin.Host.SystemWeb.dll",
    "Microsoft.Owin.Hosting.dll",
    "Microsoft.Owin.Security.Cookies.dll",
    "Microsoft.Owin.Security.dll",
    "Microsoft.Owin.Security.OAuth.dll",
    "Microsoft.Owin.StaticFiles.dll",
    "MigraDoc.DocumentObjectModel.dll",
    "MigraDoc.Rendering.dll",
    "MigraDoc.RtfRendering.dll",
    "Owin.dll",
    "Swashbuckle.Core.dll",
    "System.Net.Http.Formatting.dll",
    "System.Web.Cors.dll",
    "System.Web.Http.dll",
    "System.Web.Http.Owin.dll")
$commonFolder = Join-Path $agentsfolder "Common"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $commonFolder -force
    }
}
}

function CopyToCpm()
{
$fileList =@(
    "Laetus.NT.Core.CodePoolManagement.Agent.dll",
    "Laetus.NT.Core.CodePoolManagement.CodeSupplier.dll",
    "Laetus.NT.Core.CodePoolManagement.Common.dll",
    "Laetus.NT.Core.CodePoolManagement.Counters.dll",
    "Laetus.NT.Core.CodePoolManagement.DomainParticipation.dll",
    "Laetus.NT.Core.CodePoolManagement.Generator.dll",
    "Laetus.NT.Core.CodePoolManagement.Level4Interface.dll",
    "Laetus.NT.Core.CodePoolManagement.Manager,dll")
    $cpm = Join-Path $agentsfolder "Laetus.NT.Core.CodePoolManagement.Agent"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = @($global:sourceFiles -match $fileList[$i])
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $cpm -force
    }
}
}

function CopyControlPanel()
{
$fileList =@(
    "Laetus.NT.Core.ControlPanel.dll")
    $cp = Join-Path $agentsfolder "Laetus.NT.Core.ControlPanel"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $cp -force
    }
}
CopyFrontend "control-panel\agent\agent\Frontend" $cp
}

function CopyEc()
{
$fileList =@(
    "Laetus.Common.Dto.Aux.dll",
    "Laetus.Common.Dto.EC2Plant.dll",
    "Laetus.NT.Core.EC.Agent.dll",
    "Laetus.NT.Core.EC.Manager.dll")
    $ec = Join-Path $agentsfolder "Laetus.NT.Core.EC.Agent"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $ec -force
    }
}
}

function CopyMapping()
{
$fileList =@(
    "Laetus.NT.Core.MappingEditor.Agent.dll")
    $mp = Join-Path $agentsfolder "Laetus.NT.Core.MappingEditor.Agent"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $mp -force
    }
}
CopyFrontend "mapping-editor\agent\agent\Frontend" $mp
}

function CopyMdm()
{
$fileList =@(
    "Laetus.NT.Core.MasterDataManager.Agent.dll",
    "Laetus.NT.Core.MasterDataManager.Manager.dll")
    $md = Join-Path $agentsfolder "Laetus.NT.Core.MasterDataManager.Agent"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $md -force
    }
}
CopyFrontend "mdm\agent\agent\Frontend" $md
}

function CopyPcs()
{
$fileList =@(
    "Laetus.NT.Core.PCSManager.Agent.dll",
    "Laetus.NT.Core.PCSManager.Manager.dll")
    $pcs = Join-Path $agentsfolder "Laetus.NT.Core.PCSManager.Agent"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $pcs -force
    }
}
CopyFrontend "pcsm\agent\agent\Frontend" $pcs
}

function CopyAudit()
{
$fileList =@(
    "Laetus.NT.Core.Platform.AuditTrail.dll")
    $audit = Join-Path $agentsfolder "Laetus.NT.Core.Platform.AuditTrail"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $audit -force
    }
}
CopyFrontend "audit-trail\agent\agent\Frontend" $audit
}

function CopyPom()
{
$fileList =@(
    "Laetus.NT.Core.POManager.Agent.dll",
"Laetus.NT.Core.POManager.Contracts.dll",
"Laetus.NT.Core.POManager.Manager.dll",
"PdfSharp.Charting.dll",
"PdfSharp.dll")
    $pom = Join-Path $agentsfolder "Laetus.NT.Core.POManager.Agent"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $pom -force
    }
}
CopyFrontend "pom\agent\agent\Frontend" $pom
}
function CopyImport()
{
$fileList =@(
    "Laetus.NT.Core.USCExportImport.dll")
    $imp = Join-Path $agentsfolder "Laetus.NT.Core.USCExportImport"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $imp -force
    }
}
CopyFrontend "usc-export-import\agent\agent\Frontend" $imp
}

function CopySea()
{
$fileList =@(
    "ClearScript.Core",
"ClearScript.V8",
"ClearScriptV8.win-x64.dll",
"Laetus.NT.Core.ScriptExecutionAgent.dll",
"Laetus.NT.Core.ScriptExecutionContext.dll",
"Laetus.NT.Core.ScriptExecutionContracts.dll",
"Laetus.NT.Core.ScriptExecutionEngine.dll")
    $sea = Join-Path $agentsfolder "Laetus.NT.Core.ScriptExecutionAgent"
for ($i=0; $i -lt $fileList.length; $i++){ 
    [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
    $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
    for ($j=0; $j -lt $sourceFiles.length; $j++){ 
        Copy-Item -Path $sourceFiles[$j] -Destination $sea -force
    }
}
}

function CopyAuth()
{
    $file = "DummyAuthAgent.dll"
    $dummy = Join-Path $agentsfolder "DummyAuthAgent"
    [String[]]$sourceFiles = $global:sourceFiles -match $file
    $sourceFiles += @($global:sourceFiles -match $file.Replace(".dll",".pdb"))
    for ($i=0; $i -lt $sourceFiles.length; $i++){ 
        Copy-Item -Path $sourceFiles[$i] -Destination $dummy -force
        }
    $file = "Laetus.NT.Core.Authentication.Agent.dll"
    [String[]]$sourceFiles = $global:sourceFiles -match $file
    $sourceFiles += @($global:sourceFiles -match $file.Replace(".dll",".pdb"))
    $auth = Join-Path $agentsfolder "Laetus.NT.Core.Authentication.Agent"
    for ($i=0; $i -lt $sourceFiles.length; $i++){ 
        Copy-Item -Path $sourceFiles[$i] -Destination $auth -force
        }
}

function CopyDeviceReflector()
{
    $fileList =@(
        "Laetus.NT.Core.DeviceReflector.API.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDriverCommon.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.CmdBasedDdCommon.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.Cocam.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.CognexVision8000.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.CommonCamera.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.CrevisIOModule.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.DominoDPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.DominoGPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.DummyDeviceDriver.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.Et200spIOModule.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.HandScannerModule.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.ICam.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.Inspector.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.Lector.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.MatthewsPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.Mi2200Printer.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.MiNgpclPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.MiSmartDatePrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.NetworkParticipantWatcher.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.NiceLabelPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.OpcUaPackerModule.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.ReaPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.VideojetPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.VideojetZipherPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.WillettPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.WolkePrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceDrivers.ZebraPrinter.dll",
"Laetus.NT.Core.DeviceReflector.DeviceReflectorAgent.dll")
        $device = Join-Path $agentsfolder "Laetus.NT.Core.DeviceReflector.DeviceReflectorAgent"
    for ($i=0; $i -lt $fileList.length; $i++){ 
        [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
        $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
        for ($j=0; $j -lt $sourceFiles.length; $j++){ 
            Copy-Item -Path $sourceFiles[$j] -Destination $device -force
        }
    }
    }

    function CopyHmi()
{
    $fileList =@(
        "Laetus.NT.Core.HMI.Agent.dll",
"Laetus.NT.Core.HMI.Authentication.dll",
"Laetus.NT.Core.HMI.Common.dll",
"Laetus.NT.Core.HMI.Contracts.dll",
"Laetus.NT.Core.HMI.Entities.dll",
"Laetus.NT.Core.HMI.Services.dll",
"Laetus.NT.Core.HMI.Web.dll")
        $hmi = Join-Path $agentsfolder "Laetus.NT.Core.HMI.Agent"
    for ($i=0; $i -lt $fileList.length; $i++){ 
        [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
        $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
        for ($j=0; $j -lt $sourceFiles.length; $j++){ 
            Copy-Item -Path $sourceFiles[$j] -Destination $hmi -force
        }
    }
    CopyLineFrontend $hmi
    }

    function CopyLine()
{
    $fileList =@(
        "Laetus.NT.Core.Line.Agent.dll",
"StaMa")
        $line = Join-Path $agentsfolder "Laetus.NT.Core.Line.Agent"
    for ($i=0; $i -lt $fileList.length; $i++){ 
        [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
        $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
        for ($j=0; $j -lt $sourceFiles.length; $j++){ 
            Copy-Item -Path $sourceFiles[$j] -Destination $line -force
        }
    }
    }

    function CopyCameraServer()
    {
        $fileList =@(
            "Laetus.NT.Core.Platform.Cameraserver.Agent.dll")
            $cameraServer = Join-Path $agentsfolder "Laetus.NT.Core.Platform.Cameraserver.Agent"
        for ($i=0; $i -lt $fileList.length; $i++){ 
            [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
            $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
            for ($j=0; $j -lt $sourceFiles.length; $j++){ 
                Copy-Item -Path $sourceFiles[$j] -Destination $cameraServer -force
            }
        }
        }
function CopyFrontend($source, $target)
{
    $sourcePath = Join-Path $solutionDir.Trim(" ") -ChildPath $source
    $targetPath = Join-Path $target -ChildPath "Frontend"
    Copy-Item $sourcePath -Destination $targetPath -Recurse -Force
}

function CopyLineFrontend($target)
{
    $sourcePath = Join-Path $solutionDir.Trim(" ") -ChildPath "hmi\web\public"
    $targetPath = Join-Path $target -ChildPath "Frontend"
    Copy-Item $sourcePath -Destination $targetPath -Recurse -Force
}
function CreateTargetStructure()
{
      if(-NOT (Test-Path($targetdirectory)))
      {
            New-Item -Path $targetdirectory -ItemType Directory
      } 
      #CopyToRoot
            $agentsFolder = Join-Path $targetdirectory "agents"
            if(-NOT (Test-Path($agentsFolder)))
            {
                New-Item -Path $agentsFolder -ItemType Directory 
            }
            $commonFolder = Join-Path $agentsfolder "Common"
            if(-NOT (Test-Path($commonFolder)))
            {
                New-Item -Path $commonFolder -ItemType Directory 
            }
            CopyToCommon
            $auth = Join-Path $agentsfolder "Laetus.NT.Core.Authentication.Agent"
            if(-NOT (Test-Path($auth)))
            {
                New-Item -Path $auth -ItemType Directory 
            }
            $dummy = Join-Path $agentsfolder "DummyAuthAgent"
            if(-NOT (Test-Path($dummy)))
            {
                New-Item -Path $dummy -ItemType Directory 
            }
            CopyAuth
            $cpm = Join-Path $agentsfolder "Laetus.NT.Core.CodePoolManagement.Agent"
            if(-NOT (Test-Path($cpm)))
            {
                New-Item -Path $cpm -ItemType Directory 
            }
            CopyToCpm
            $cp = Join-Path $agentsfolder "Laetus.NT.Core.ControlPanel"
            if(-NOT (Test-Path($cp)))
            {
                New-Item -Path $cp -ItemType Directory 
            }
            CopyControlPanel
            $ec = Join-Path $agentsfolder "Laetus.NT.Core.EC.Agent"
            if(-NOT (Test-Path($ec)))
            {
                New-Item -Path $ec -ItemType Directory 
            }
            CopyEc
            $mapping = Join-Path $agentsfolder "Laetus.NT.Core.MappingEditor.Agent"
            if(-NOT (Test-Path($mapping)))
            {
                New-Item -Path $mapping -ItemType Directory 
            }
            CopyMapping
            $md = Join-Path $agentsfolder "Laetus.NT.Core.MasterDataManager.Agent"
            if(-NOT (Test-Path($md)))
            {
                New-Item -Path $md -ItemType Directory 
            }
            CopyMdm
            $pcs = Join-Path $agentsfolder "Laetus.NT.Core.PCSManager.Agent"
            if(-NOT (Test-Path($pcs)))
            {
                New-Item -Path $pcs -ItemType Directory 
            }
            $audit = Join-Path $agentsfolder "Laetus.NT.Core.Platform.AuditTrail"
            if(-NOT (Test-Path($audit)))
            {
                New-Item -Path $audit -ItemType Directory 
            }
            CopyAudit
            $pom = Join-Path $agentsfolder "Laetus.NT.Core.POManager.Agent"
            if(-NOT (Test-Path($pom)))
            {
                New-Item -Path $pom -ItemType Directory 
            }
            CopyPom
            $exp = Join-Path $agentsfolder "Laetus.NT.Core.USCExportImport"
            if(-NOT (Test-Path($exp)))
            {
                New-Item -Path $exp -ItemType Directory 
            }
            CopyImport
            $sea = Join-Path $agentsfolder "Laetus.NT.Core.ScriptExecutionAgent"
            if(-NOT (Test-Path($sea)))
            {
                New-Item -Path $sea -ItemType Directory 
            }
            CopySea


        if(-NOT (Test-Path($targetdirectory)))
        {
            New-Item -Path $targetdirectory -ItemType Directory 
        }

            $dr = Join-Path $agentsfolder "Laetus.NT.Core.DeviceReflector.DeviceReflectorAgent"
            if(-NOT (Test-Path($dr)))
            {
                New-Item -Path $dr -ItemType Directory 
            }
            CopyDeviceReflector
            $hmi = Join-Path $agentsfolder "Laetus.NT.Core.HMI.Agent"
            if(-NOT (Test-Path($hmi)))
            {
                New-Item -Path $hmi -ItemType Directory 
            }
            CopyHmi
            $line = Join-Path $agentsfolder "Laetus.NT.Core.Line.Agent"
            if(-NOT (Test-Path($line)))
            {
                New-Item -Path $line -ItemType Directory 
            }
            CopyLine
            $cam = Join-Path $agentsfolder "Laetus.NT.Core.Platform.Cameraserver.Agent"
            if(-NOT (Test-Path($cam)))
            {
                New-Item -Path $cam -ItemType Directory 
            }
            CopyCameraServer
}

function Main()
{
    $allFiles = GetAllFiles
    CreateTargetStructure
    
}

Main