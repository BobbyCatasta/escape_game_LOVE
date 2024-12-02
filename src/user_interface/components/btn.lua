local button = gClass("button")



---new
---@param table table
---@param text string
---@param callback function
---@param offset number
function button:initialize(table,text, callback,offset)
    button.Validate(table,text,callback)
   self.x = table.x 
   if(offset ~= nil) then
        self.y = table.y + offset
    else
        self.y = table.y 
   end
   self.baseColor =  table.baseColor 
   self.hoveredColor = table.hoveredColor 
   self.width = table.width 
   self.height = table.height 
   self.colorLine = table.colorLine
   self.lineWidth = table.lineWidth
   self.text = text 
   self.callback = callback
   self.isHovered = false
end

function button:draw()
    -- Colore in base allo stato del bottone (hovered)\
    if not self.isHovered then
        love.graphics.setColor(self.baseColor)
    else
        love.graphics.setColor(self.hoveredColor)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(self.colorLine)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    -- Testo
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(self.text, self.x, self.y + self.height / 4, self.width, "center")
end

function button:update(mouseX,mouseY,leftMouseClicked)
    self.isHovered = (mouseX>=self.x and mouseX <= self.x + self.width) and (mouseY >= self.y and mouseY <= self.y + self.height)
    self:ButtonPressed(leftMouseClicked)
end



---Checks if the left mouse button is pressed over the this button
---@param leftMouseClicked boolean
function button:ButtonPressed(leftMouseClicked) -- Checks if Button Is Hovered and calls the callback to the function
    if self.isHovered and leftMouseClicked then
        if(self.callback) then
            self.callback()
        end
    end
end

---comment
---@param table table
---@param text string
---@param callback function
function button.Validate(table,text,callback)
    if type(table.x) ~= "number" or type(table.y) ~= "number" or type(table.hoveredColor) ~= "table" or type(table.width) ~= "number" or type(table.height) ~= "number" 
    or type(text) ~= "string" or type(table.lineWidth) ~= "number" or type(callback) ~= "function" then
        error("Some of the parameters you just inserted in this constructor are not correct.")
    end
end
---Static Function to create a preset of a certain Button
---@param x any
---@param y any
---@param baseColor any
---@param hoveredColor any
---@param width any
---@param height any
---@param text any
---@param colorLine any
---@param lineWidth any
---@return table
function button.CreateButton(x,y,baseColor,hoveredColor,width,height,text,colorLine,lineWidth)
    return {
        x = x,
        y = y,
        baseColor = baseColor,
        hoveredColor = hoveredColor,
        width = width,
        height = height,
        colorLine = colorLine,
        lineWidth = lineWidth,
    }
end

return button

