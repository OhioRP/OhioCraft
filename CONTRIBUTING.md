# Contributing

## Before making any changes

Any OhioCraft related changes must be made inside [the modpack](./Mods). <br>
If you want to modify MineClone2's source code, please add a patch for that in [the Patches folder](./Patches). Preferably, the patch should be a diff between `./mineclone2/mods/path/to/file` and `./Build/mods/path/to/file`, where `./Build/mods/path/to/file` is the modified file (just for the sake of consistency between patches). Then you should add a line to [`build.sh`](./build.sh) that applies the patch to the relevant file.

## Code conventions

- Everything is formatted using [`lua-language-server`](https://github.com/LuaLS/lua-language-server)
- Avoid trailing commas
- Everything is indented with 4 spaces

## Adding media

If you want to add any kind of media (like textures or sounds) into the project, please make sure the licensing allows it to be added. <br>
In case of self-created content, you will need to agree that your content will be licensed under the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). <br>
After adding any kind of media, please specify the author and the license in a README file inside the mod's `textures` or `sounds` folder, depending on the folder you added your media to.
