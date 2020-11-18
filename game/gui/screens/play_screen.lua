PlayScreen = BaseScreen:extend()

function PlayScreen:new(color, bg_image)
    PlayScreen.super.new(self, {.3, .5, .3, 1.0}, nil)

    GAME_INFO["isPlayerOneTurn"] = true
    self.fired = false

    self.cellSize = 50
    self.gridSize = 10

    self.widgets = {
        GameGrid(
            40, 70, self.cellSize, self.gridSize, GAME_INFO["playerOne"]["shipGrid"], nil
        ),
        GameGrid(
            740 , 70, self.cellSize, self.gridSize, GAME_INFO["playerOne"]["hitGrid"], nil,
            function()
                self:fire()
            end
        ),
        Button(
            "Finish turn",
            function()
                if not self.fired then
                    return
                end

                local opponent = "playerTwo"
                self.fired = false

                self:swapToOpponent()
                GAME_INFO["isPlayerOneTurn"] = not GAME_INFO["isPlayerOneTurn"]
            end,
            540, 648, 200, 50
        ),
        Label(
            "Your ships:",
            190, 40, 200,
            {1.0, 1.0, 1.0, 1.0}, "center"
        ),
        Label(
            "Your shots:",
            895, 40, 200,
            {1.0, 1.0, 1.0, 1.0}, "center"
        ),
        Label(
            (GAME_INFO["isPlayerOneTurn"] and "Player One's Turn") or "Player Two's Turn",
            515, 10, 250,
            {1.0, 1.0, 1.0, 1.0}, "center"
        ),
        Button(
          "Save game",
          function()
            saveGame() -- TODO Add the error checking here.
          end,
          540, 588, 200, 50
        )
    }
end

function PlayScreen:reset()
  local player = GAME_INFO["isPlayerOneTurn"] and "playerOne" or "playerTwo"
  self.widgets[1].grid = GAME_INFO[player]["shipGrid"]
  self.widgets[2].grid = GAME_INFO[player]["hitGrid"]
end

function PlayScreen:swapToOpponent()
  local opponent = GAME_INFO["isPlayerOneTurn"] and "playerTwo" or "playerOne"
  self.widgets[1].grid = GAME_INFO[opponent]["shipGrid"]
  self.widgets[2].grid = GAME_INFO[opponent]["hitGrid"]
end

function PlayScreen:fire()
    if self.fired then
        return
    end

    local gGrid = self.widgets[2]
    local player = "playerOne"
    local opponent = "playerTwo"

    if not GAME_INFO["isPlayerOneTurn"] then
        player = "playerTwo"
        opponent = "playerOne"
    end

    if gGrid.selectedX ~= -1 and gGrid.selectedY ~= -1
            and GAME_INFO[player]["hitGrid"][gGrid.selectedY][gGrid.selectedX] ~= "h"
    then
        self.fired = true

        GAME_INFO[player]["hitGrid"][gGrid.selectedY][gGrid.selectedX] = "h"
        GAME_INFO[opponent]["shipGrid"][gGrid.selectedY][gGrid.selectedX] = "h"
        GAME_INFO[opponent]["health"] = GAME_INFO[opponent]["health"] - 1

        if GAME_INFO[opponent]["health"] == 0 then
            --[[Switch to ending screen]]
        end
    end
end

function PlayScreen:load()
    missed = love.graphics.newImage('game/overlays/miss.png')
end

function PlayScreen:update()
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    local gGrid = self.widgets[2]

    if (checkRectCollision(mouseX, mouseY, gGrid.x, gGrid.y, 
        gGrid.gridx*gGrid.cellSize, gGrid.gridy*gGrid.cellSize )) then
            gGrid.selectedX = math.floor((mouseX - gGrid.x) / gGrid.cellSize) + 1
            gGrid.selectedY = math.floor((mouseY - gGrid.y) / gGrid.cellSize) + 1
    else
            gGrid.selectedX = -1
            gGrid.selectedY = -1
    end
end

function PlayScreen:drawOverlay()
    local gGrid = self.widgets[2]

    print("Missed")

    GAME_INFO["playerTwo"]["shipGrid"][gGrid.selectedY][gGrid.selectedX] = "~"

end
