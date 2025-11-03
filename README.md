# The Art of Fine Printing

A short clicker game made with Godot

Inspired by the 1932 public domain film The Animal Kingdom

## Project Setup

### Engine

The project was originally made with Godot 4.5-stable so that's the best version to use but newer 
versions could also work

### Assets

TODO

### Addons

The project has a few plugin dependencies

Their folders should be placed in a top level `addons` directory

[Dialogue Manager 3.8.1](https://github.com/nathanhoad/godot_dialogue_manager/releases/tag/v3.8.1)

#### Editor Only

The following editor plugins aren't required for builds but there may be configuration issues
opening the project without them

[Godot VCS Git Plugin v3.1.1](https://github.com/godotengine/godot-git-plugin/releases/tag/v3.1.1)

[GDTerm (Godot In-Editor Terminal) 1.0.2](https://github.com/markeel/gdterm/releases/tag/v1.0.2)

## Builds

Open the project in Godot and use the export dialog with preset `Web (Runnable)` to build

Build files will be placed in `build/web/`
