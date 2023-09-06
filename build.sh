#!/bin/bash

set -e

if [ ! -d Build ]; then
    printf "\n --- Downloading MineClone2 --- \n\n"
    if [ ! -f mineclone2.zip ]; then
        wget https://git.minetest.land/MineClone2/MineClone2/archive/b4c693bb205777b39446fe631ac02823656cc26d.zip -O mineclone2.zip
    fi
    unzip mineclone2.zip
    mv mineclone2 Build
fi

printf "\n --- Patching menu --- \n\n"
rm -vf ./Build/menu/header*.png
cp -v ./Assets/header.png ./Build/menu/header.png
rm -vf ./Build/menu/icon*.png
cp -v ./Assets/icon.png ./Build/menu/icon.png

printf "\n --- Patching game metadata --- \n\n"
rm -vf ./Build/game.conf
cp -vf ./game.conf ./Build/game.conf

printf "\n --- Patching Amethyst sounds --- \n\n"
rm -vf ./Build/mods/ITEMS/mcl_amethyst/sounds/*
cp -vf ./Assets/Sounds/mcl_amethyst_amethyst* ./Build/mods/ITEMS/mcl_amethyst/sounds/

printf "\n --- Patching Barrel sounds --- \n\n"
rm -vf ./Build/mods/ITEMS/mcl_barrels/sounds/*
cp -vf ./Assets/Sounds/mcl_barrels_default_barrel* ./Build/mods/ITEMS/mcl_barrels/sounds/

printf "\n --- Patching Stone sounds --- \n\n"
rm -vf ./Build/mods/CORE/mcl_sounds/sounds/default_dig_cracky*
rm -vf ./Build/mods/CORE/mcl_sounds/sounds/default_hard_footstep*
cp -vf ./Assets/Sounds/default_* ./Build/mods/CORE/mcl_sounds/sounds/

printf "\n --- Patching Amethyst textures --- \n\n"
rm -vf ./Build/textures/mcl_amethyst_amethyst_block.png
rm -vf ./Build/textures/mcl_amethyst_amethyst_cluster.png
rm -vf ./Build/textures/mcl_amethyst_budding_amethyst.png
cp -vf ./Assets/Textures/mcl_amethyst_amethyst_block.png ./Build/textures/
cp -vf ./Assets/Textures/mcl_amethyst_amethyst_cluster.png ./Build/textures/
cp -vf ./Assets/Textures/mcl_amethyst_budding_amethyst.png ./Build/textures/

printf "\n --- Patching Ancient Debris textures --- \n\n"
rm -vf ./Build/textures/mcl_nether_ancient_debris_side.png
rm -vf ./Build/textures/mcl_nether_ancient_debris_top.png
cp -vf ./Assets/Textures/mcl_nether_ancient_debris_side.png ./Build/textures/
cp -vf ./Assets/Textures/mcl_nether_ancient_debris_top.png ./Build/textures/

printf "\n --- Patching Andesite textures --- \n\n"
rm -vf ./Build/textures/mcl_core_andesite.png
cp -vf ./Assets/Textures/mcl_core_andesite.png ./Build/textures/

printf "\n --- Patching Bedrock textures --- \n\n"
rm -vf ./Build/textures/mcl_core_bedrock.png
cp -vf ./Assets/Textures/mcl_core_bedrock.png ./Build/textures/

printf "\n --- Patching Diorite textures --- \n\n"
rm -vf ./Build/textures/mcl_core_diorite.png
cp -vf ./Assets/Textures/mcl_core_diorite.png ./Build/textures/

printf "\n --- Removing ambient music --- \n\n"
rm -vrf ./Build/mods/PLAYER/mcl_music

printf "\n --- Patching source code --- \n\n"
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
fi

printf "\n --- Adding mods --- \n"

printf "\nAdding OhioCraft specific mods\n\n"
rm -vrf ./Build/mods/OHIOCRAFT
cp -vr ./Mods ./Build/mods/OHIOCRAFT

printf "\nAdding World Edit\n\n"
if [ ! -f worldedit.zip ]; then
    wget https://github.com/Uberi/Minetest-WorldEdit/archive/refs/tags/1.3.zip -O worldedit.zip
fi
if [ -d "Minetest-WorldEdit-1.3" ]; then
    rm -rf "Minetest-WorldEdit-1.3"
fi
unzip worldedit.zip
rm -vrf ./Build/mods/WORLDEDIT
cp -vr ./Minetest-WorldEdit-1.3 ./Build/mods/WORLDEDIT

printf "\n >>> Removing worldedit_gui\n\n"
rm -vrf ./Build/mods/WORLDEDIT/worldedit_gui

printf "\nAdding mcl_decor\n\n"
if [ ! -f decor.zip ]; then
    wget https://codeberg.org/rudzik8/mcl_decor/archive/v1.4_01.zip -O decor.zip
fi
if [ -d mcl_decor ]; then
    rm -rf mcl_decor
fi
unzip decor.zip
rm -vrf ./Build/mods/DECOR
cp -vr ./mcl_decor ./Build/mods/DECOR
