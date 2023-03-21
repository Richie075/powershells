# SVN Export Script

# 

# Given an SVN URL and local directory path, this script copies all files from

# SVN into the specified local directory.

#

# Uses SharpSVN DLL v1.7002.1998 (Documentation : http://docs.sharpsvn.net/current/)

#

# Takes two command line arguments, an SVN URL and a local directory path. 

param ([string]$svnUrl       = $(read-host "Please specify the path to SVN"),

       [string]$svnLocalPath = $(read-host "Please specify the local path"),

       [string]$svnUsername  = $(read-host "Please specify the username"),

       [string]$svnPassword  = $(read-host "Please specify the password")

      )



if ([System.IO.Path]::IsPathRooted($svnLocalPath) -eq $false)

{

  throw "Please specify a local absolute path"

}

# Gets location of executing script

$currentScriptDirectory = Get-Location

# Sets IO directory to location of script

[System.IO.Directory]::SetCurrentDirectory($currentScriptDirectory.Path)

# Needed in some cases to load the DLL

$evidence = [System.Reflection.Assembly]::GetExecutingAssembly().Evidence

# Load SharpSVN DLL

[Reflection.Assembly]::LoadFile(($currentScriptDirectory.Path + "SharpSvn.dll"), $evidence)

# Creates a SharpSVN SvnClient object

$svnClient = new-object SharpSvn.SvnClient



# Creates a SharpSVN SvnUriTarget object

$repoUri = new-object SharpSvn.SvnUriTarget($svnUrl)



# Perform the checkout (i.e. downloads files from SVN to specified local directory)

$svnClient.CheckOut($repoUri, $svnLocalPath)



# Remove SVN metadata files from local directory

gci $svnLocalPath -include .svn -Recurse -Force | Remove-Item -Recurse -Force