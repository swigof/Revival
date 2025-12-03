# The Art of Fine Printing

A short clicker game inspired by the 1932 public domain film The Animal Kingdom

This was my first ever time using Godot and I'm quite happy with how the project turned out.
There's certainly some improvements that could be made though.
The script and scene structure took a little getting used to and I could have sub-scened more game elements.
The monolithic game manager was born out of time pressure and ought to have been broken into multiple files.
There's also some cleanup on various assets I wanted to do that I never got the time for.
But otherwise, this simple game works well and was generally straightforward to make using only GDScript.
Godot's a very robust and extensible engine and I look forward to using it more.

## Project Setup

### Engine

The project was originally made with Godot 4.5-stable so that's the best version to use but newer 
versions could also work

### Assets

Assets for the project can be downloaded from 
[here](https://github.com/swigof/Revival/releases/download/1.0.0/assets.zip)

The contents of the archive should be placed in a top level `assets` directory

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
