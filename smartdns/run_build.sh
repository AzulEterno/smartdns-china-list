#!/bin/bash


# Shell for converting original format into smart dns format.
# Author: AzulEterno



outputFolderPath="./smartdns/outputs";

# echo $outputFolderPath;

function create_folder_if_non_exist(){
    if [[ $# < 1 ]];then
        return -1;
    fi

    if [ -d "$1" ];then
        return 0;
    fi

    mkdir -p "$1";
    return $?;
}

function convert_file(){
    if [[ $# < 2 ]];then
        return -1;
    fi

    local inputFilePath=$1;
    local outputFilePath=$2;

    if [[ $# < 3 ]];then
        local prefix_str="nameserver \/";
    else
        local prefix_str=$3;
    fi
    if [[ $# < 4 ]];then
        local appendix_str="\/china";
    else
        local appendix_str=$4;
    fi

    #echo $inputFilePath $outputFilePath;
    # columns needs to be transed.
    sed -ne "s/\(server=\/\)\(.*\)\(\/114\.114\.114\.114\)/${prefix_str}\2${appendix_str}/p" "$inputFilePath"  > "$outputFilePath";
    return $?;
}


create_folder_if_non_exist $outputFolderPath

if [[ $? == 0 ]];then

    convert_file "accelerated-domains.china.conf" "$outputFolderPath/cn_domains.conf";
    convert_file "apple.china.conf" "$outputFolderPath/apple_china.conf";
    convert_file "google.china.conf" "$outputFolderPath/google_china.conf";

    exit $?;
else
    echo "Failed to create folder. Code $? ";
    exit 1
fi
