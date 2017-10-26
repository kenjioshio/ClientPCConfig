$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'. "$here\$sut"

Describe "ClientPC_Config checking" {
     Context "Check 'SVN' Installation and Configuration" {
        It "'TortioseSVN' folder should be exist in 'C:\Program Files'." {
        "C:\Program Files\TortoiseSVN" | Should Exist
        }
        It "'TortoiseProc.exe' should be exist in 'C:\Program Files\TortoiseSVN'." {
        "C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" | Should Exist
        }
     }

     Context "Check NUnit Installation and Configuration" {
        It "'NUnit' folder should be exist in 'C:\Program Files (x86)'." {
        "C:\Program Files (x86)\NUnit 2.6.4" | Should Exist
        }
        It "'NUnit.exe' should be exist in 'C:\Program Files (x86)\NUnit 2.6.4\bin'." {
            "C:\Program Files (x86)\NUnit 2.6.4\bin\nunit.exe" | Should Exist
        }    
     }

     Context "Check Process Explorer Installation and Configuration" {
        It "'Process Explorer' folder should be exist in 'C:\ProgramData\chocolatey\lib'." {
        "C:\ProgramData\chocolatey\lib\procexp" | Should Exist
        }
        It "'Process Explorer.exe' should be exist in 'C:\ProgramData\chocolatey\lib\procexp\tools'." {
        "C:\ProgramData\chocolatey\lib\procexp\tools\procexp.exe" | Should Exist
        }
     }

     Context "Check 'OpenCover' Installation and Configuration" {
        It "'OpenCover' folder should be exist in '$env:USERPROFILE\AppData\Local\Apps\OpenCover'." {
        "$env:USERPROFILE\AppData\Local\Apps\OpenCover" | Should Exist
        }
        It "'OpenCover.Console.exe'should be exist in '$env:USERPROFILE\AppData\Local\Apps\OpenCover\OpenCover.Console.exe'." {
        "$env:USERPROFILE\AppData\Local\Apps\OpenCover\OpenCover.Console.exe" | Should Exist
        }
     }

     Context "Check 'ReportGenerator' Installation and Configuration" {
        It "'ReportGenerator.exe'should be exist in 'C:\ProgramData\chocolatey\bin\ReportGenerator.exe'." {
        "C:\ProgramData\chocolatey\bin\ReportGenerator.exe" | Should Exist
        }
     }
     
     Context "Check '7zip' Installation and Configuration" {
        It "'7-Zip' folder should be exist in 'C:\Program Files\7-Zip'." {
        "C:\Program Files\7-Zip" | Should Exist
        }
        It "7z.exe' should be exist in 'C:\Program Files\7-Zip\7z.exe'." {
        "C:\Program Files\7-Zip\7z.exe" | Should Exist
        }
     }
}

Describe "Check Environment Variables of System" {

    #$envVal_Path = $env:Path
    #PCのプロパティーなどから取得する環境変数は変更後再起動しないと反映されないのでRegistoryから直接取得するのがBest
         
    $envVal_Path =(Get-Item -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment").GetValue("Path")
    $envPathObj= $envVal_Path.split(";")

    Context "Check Evironment Variable 'Path' for SVN"{
        $result =$false
        foreach($path in $envPathObj){
            if($path -eq "C:\Program Files\TortoiseSVN\bin"){
                $result = $true
                #Write-Host "C:\Program Files\TortoiseSVN\bin is exist as an Path Environment value "
            }
        } 
        It "'C:\Program Files\TortoiseSVN\bin' should be exist in environment variable 'Path'." {
                $result | Should be $true     
        }
    }   

    Context "Chekc Evironment Variable 'Path' for  NUnit"{
        $result =$false
        foreach($path in $envPathObj){
            if($path -eq "C:\Program Files (x86)\NUnit 2.6.4\bin"){
                $result = $true
            }
        } 
        It "'C:\Program Files (x86)\NUnit 2.6.4\bin' should be exist in environment variable 'Path'." {
            $result | Should be $true
        }
    }

}