# Building
Install a WASM compiler. Tested with emsdk 2.0.31.
```
mkdir -p ~/dev
cd ~/dev
git clone https://github.com/emscripten-core/emsdk.git
~/dev/emsdk/emsdk install 2.0.31
~/dev/emsdk/emsdk activate 2.0.31
source ~/dev/emsdk/emsdk_env.sh
```

Build the project.
```
./build.sh
```

# BrowserHack

NetHack ported to the Web by Lu Wang

## [Play on Kongregate](http://www.kongregate.com/games/coolwanglu/browserhack)
## [Play on GitHub](http://coolwanglu.github.io/BrowserHack)

### Screenshots
![Screenshot](https://raw.githubusercontent.com/coolwanglu/BrowserHack/master/screenshot.png)
![Screenshot2](https://raw.githubusercontent.com/coolwanglu/BrowserHack/master/screenshot2.png)
![Screenshot3](https://raw.githubusercontent.com/coolwanglu/BrowserHack/master/screenshot3.png)

Most porting stuffs go to `win/web/*` and `web/*`.

To build the project, read and modify `build.sh` according to your environment, install dependencies, and use some good luck.

Only minimum features are supported while I'm rushing to make it work, but more features are coming.
Search for `TODO` in `win/web/*` and `web/*`.

Need help for game testing, implementing more features and designing the interface.

### Tilesets
- `Default_32.png`
  - The default tileset from vanilla NetHack 
  - http://nethackwiki.com/wiki/Default_tileset_scaled_to_32x32
- `DawnHack_32.png`
  - By DragonDePlatino
  - Creative Commons Attribution 3.0 License
  - http://dragondeplatino.deviantart.com/art/DawnHack-NetHack-3-4-3-UnNetHack-5-1-0-416312313
- `Absurd_32.png`
  - By John Shaw
  - http://nethackwiki.com/wiki/The_Absurd_NetHack_Tileset
- `Nevanda_32.png`
  - By Nevanda
  - http://nevanda.deviantart.com/art/nethack-tiles-32x32px-416691316
- `Geoduck_40x24.png`
  - By geoduck42
  - http://geoduck42.deviantart.com/art/Geoduck-s-4-0-NetHack-Tiles-305559245
- `NethackModern_32.png`
  - By Tower Hufham
  - http://sourceforge.net/projects/nethackmodern/


### How to use number pad for movements?
Press `O` and set `number_pad` to 1. Make sure that NumLock is on.
You can make this permanent by setting it in options (the cog icon in the top-right corner), then reload the game. 

### How to apply my tileset?
Run this in your browser console:
`nethack.apply_tilset(tile_file_url, tile_width, tile_height);`

### Where is my favorite ASCII interface?
As a player of SuperZZT, yeah, I agree that ASCII is definitely important. But it might worth a separate port. Even if the characters are implemented as a special type of tilesets, you may not get the smooth input experience.

Checkout [nethack.alt.org (aka NAO)](http://alt.org/nethack/) where you can play the ASCII version online.
