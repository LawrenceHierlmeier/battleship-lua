--Screen for Ship Placement

PlacementScreen = BaseScreen:extend()

function PlacementScreen:new(gridx, gridy)
    PlacementScreen.super.new(self, {.3, .5, .3, 1.0}, nil)

    self.cellSize = 50
    self.gridSize = 10
    self.numberPlaced = 0
    self.newSelect = false

    -- Checks if player one is the active player for placement screen
    self.isOneSelected = true

    self.selectedShip = "none"
    local rotateSwitch = function()
        local widgetTable = {
            ["c"] = 8,
            ["b"] = 9,
            ["r"] = 10,
            ["s"] = 11,
            ["d"] = 12
        }
        if self:getShips()[self.selectedShip].width > 1 then
            self.widgets[widgetTable[self.selectedShip]].text = "H"
        else
            self.widgets[widgetTable[self.selectedShip]].text = "V"
        end
    end

    self.widgets = {
        Button( --1
            "Carrier (5)",
            function()
                self.selectedShip = "c"
                self:updateShipButtonColor(1)
                self.newSelect = true
            end,
            230, 70, 150, 40  -- x, y, width, height
        ),
        Button( --2
            "Battleship (4)",
            function()
                self.selectedShip = "b"
                self:updateShipButtonColor(2)
                self.newSelect = true
            end,
            230, 115, 150, 40  -- x, y, width, height
        ),
        Button( --3
            "Cruiser (3)",
            function()
                self.selectedShip = "r"
                self:updateShipButtonColor(3)
                self.newSelect = true
            end,
            230, 160, 150, 40  -- x, y, width, height
        ),
        Button( --4
            "Submarine (3)",
            function()
                self.selectedShip = "s" 
                self:updateShipButtonColor(4)
                self.newSelect = true
            end,
            230, 205, 150, 40  -- x, y, width, height
        ),
        Button( --5
            "Destroyer (2)",
            function()
                self.selectedShip = "d"
                self:updateShipButtonColor(5)
                self.newSelect = true
            end,
            230, 250, 150, 40  -- x, y, width, height
        ),
        Button( --6
            "Rotate",
            function()
                if self.selectedShip ~= "none" and self:getShips()[self.selectedShip].x == -1 then
                    self:getShips()[self.selectedShip].rotate(self:getShips()[self.selectedShip])
                    rotateSwitch()
                end
            end,
            900, 70, 150, 40  -- x, y, width, height
        ),
        Button( --7
            "Remove",
            function()
                if self.selectedShip ~= "none" then
                    for y = 1, #self:getGrid() do
                        for x = 1, #self:getGrid()[1] do
                            if self:getGrid()[x][y] == self.selectedShip then
                                -- clears ship id from board and sets the posistion back to the intitial state
                                -- currently keeps current ship rotation 
                                self:getGrid()[x][y] = "~" 
                                self:getShips()[self.selectedShip].x = -1 
                                self:getShips()[self.selectedShip].y = -1
                            end
                        end
                    end
                end
                if self.numberPlaced > 0 and self.newSelect == true then
                    self.numberPlaced = self.numberPlaced - 1
                    self.widgets[14].enabled = false
                    self.newSelect = false
                    self.selectedShip = "none"
                    self:updateShipButtonColor(self.selectedShip)
                end
            end,
            900, 115, 150, 40  -- x, y, width, height
        ),
        Label( --8
            "V",
            205, 70, 25, {1.0, 1.0, 1.0, 1.0}, "left", 20 -- x, y, width, color, align
        ),
        Label( --9
            "V",
            205, 115, 25, {1.0, 1.0, 1.0, 1.0}, "left", 20 -- x, y, width, color, align
        ),
        Label( --10
            "V",
            205, 160, 25, {1.0, 1.0, 1.0, 1.0}, "left", 20 -- x, y, width, color, align
        ),
        Label( --11
            "V",
            205, 205, 25, {1.0, 1.0, 1.0, 1.0}, "left", 20 -- x, y, width, color, align
        ),
        Label( --12
            "V",
            205, 250, 25, {1.0, 1.0, 1.0, 1.0}, "left", 20 -- x, y, width, color, align
        ),
        GameGrid( --13
            390 ,70, self.cellSize, self.gridSize, self:getGrid(), nil,
            function()
                self:newPlaceShip()
            end
        ),
        Button( --14
            "Search for Player",
            function()
                GAME_INFO["gamemode"] = "PlayerComputer"

                if GAME_INFO["gamemode"] == "PlayerComputer" then
                    AIPlaceShips("playerTwo", self.gridSize)
                elseif GAME_INFO["gamemode"] == "ComputerComputer" then
                    AIPlaceShips("playerOne", self.gridSize)
                    AIPlaceShips("playerTwo", self.gridSize)
                end

                love.timer.sleep(love.math.random(10,22))

                SCREEN_MAN:changeScreen("play")
            end,
            900, 160, 150, 250  -- x, y, width, height
        )
    }
