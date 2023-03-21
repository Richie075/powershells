param(
    [string]$solutionDir = "D:\SVN\current\up2\global",
    [string]$targetdirectory = "D:\SVN\current\up2\line\bin\x64\Debug"
)

$global:sourceFiles
function GetAllFiles()
{
    $agentSearchPath = Join-Path $solutionDir.Trim(" ") -ChildPath "bin\x64\Debug\Agents"
    $commonSearchPath = Join-Path $solutionDir.Trim(" ") -ChildPath "bin\x64\Debug\Common"
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

function CopySourceToTarget($fileList, $targetPath, $sourcePath)
{
    $target = Join-Path $agentsfolder $targetPath
    if(-NOT (Test-Path($target)))
    {
        New-Item -Path $target -ItemType Directory 
    }
    for ($i=0; $i -lt $fileList.length; $i++){ 
        [String[]]$sourceFiles = $global:sourceFiles -match $fileList[$i]
        $sourceFiles += @($global:sourceFiles -match $fileList[$i].Replace(".dll",".pdb"))
        for ($j=0; $j -lt $sourceFiles.length; $j++){ 
            Copy-Item -Path $sourceFiles[$j] -Destination $target -force
        }
    }
    if($null -ne $sourcePath)
    {
        CopyFrontend $sourcePath $target
    }
}


function CopyFrontend($source, $target)
{
    $sourcePath = Join-Path $solutionDir.Trim(" ") -ChildPath $source
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
            CopySourceToTarget @(
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
                "System.Web.Http.Owin.dll") "Common" $null
            
            CopySourceToTarget @("DummyAuthAgent.dll") "DummyAuthAgent" $null
            CopySourceToTarget @("Laetus.NT.Core.Authentication.Agent.dll") "Laetus.NT.Core.Authentication.Agent" $null
            CopySourceToTarget @(
                "Laetus.NT.Core.CodePoolManagement.Agent.dll",
                "Laetus.NT.Core.CodePoolManagement.CodeSupplier.dll",
                "Laetus.NT.Core.CodePoolManagement.Common.dll",
                "Laetus.NT.Core.CodePoolManagement.Counters.dll",
                "Laetus.NT.Core.CodePoolManagement.DomainParticipation.dll",
                "Laetus.NT.Core.CodePoolManagement.Generator.dll",
                "Laetus.NT.Core.CodePoolManagement.Level4Interface.dll",
                "Laetus.NT.Core.CodePoolManagement.Manager,dll") "Laetus.NT.Core.CodePoolManagement.Agent" $null
            CopySourceToTarget @(
                "Laetus.NT.Core.ControlPanel.dll") "Laetus.NT.Core.ControlPanel" "control-panel\agent\agent\Frontend"
            CopySourceToTarget @(
                "Laetus.Common.Dto.Aux.dll",
                "Laetus.Common.Dto.EC2Plant.dll",
                "Laetus.NT.Core.EC.Agent.dll",
                "Laetus.NT.Core.EC.Manager.dll") "Laetus.NT.Core.EC.Agent" $null
            CopySourceToTarget @(
                "Laetus.NT.Core.MappingEditor.Agent.dll") "Laetus.NT.Core.MappingEditor.Agent" "mapping-editor\agent\agent\Frontend" 
            CopySourceToTarget @(
                "Laetus.NT.Core.MasterDataManager.Agent.dll",
                "Laetus.NT.Core.MasterDataManager.Manager.dll") "Laetus.NT.Core.MasterDataManager.Agent" "mdm\agent\agent\Frontend"
            CopySourceToTarget @(
                "Laetus.NT.Core.PCSManager.Agent.dll",
                "Laetus.NT.Core.PCSManager.Manager.dll") "Laetus.NT.Core.PCSManager.Agent" "pcsm\agent\agent\Frontend"
            CopySourceToTarget @(
                "Laetus.NT.Core.Platform.AuditTrail.dll") "Laetus.NT.Core.Platform.AuditTrail"
            CopySourceToTarget @(
                "Laetus.NT.Core.POManager.Agent.dll",
            "Laetus.NT.Core.POManager.Contracts.dll",
            "Laetus.NT.Core.POManager.Manager.dll",
            "PdfSharp.Charting.dll",
            "PdfSharp.dll") "Laetus.NT.Core.POManager.Agent" "pom\agent\agent\Frontend"
            CopySourceToTarget @(
                "Laetus.NT.Core.USCExportImport.dll") "Laetus.NT.Core.USCExportImport" "usc-export-import\agent\agent\Frontend"
            CopySourceToTarget @(
                "ClearScript.Core",
            "ClearScript.V8",
            "ClearScriptV8.win-x64.dll",
            "Laetus.NT.Core.ScriptExecutionAgent.dll",
            "Laetus.NT.Core.ScriptExecutionContext.dll",
            "Laetus.NT.Core.ScriptExecutionContracts.dll",
            "Laetus.NT.Core.ScriptExecutionEngine.dll") "Laetus.NT.Core.ScriptExecutionAgent" $null
        
        CopySourceToTarget @(
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
            "Laetus.NT.Core.DeviceReflector.DeviceReflectorAgent.dll") "Laetus.NT.Core.DeviceReflector.DeviceReflectorAgent" $null
    CopySourceToTarget @(
        "Laetus.NT.Core.HMI.Agent.dll",
        "Laetus.NT.Core.HMI.Authentication.dll",
        "Laetus.NT.Core.HMI.Common.dll",
        "Laetus.NT.Core.HMI.Contracts.dll",
        "Laetus.NT.Core.HMI.Entities.dll",
        "Laetus.NT.Core.HMI.Services.dll",
        "Laetus.NT.Core.HMI.Web.dll") "Laetus.NT.Core.HMI.Agent" "hmi\web\public"

    CopySourceToTarget @(
        "Laetus.NT.Core.Line.Agent.dll",
        "StaMa.dll") "Laetus.NT.Core.Line.Agent" $null
    CopySourceToTarget @(
        "Laetus.NT.Core.Platform.Cameraserver.Agent.dll") "Laetus.NT.Core.Platform.Cameraserver.Agent" $null
}

function Main()
{
    GetAllFiles
    CreateTargetStructure
    
}

Main