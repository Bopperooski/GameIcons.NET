# Directory containing the SVG files
$svgDir = Read-Host "Please enter the path to the 'icons' folder for game-icons."
if (!(Test-Path $svgDir)){
    Exit 
}

# Output file
$outDir = Read-Host "Please enter the desired output path for the GameIcons class.(A relative path can be used)"
if ((Get-ChildItem $outDir | Measure-Object).Count -ne 0){
    $continue = Read-Host "There are already files that exist in the output folder. Do you want to delete them?"
    if ($continue -in "O", "Y","Oui","Yes"){
        Remove-Item $outDir\*.*
    }
    else{
        Exit
    }
}
#Create the output directory if it doesn't exist
if (!(Test-Path $outDir)){
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

$namespace = Read-Host "Please enter the desired namespace for the class."
$className = Read-Host "Please enter the desired class name."

#Start of the class file
$classStart = @"
using System;
namespace $namespace;
public partial class $className 
{
    public partial class GameIcons
    {
"@

$classEnd = @"
        }
    }
}
"@

#Function to convert a string to CamelCase
function ConvertTo-CamelCase($str){
    return ($str -split '-' | ForEach-Object { 
        if ($_.Length -gt 0){
            $_.Substring(0, 1).ToUpper() + $_.Substring(1).ToLower() 
        }
    }) -join ''
}

#Iterate over each subdirectory in the directory
Get-ChildItem $svgDir -Directory -Recurse | ForEach-Object { $dir = $_

    #Output file
    $outFile = "$outDir/$($dir.Name).cs"
    #Write the start of the class file
    $classStart | ForEach-Object {$_ + "`r`n"} | Out-File $outFile -NoNewline
    $classAddon = @"
        public partial class $(ConvertTo-CamelCase $_.Name) 
        {
"@
    $classAddon | ForEach-Object {$_ + "`r`n"} | Out-File $outFile -Append -NoNewline
    #Iterate over each SVG file in the directory
    Get-ChildItem $dir.FullName -Filter *.svg | ForEach-Object { 
        #Get the file name without the extension and convert it to CamelCase
        $name = ConvertTo-CamelCase $_.BaseName
        #Read the SVG file and extract the content inside the <svg> tag
        $svgContent = Get-Content $_.FullName -Raw
        $svgContentInside = $svgContent -replace 'fill="#fff"', '' -replace '"', '\"'

        #Add a property for this SVG file to the class file
        $property = @"
            public const string $name = "$svgContentInside";
"@
        $property | ForEach-Object {$_ + "`r`n"} | Out-File $outFile -Append -NoNewline
    }
    $classEnd | ForEach-Object {$_ + "`r`n"} | Out-File $outFile -Append -NoNewline
}