end

function PlacementScreen:newPlaceShip()
    local gGrid = self.widgets[13] -- Just to make code cleaner

    if self.selectedShip ~= "none" and self:getShips()[self.selectedShip].x == -1
        and gGrid.selectedX ~= -1 and gGrid.selectedY ~= -1
        and gGrid.gridx - gGrid.selectedX + 1 >= self:getShips()[self.selectedShip].width
        and gGrid.gridy - gGrid.selectedY + 1 >= self:getShips()[self.selectedShip].length
    then
        -- If all spaces are open
        if canPlaceShip(gGrid.selectedX, gGrid.selectedY, self:getShips()[self.selectedShip], self:getGrid()) then
            -- Set x and y in ship object
            self:getShips()[self.selectedShip].x = gGrid.selectedX
            self:getShips()[self.selectedShip].y = gGrid.selectedY
            self.numberPlaced = self.numberPlaced + 1
            -- Add ship to grid
            for l = 0, self:getShips()[self.selectedShip].length - 1 do
                for w = 0, self:getShips()[self.selectedShip].width - 1 do
                    self:getGrid()[gGrid.selectedY + l][gGrid.selectedX + w] = self.selectedShip
                end
            end
        end
    end

    if self.numberPlaced == 5 and (GAME_INFO["gamemode"] == "PlayerComputer" or GAME_INFO["gamemode"] == "PlayerPlayer") then
        self.widgets[14].enabled = true
    end
end

function PlacementScreen:reset()
    if GAME_INFO["gamemode"] ~= "PlayerPlayer" then
        self.widgets[16].visible = false
        self.widgets[16].enabled = false

        self.widgets[17].visible = false
        self.widgets[17].enabled = false
        if GAME_INFO["gamemode"] == "PlayerComputer" then
            self.widgets[14].enabled = false
        else
            for i = 1, 7 do
                self.widgets[i].enabled = false
            end
        end
    else
        self.widgets[14].enabled = false
        
    end

end

function PlacementScreen:update()
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    local gGrid = self.widgets[13]

    if (checkRectCollision(mouseX, mouseY, gGrid.x, gGrid.y, 
        gGrid.gridx*gGrid.cellSize, gGrid.gridy*gGrid.cellSize )) then
            gGrid.selectedX = math.floor((mouseX - gGrid.x) / gGrid.cellSize) + 1
            gGrid.selectedY = math.floor((mouseY - gGrid.y) / gGrid.cellSize) + 1
    else
            gGrid.selectedX = -1
            gGrid.selectedY = -1
    end
end

--[[
    Meant to update all of the ship select buttons to reflect which one is selected currently.

    Parameters:
        btnSelected - The index of the button that has a ship selected now. Should be [1-5]
]]
function PlacementScreen:updateShipButtonColor(btnSelected)
    if (self.selectedShip == "none") then -- No idea how this could happen, but just in case.
        for i=1, 5 do
            self.widgets[i].color = {0.2, 0.2, 0.8, 1.0}
        end
        return
    end

    for i=1, 5 do
        self.widgets[i].color = {0.2, 0.2, 0.8, 1.0}
    end

    self.widgets[btnSelected].color = self:getShips()[self.selectedShip].color
end

function PlacementScreen:changePlayer()
  if (GAME_INFO["gamemode"] ~= "PlayerPlayer") then
    return
  end
  self.isOneSelected = not (self.isOneSelected)

  self.widgets[13].grid = self:getGrid()
  self.widgets[15].text = (self.isOneSelected and "Player One") or "Player Two"
end

function PlacementScreen:getGrid()
  if self.isOneSelected then
    return GAME_INFO["playerOne"]["shipGrid"]
  end
  return GAME_INFO["playerTwo"]["shipGrid"]
end

function PlacementScreen:getShips()
  if self.isOneSelected then
    return GAME_INFO["playerOne"]["ships"]
  end
  return GAME_INFO["playerTwo"]["ships"]
end