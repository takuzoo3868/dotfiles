 #!/bin/bash

 IFS_Backup=$IFS
 IFS=$'\n'
 REGKey=HKLM\\SOFTWARE\\Microsoft\\Windows\ NT\\CurrentVersion
 REGValue1=ReleaseId
 REGValue2=CurrentBuild
 REGValue3=UBR

 ARRAY1=(`reg.exe query $REGKey /v $REGValue1`) 2>/dev/null
 ARRAY2=(`reg.exe query $REGKey /v $REGValue2`) 2>/dev/null
 ARRAY3=(`reg.exe query $REGKey /v $REGValue3`) 2>/dev/null
 Version=(`echo ${ARRAY1[2]} | cut -c28- | sed -e 's/[\r\n]\+//g'`)
 BuildNo=(`echo ${ARRAY2[2]} | cut -c31- | sed -e 's/[\r\n]\+//g'`)
 UBR=(`echo ${ARRAY3[2]} | cut -c27- | sed -e 's/[\r\n]\+//g'`)
 WSL=(`cat /etc/issue | cut -d ' ' -f 1-3`)

 if [ ${#UBR} -eq 1  ] ; then
    UBRdec=`printf '%d\n' '0x000'$UBR`
 elif  [ ${#UBR} -eq 2  ] ; then
    UBRdec=`printf '%d\n' '0x00'$UBR`
 elif  [ ${#UBR} -eq 3  ] ; then
    UBRdec=`printf '%d\n' '0x0'$UBR`
 elif  [ ${#UBR} -eq 4  ] ; then
    UBRdec=`printf '%d\n' '0x'$UBR`
 fi

 echo 'Windows 10のバージョン:' $Version
 echo 'Windows 10のビルド番号:' $BuildNo'.'$UBRdec
 echo 'WSLの内容:' $WSL

 IFS=$IFS_Backup
