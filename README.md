# Revival

Made with Godot 4.5-stable

### Release Builds

The release builds for this project use a custom engine export template, 
which requires building Godot for web.
This requires installing [Emscripten](https://emscripten.org/) and preferably
having it activated in your PATH.

After cloning the project run the 
```git submodule update --init``` 
on its directory to get the godot engine sources.

Then, navigate to the `engine/godot/` directory and build the engine with
```
scons target=template_release production=yes threads=no platform=web debug_symbols=no lto=full optimize=size_extra build_profile=../../optimized.gdbuild
```

You'll then be able to build the game's release version from the editor.

### Addons

[Godot VCS Git Plugin v3.2.1](https://github.com/godotengine/godot-git-plugin/releases/tag/v3.2.1)
