#!/bin/sh

find_files_in_sdcard() {
    bg_deleting="./bg_deleting.png"
    bg_confirm="./bg_confirm.png"
    bg_searching_sdcard="./bg_searching_sdcard.png"
    font="/mnt/SDCARD/Themes/Cozy/Galvji.ttf"

    file_count=0

    # Show searching bg
    /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_searching_sdcard}

    ## For single location
    file_count=$(find "/mnt/SDCARD/" -regex ".*\._.*" | wc -l)

    button=$(/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_confirm} -c "220,220,220" -k "A B" -m "The number of files ( ._xxx ): ${file_count}" -ff ${font} -fs 40)

    if [ "$button" = "A" ]; then
        delete_files_in_sdcard
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0

    elif [ "$button" = "B" ]; then
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0
    fi
}

# delete all ._ files
delete_files_in_sdcard() {
    bg_deleting="./bg_deleting.png"
    bg_confirm="./bg_confirm.png"
    font="/mnt/SDCARD/Themes/Cozy/Galvji.ttf"

    /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_deleting}
    find "/mnt/SDCARD/" -regex ".*\._.*" -exec rm -Rf {} \;
}

find_files_in_common_folder() {
    bg_deleting="./bg_deleting.png"
    bg_confirm="./bg_confirm.png"
    bg_searching_common="./bg_searching_common.png"
    font="/mnt/SDCARD/Themes/Cozy/Galvji.ttf"

    file_count=0

    # Show searching bg
    /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_searching_common}

    ## For multiple location
    for folder in "/mnt/SDCARD/Apps/" "/mnt/SDCARD/Roms/" "/mnt/SDCARD/Backgrounds/" "/mnt/SDCARD/Icons/" "/mnt/SDCARD/Themes/"; do

        # count the number of files
        count=$(find ${folder} -regex ".*\._.*" | wc -l)

        let file_count+=count
    done

    button=$(/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_confirm} -c "220,220,220" -k "A B" -m "The number of files ( ._xxx ): ${file_count}" -ff ${font} -fs 40)

    if [ "$button" = "A" ]; then
        delete_files_in_common_folder
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0

    elif [ "$button" = "B" ]; then
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0
    fi
}

# delete all ._ files
delete_files_in_common_folder() {
    bg_deleting="./bg_deleting.png"
    bg_confirm="./bg_confirm.png"
    font="/mnt/SDCARD/Themes/Cozy/Galvji.ttf"

    /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_deleting}
    for folder in "/mnt/SDCARD/Apps/" "/mnt/SDCARD/Roms/" "/mnt/SDCARD/Backgrounds/" "/mnt/SDCARD/Icons/" "/mnt/SDCARD/Themes/"; do
        find ${folder} -regex ".*\._.*" -exec rm -Rf {} \;
    done
}

main() {
    bg="./instruction.png"
    bg_exit="./bg_exit.png"

    button=$(/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i $bg -c "220,220,220" -k "A B Y")

    if [ "$button" = "A" ]; then
        find_files_in_common_folder
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0

    elif [ "$button" = "Y" ]; then
        find_files_in_sdcard
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0

    elif [ "$button" = "B" ]; then
        /mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i ${bg_exit}
        exit 0

    fi
}

main
