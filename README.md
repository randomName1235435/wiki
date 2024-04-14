# collection of gists/cli/commands ..

## Powershell 

### adds mmc and gui stuff to server core 2019

```ps
Add-WindowsCompability -Online -Name ServerCore.AppCompability~~~~0.0.1.0
```

### create sample ad

```ps
Import-Module ADDSDEployment
Install-ADDDSForst `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS"` 
-DomainMode "WinThreshold" ` 
-DomainName "SampleDomain.local" `
-DomainNetbiosName "SAMPLEDOMAIN" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" ` 
-NoRebootOnCompletion:$false `
-SysvolPath "C;\Windows\SYSVOL" `
-Force:$true
```

## cmds 

### godmode folder 
```batch
GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}
```

### wind apps

```batch
msconfig - startup config
shell:startup - autostart folder
sysdm.cpl System Properties (to rename computer and join domain)
dssite.msc Active Directory sites and services
dsa.msc Active Directory users and computers
appwiz.cpl Add/Remove programs
compmgmt.msc Computer management
timedate.cpl Date/Time management
devmgmt.msc Device Manager
dhcpmgmt.msc DHCP Management
cleanmgr Disk Cleanup Utility
diskmgmt.msc Disk Management
desk.cpl Display Settings
dnsmgmt.msc DNS Server Management
eventvwr.msc Event Viewer
lusrmgr.msc Local user and groups manager
mmc.exe Microsoft Management Console
main.cpl Mouse settings
ncpa.cpl Network adapter settings
powercfg.cpl Power Configuration
intl.cpl Regional Settings
services.msc Services
fsmgmt.msc Shared Folder Management
firewall.cpl Windows Firewall
wf.msc Windows Firewall Advanced
mmsys.cpl Sound Control Panel
Mstsc for remote desktop
diskmgmt.msc, services.msc and lusrmgr.msc
control - Opens control panel
resmon Resource monitor
compmgmt.msc gives them all plus more, in a single mmc console.

Device manager
Disk manager
Event viewer
Task scheduler
User manager
Service manager
```

## c#/.net

### internals visible to generation - working with refactorings

```cs
#old
<ItemGroup>
  <EmbeddedFiles Include="$(GeneratedAssemblyInfoFile)">
</ItemGroup>
<ItemGroup>
  <AssemblyAttribute Include="System.Runtime.CompilerServices.InternalsVisibleToAttribute">
  <_Parameter1>$(AssemblyName).Tests</_Parameter1>
  </AssemblyAttribute>
 </ItemGroup>
 
 #new
 <ItemGroup>
  <InternalsVisibleTo Include="$(AssemblyName).Tests">
 </ItemGroup>
```

### publish single file

```c#
dotnet publish /p: PublishSingleFile=true -r win-x86
```

### #monitor dotnet core app hosted on iis
```c#
dotnet counters monitor -p 9999 System.Runtime.Microsoft.Asp>netCore.Hosting
```

## bash

### fixAptRepo

```bash
sudo apt clean
sudo apt update
sudo dpkg --configure -a
sudo apt install -f
sudo apt full-upgrade
sudo apt autoremove --purge
```

## ubuntu init

```bash
sudo apt-get update
sudo apt install tldr
sudo apt install neofetch
sudo apt install newsboat
sudo apt install bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
alias cat="batcat"
wget -c http://old-releases.ubuntu.com/ubuntu/pool/universe/r/rust-exa/exa_0.9.0-4_amd64.deb
sudo apt-get install ./exa_0.9.0-4_amd64.deb
alias dir="exa -l"
alias ls="exa -l"
```
