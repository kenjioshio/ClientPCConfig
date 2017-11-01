$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'. "$here\$sut"

Describe ":Checking whether Tools installation and the configuration of this PC are completed or not."{
    #InstallされたTool類のチェック   
    Context ":Check 'SVN' Installation and Configuration."{
        It "'TortoiseProc.exe' should be exist in 'C:\Program Files\TortoiseSVN'."{
            "C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" | Should Exist
        }

        $DesiredVersion =$null
        #Version情報はpackage.configから取ってこれるとよいが、今はハードコーディングで実施。
        $DesiredVersion = "1.9.7.27907"
        It "'TortoiseProc.exe' should be'Ver.$DesiredVersion'." {
            $f_Version =(Get-ItemProperty "C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe").VersionInfo.FileVersion
            $fileVersion = $f_Version.Replace(", ",".")       
            $fileVersion | Should be $DesiredVersion
        }
    }
    Context ":Check 'NUnit' Installation and Configuration."{
        It "'NUnit.exe Ver2.6.4' should be exist in 'C:\Program Files (x86)\NUnit 2.6.4\bin'."{
            "C:\Program Files (x86)\NUnit 2.6.4\bin\nunit.exe" | Should Exist
        }

        $DesiredVersion =$null
        #Version情報はpackage.configから取ってこれるとよいが、今はハードコーディングで実施。
        $DesiredVersion = "2.6.4"
        It "'NUnit.exe' should be 'Ver.$DesiredVersion'."{
            #Chocolateyの仕様上、Install時のVersion指定とInstallされた後のRegistoryでVersionと桁が違うのでMatchで検証
            $f_Version =(Get-ItemProperty "C:\Program Files (x86)\NUnit 2.6.4\bin\nunit.exe").VersionInfo.FileVersion
            $fileVersion = $f_Version.Replace(", ",".")       
            $fileVersion | Should match $DesiredVersion
        }
    }
    Context ":Check 'Process Explorer' Installation and Configuration."{
        It "'Process Explorer.exe' should be exist in 'C:\ProgramData\chocolatey\lib\procexp\tools'."{
            #Chocolateyの仕様上、変なところにInstallされるが、PATHを設定すれば利用上問題ない。はず…
            "C:\ProgramData\chocolatey\lib\procexp\tools\procexp.exe" | Should Exist
        }

        $DesiredVersion =$null
        #Version情報はpackage.configから取ってこれるとよいが、今はハードコーディングで実施。
        $DesiredVersion = "16.21"
        It "'procexp.exe' should be 'Ver.$DesiredVersion'."{
            #Chocolateyの仕様上、Install時のVersion指定とInstallされた後のRegistoryでVersionと桁が違うのでMatchで検証
            $f_Version =(Get-ItemProperty "C:\ProgramData\chocolatey\lib\procexp\tools\procexp.exe").VersionInfo.FileVersion
            $fileVersion = $f_Version.Replace(", ",".")       
            $fileVersion | Should match $DesiredVersion
        }
    }
    Context ":Check 'OpenCover' Installation and Configuration."{
        It "'OpenCover.Console.exe'should be exist in '$env:USERPROFILE\AppData\Local\Apps\OpenCover'."{
            #Chocolateyの仕様上、変なところにInstallされるが、PATHを設定すれば利用上問題ない。はず…
            "$env:USERPROFILE\AppData\Local\Apps\OpenCover\OpenCover.Console.exe" | Should Exist
        }
        
        $DesiredVersion =$null
        #Version情報はpackage.configから取ってこれるとよいが、今はハードコーディングで実施。
        $DesiredVersion = "4.6.166"
        It "'OpenCover.Console.exe' should be 'Ver.$DesiredVersion'."{
            #Chocolateyの仕様上、Install時のVersion指定とInstallされた後のRegistoryでVersionと桁が違うのでMatchで検証
            $f_Version =(Get-ItemProperty "$env:USERPROFILE\AppData\Local\Apps\OpenCover\OpenCover.Console.exe").VersionInfo.FileVersion
            $fileVersion = $f_Version.Replace(", ",".")       
            $fileVersion | Should match $DesiredVersion
        }
    }
    Context ":Check 'ReportGenerator' Installation and Configuration."{
        It "'ReportGenerator.exe'should be exist in 'C:\ProgramData\chocolatey\bin'."{
            #Chocolateyの仕様上、変なところにInstallされるが、PATHを設定すれば利用上問題ない。はず・・・
            "C:\ProgramData\chocolatey\bin\ReportGenerator.exe" | Should Exist
        }
        
        $DesiredVersion =$null
        #Version情報はpackage.configから取ってこれるとよいが、今はハードコーディングで実施。   
        $DesiredVersion = "3.0.0.0" 
        It "'OpenCover.Console.exe' should be 'Ver.$DesiredVersion'."{
            $f_Version =(Get-ItemProperty "C:\ProgramData\chocolatey\bin\ReportGenerator.exe").VersionInfo.FileVersion
            $fileVersion = $f_Version.Replace(", ",".")       
            $fileVersion | Should be $DesiredVersion
        }
    }
    Context ":Check '7zip' Installation and Configuration."{
        It "'7z.exe' should be exist in 'C:\Program Files\7-Zip\7z.exe'."{
            "C:\Program Files\7-Zip\7z.exe" | Should Exist
        }
            
        $DesiredVersion =$null
        #Version情報はEXEのFileVersionの表示上のDataと取得データが微妙に違うので、特別にハードコーディングで実施。
        $DesiredVersion = "16.04"
        It "'7z.exe' should be 'Ver.$DesiredVersion'."{
            #Chocolateyの仕様上、Install時のVersion指定とInstallされた後のRegistoryでVersionと桁が違うのでMatchで検証
            $f_Version =(Get-ItemProperty "C:\Program Files\7-Zip\7z.exe").VersionInfo.ProductVersion
            $fileVersion = $f_Version.Replace(", ",".")       
            $fileVersion | Should be $DesiredVersion
        }
    }
}

