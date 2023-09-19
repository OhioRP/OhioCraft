#!/bin/bash

set -e

log() {
    level=$1
    message=$2
    case $level in
        1)
            printf "\n --- $message --- \n\n"
            ;;
        15)
            printf "\n --- $message --- \n"
            ;;
        2)
            printf "\n$message\n\n"
            ;;
        3)
            printf " >>> $message\n"
            ;;
        4)
            printf "   -> $message\n"
            ;;
        *)
            echo $message
            ;;
    esac
}

unzip() {
    log 5 "Unzipping \`$1\`"
    /bin/unzip -qq $@
}

if [ ! -d .build_cache ]; then
    log 5 "[INFO] Creating \`.build_cache\`"
    mkdir .build_cache
fi

if [ ! -d Build ]; then
    log 1 "Downloading MineClone2"
    if [ ! -f ./.build_cache/mineclone2.zip ]; then
        wget https://git.minetest.land/MineClone2/MineClone2/archive/b4c693bb205777b39446fe631ac02823656cc26d.zip -O ./.build_cache/mineclone2.zip
    fi
    unzip ./.build_cache/mineclone2.zip
    mv mineclone2 Build
fi

log 1 "Patching assets"

log 3 "Patching menu"
rm -f ./Build/menu/header*.png
cp ./Assets/header.png ./Build/menu/header.png
rm -f ./Build/menu/icon*.png
cp ./Assets/icon.png ./Build/menu/icon.png

log 3 "Patching game metadata"
rm -f ./Build/game.conf
cp -f ./game.conf ./Build/game.conf

log 3 "Patching Amethyst sounds"
rm -f ./Build/mods/ITEMS/mcl_amethyst/sounds/*
cp -f ./Assets/Sounds/mcl_amethyst_amethyst* ./Build/mods/ITEMS/mcl_amethyst/sounds/

log 3 "Patching Barrel sounds"
rm -f ./Build/mods/ITEMS/mcl_barrels/sounds/*
cp -f ./Assets/Sounds/mcl_barrels_default_barrel* ./Build/mods/ITEMS/mcl_barrels/sounds/

log 3 "Patching Stone sounds"
rm -f ./Build/mods/CORE/mcl_sounds/sounds/default_dig_cracky*
rm -f ./Build/mods/CORE/mcl_sounds/sounds/default_hard_footstep*
cp -f ./Assets/Sounds/default_* ./Build/mods/CORE/mcl_sounds/sounds/

log 3 "Patching Amethyst textures"
rm -f ./Build/textures/mcl_amethyst_amethyst_block.png
rm -f ./Build/textures/mcl_amethyst_amethyst_cluster.png
rm -f ./Build/textures/mcl_amethyst_budding_amethyst.png
cp -f ./Assets/Textures/mcl_amethyst_amethyst_block.png ./Build/textures/
cp -f ./Assets/Textures/mcl_amethyst_amethyst_cluster.png ./Build/textures/
cp -f ./Assets/Textures/mcl_amethyst_budding_amethyst.png ./Build/textures/

log 3 "Patching Ancient Debris textures"
rm -f ./Build/textures/mcl_nether_ancient_debris_side.png
rm -f ./Build/textures/mcl_nether_ancient_debris_top.png
cp -f ./Assets/Textures/mcl_nether_ancient_debris_side.png ./Build/textures/
cp -f ./Assets/Textures/mcl_nether_ancient_debris_top.png ./Build/textures/

log 3 "Patching Andesite textures"
rm -f ./Build/textures/mcl_core_andesite.png
cp -f ./Assets/Textures/mcl_core_andesite.png ./Build/textures/

log 3 "Patching Bedrock textures"
rm -f ./Build/textures/mcl_core_bedrock.png
cp -f ./Assets/Textures/mcl_core_bedrock.png ./Build/textures/

log 3 "Patching Diorite textures"
rm -f ./Build/textures/mcl_core_diorite.png
cp -f ./Assets/Textures/mcl_core_diorite.png ./Build/textures/

log 3 "Removing ambient music"
rm -rf ./Build/mods/PLAYER/mcl_music

log 1 "Patching source code"
if [ -f Build/patched ]; then
    printf "%s" "WARNING: It looks like you already have a previous Build of OhioCraft. In order to apply patches, you would need to restart the build process. Do you want to skip this step? (y/n) " >&2
    read answer
    answer=$(echo $answer | tr 'a-z' 'A-Z')
    if [ "$answer" = Y ]; then
        echo "Skipping..."
    else
        echo "ERROR: Can't apply patches without restarting build" >&2
        exit 1
    fi
else
    patch ./Build/mods/ITEMS/mcl_amethyst/init.lua < Patches/mcl_amethyst_init_lua.patch
    patch ./Build/mods/ITEMS/mcl_barrels/init.lua < Patches/mcl_barrels_init_lua.patch
    touch Build/patched

    log 2 "Patching REDSTONE"
    log 3 "Replacing \`mesecon\` with \`mesecon2\`"
    find ./Build/mods -type f -exec \
         sed -i {} -e 's/mesecon/mesecon2/g' \;
    log 3 "Adapting texture names"
    for f in ./Build/textures/*; do
        if [[ $f == *mesecons* ]]; then
            mv "$f" "${f/mesecons/mesecon2s}"
        fi
    done
    log 3 "Adapting sound names"
    find ./Build/mods/ITEMS/REDSTONE -type f -name "*mesecons*.ogg" -exec \
         bash -c \
         "bn=\$(basename \$0); bd=\$(dirname \$0); mv \$0 \$bd/\${bn/mesecons/mesecon2s}" {} \;
    log 3 "Adapting translation files"
    find ./Build/mods/ITEMS/REDSTONE -type f -name "*mesecons*.tr" -exec \
         bash -c \
         "bn=\$(basename \$0); bd=\$(dirname \$0); mv \$0 \$bd/\${bn/mesecons/mesecon2s}" {} \;
    log 3 "Done!"
fi

log 15 "Adding mods"

log 2 "Adding OhioCraft specific mods"
log 3 "Copying \`./Mods\` to \`./Build/mods/OHIOCRAFT\`"
rm -rf ./Build/mods/OHIOCRAFT
cp -r ./Mods ./Build/mods/OHIOCRAFT

install_mod() {
    url=$1
    output_folder=$2
    file=./.build_cache/$(basename $url)

    if [ ! -f $file ]; then
        wget $url -O $file
    fi
    zip_folder=./.build_cache/`basename $(zipinfo -1 $file | head -1)`
    if [ -d $zip_folder ]; then
        rm -rf $zip_folder
    fi
    unzip $file -d ./.build_cache

    rm -rf $output_folder

    log 3 "Copying \`$zip_folder\` contents"
    cp -r $zip_folder $output_folder
}

log 2 "Adding worldedit"
install_mod \
    https://github.com/Uberi/Minetest-WorldEdit/archive/refs/tags/1.3.zip \
    ./Build/mods/WORLDEDIT
log 3 "Removing worldedit_gui"
rm -rf ./Build/mods/WORLDEDIT/worldedit_gui

log 2 "Adding mcl_decor"
install_mod \
    https://codeberg.org/rudzik8/mcl_decor/archive/v1.4_01.zip \
    ./Build/mods/DECOR

log 2 "Adding mesecons"
install_mod \
    https://github.com/minetest-mods/mesecons/archive/8e30ee411347e6552cb5a9f28ea3069805853ea3.zip \
    ./Build/mods/MESECONS
log 3 "Removing mesecons_doors"
rm -rf ./Build/mods/MESECONS/mesecons_doors
