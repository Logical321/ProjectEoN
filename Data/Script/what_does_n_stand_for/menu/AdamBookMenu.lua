--[[
    AdamBookMenu

    A menu that's supposed to be Adam's Journal.
]]

--- Summary menu that displays a description box.
AdamBookMenu = Class("AdamBookMenu")

--- Generates a new AdamBookMenu object set in the provided coordinates.
--- @param left number the x coordinate of the left side of the window.
--- @param top number the y coordinate of the top side of the window.
--- @param right number the x coordinate of the right side of the window.
--- @param bottom number the y coordinate of the bottom side of the window.
--- @param label string the label that will be applied to this menu. Defaults to "DESCRIPTION_SUMMARY_LUA"
function AdamBookMenu:initialize(left, top, right, bottom, label) --I'm supposed to just figure this out?
    label = label or "DESCRIPTION_SUMMARY_LUA"
    self.window = RogueEssence.Menu.SummaryMenu(label, RogueElements.Rect.FromPoints(
            RogueElements.Loc(left, top), RogueElements.Loc(right, bottom)))

    local GraphicsManager = RogueEssence.Content.GraphicsManager
    self.description_box = RogueEssence.Menu.DialogueText("", RogueElements.Rect.FromPoints(
            RogueElements.Loc(GraphicsManager.MenuBG.TileWidth * 2, GraphicsManager.MenuBG.TileHeight),
            RogueElements.Loc(self.window.Bounds.Width - GraphicsManager.MenuBG.TileWidth * 2, self.window.Bounds.Height - GraphicsManager.MenuBG.TileHeight * 2)),
            12);
    self.window.Elements:Add(self.description_box);
end

--- sets the provided string as the currently displayed description.
--- @param description string the description to be set.
function AdamBookMenu:setDescription(description)
    self.description_box:SetAndFormatText(description);
end