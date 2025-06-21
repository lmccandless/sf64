# On-Rails Arwing Demo

This folder contains a minimal Processing sketch that demonstrates a basic on-rails
flight mode inspired by Star Fox 64.

## How to Run

1. Install the [Processing](https://processing.org/) IDE.
2. Open `ArwingOnRailsSketch.pde` inside the IDE.
3. Run the sketch.

Use the arrow keys to slide the ship around the screen while it gently tilts
left, right, up and down. Press `Z` or `X` to spin the Arwing for a quick
barrel roll. The camera follows closely from behind so the craft remains
centered.

If you have the original game data available you can export the Arwing model
with [splat](https://github.com/ethteck/splat) and place the resulting
`arwing.obj` next to the sketch file. The sketch will automatically load the
OBJ if present.
