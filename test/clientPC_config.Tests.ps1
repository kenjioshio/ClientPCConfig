$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "ClientPC_Config checking" {
     Context "Check SVN Installation and Configuration" {
        It "TortioseSVN folder should be exist in C:\Program Files" {
        "C:\Program Files\TortoiseSVN" | Should Exist
        }
        It "TortoiseProc.exe should be exist in C:\Program Files\TortoiseSVN." {
        "C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" | Should Exist
        }
        $result =$false
        $envVal_Path = $env:Path
        $envPathObj= $envVal_Path.split(";")
        foreach($path in $envPathObj)
        {
            if($path -eq "C:\Program Files\TortoiseSVN\bin")
            {
                $result = $true
                #Write-Host "C:\Program Files\TortoiseSVN\bin is exist as an Path Environment value "
             }
    }  
        It "C:\Program Files\TortoiseSVN\bin should be exist in Path" {
         $result | Should be $true
        }
    }

     Context "Check NUnit Installation and Configuration" {
        It "NUnit folder should be exist in C:\Program Files (x86)" {
        "C:\Program Files (x86)\NUnit 2.6.4" | Should Exist
        }
        It "NUnit.exe should be exist in C:\Program Files (x86)\NUnit 2.6.4\bin." {
            "C:\Program Files (x86)\NUnit 2.6.4\bin\nunit.exe" | Should Exist
        }    
     }

     Context "Check Process Explorer Installation and Configuration" {
        It "Process Explorer folder should be exist in C:\ProgramData\chocolatey\lib" {
        "C:\ProgramData\chocolatey\lib\procexp" | Should Exist
        }
         It "Process Explorer.exe should be exist in C:\ProgramData\chocolatey\lib\procexp\tools." {
        "C:\ProgramData\chocolatey\lib\procexp\tools\procexp.exe" | Should Exist
        }
     }
}
