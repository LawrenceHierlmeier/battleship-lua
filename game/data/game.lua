-- This is a table because lume can serialize these easily.
local GameInfo = {
  ["gamemode"] = "PlayerPlayer",
  ["isAiHardmode"] = false,
  ["isInGame"] = false,
  ["isPlayerOneTurn"] = true,
  ["playerOne"] = {
    ["ships"] = {
      ["c"] = Carrier(-1, -1),
      ["b"] = Battleship(-1, -1),
      ["r"] = Cruiser(-1, -1),
      ["s"] = Submarine(-1, -1),
      ["d"] = Destroyer(-1, -1)
    },
    ["shipGrid"] = makeGrid(10, 10, "~"),
    ["hitGrid"] = makeGrid(10, 10, "~"),
    ["health"] = 17
  },
  ["playerTwo"] = {
    ["ships"] = {
      ["c"] = Carrier(-1, -1),
      ["b"] = Battleship(-1, -1),
      ["r"] = Cruiser(-1, -1),
      ["s"] = Submarine(-1, -1),
      ["d"] = Destroyer(-1, -1)
    },
    ["shipGrid"] = makeGrid(10, 10, "~"),
    ["hitGrid"] = makeGrid(10, 10, "~"),
    ["health"] = 17
  },
}

return GameInfo