Describe ":Check Environment Variables of this PC."{
    #まずは、取得したい環境変数が存在しているか確認して、存在している場合、さらに、その値を確認するTest
    #$envVal_Path = $env:Path
    #PCのプロパティーなどから取得する環境変数は変更後再起動しないと反映されないのでRegistoryから直接取得するのがBestかなと。
    #(DSC configuration 実行後、RebootせずにPathが正しく設定されているか検証可能)      
    $envVarObj =$null
    #Registoryからすべての環境変数を取得
    $envVarObj =(Get-Item -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment").GetValueNames()

    Context ":Check envirnment variables are exist and that values are correct."{
        It "'Path'envirnment variable should be exist in this PC."{
            $result =$false
            foreach($ev in $envVarObj){ 
                if($ev -eq "Path"){      
                    $result = $true
                }                
            }
            $result | Should be $true 
        }
            #環境変数'Path'が存在してることを確認してからPathの値を確認
            if($result -eq $true){
                $PathVaule =(Get-Item -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment").GetValue("Path")
                $PathValueObj= $PathVaule.split(";")
                #環境変数をファイルに落としてContainを使うとエスケープが面倒なので、時間はかかるが'；'で区切って、配列化し、オブジェクトとしてToolごとにループを回して比較。
                #冗長で実行時間も多少かかるがSimpleさを優先
            
                It "'C:\Program Files\TortoiseSVN\bin' should be exist in environment variable 'Path'."{
                    $result =$false
                    foreach($pv in $PathValueObj){
                        if($pv -eq "C:\Program Files\TortoiseSVN\bin"){
                            $result = $true
                            #Write-Host "C:\Program Files\TortoiseSVN\bin is exist as an Path Environment value "
                        }
                    }         
                    $result | Should be $true     
                }
                      
                It "'C:\Program Files (x86)\NUnit 2.6.4\bin' should be exist in environment variable 'Path'."{
                    $result =$false
                    foreach($pv in $PathValueObj){
                        if($pv -eq "C:\Program Files (x86)\NUnit 2.6.4\bin"){
                            $result = $true
                        }
                    } 
                    $result | Should be $true
                }
       
            } 
        #環境変数'VS120COMNTOOLS'が存在してることを確認してからPathの値を確認
        It "'VS120COMNTOOLS'envirnment variable should be exist in this PC."{
            $result =$false
            foreach($ev in $envVarObj){ 
                if($ev -eq "VS120COMNTOOLS"){      
                    $result = $true
                }                
            }
            $result | Should be $true 
        }
        
        if($result -eq $true){        
            $result = $false
            $VSTool_env =(Get-Item -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment").GetValue("VS120COMNTOOLS")
            if($VSTool_env -eq $null){
                $result = $false
            }
            else{
                $result =$true
            }
            
            It "'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\' should be exist in environment variable 'VS120COMNTOOLS'."{
                $result | Should be $true  
            } 
        }     

    }
}
 