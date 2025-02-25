#!/bin/sh


remove_all_macos_meta_file() {
    bg_ongoing="./bg_icon.png"

    for folder in "/mnt/SDCARD/Apps/" "/mnt/SDCARD/Roms/" ; do
        find folder -regex ".*\._.*" -exec rm -Rf {} \;

        # count the number of files
        file_count=`find . -regex ".*\._.*" -printf x | wc -c`

        if [ -f "${apps_folder}/${icon_path}" ]; then
            if (cp "${source_folder}/${icon_path}" "${apps_folder}/${icon_path}"); then
                /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_ongoing} -m "SUCCESS - ${apps_folder}/${icon_path}"
            fi
        else
            /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -c "255,59,48" -m "Fail - ${apps_folder}/${icon_path}  is not exist"
        fi
    done
}


main() {
    bg="./instruction.png"
    bg_exit="./bg_exit.png"

    button=$(/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i $bg -c "200,200,200" -k "A B X Y SELECT MENU")


    if [ "$button" = "A" ]; then
        remove_all_macos_meta_file

        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0

    elif [ "$button" = "B" ]; then
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0

    fi
}

main
