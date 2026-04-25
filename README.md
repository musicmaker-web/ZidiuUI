# ZidiuUI Documentation

## Introduction
ZidiuUI is a modern, fully-featured UI framework for Roblox. With its sleek gradient design, smooth animations, and a wide range of components, ZidiuUI provides a professional interface for your scripts. The library is obfuscated and loaded via loadstring—no ModuleScript required.

## Getting Loadstring
```lua
local ZidiuUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/musicmaker-web/ZidiuUI/refs/heads/main/ZidiuUI.lua"))()
```

## Creating a UI Window
```lua
local Window = ZidiuUI:CreateWindow("My Awesome Script")
```

## Creating a Tab
```lua
local Tab = Window:CreateTab("Home", "🏠")
```

## Creating a Section
```lua
local Section = Tab:CreateSection("Player Settings")
```

## Components

### Button
```lua
local Button = Section:CreateButton("Click Me!", function()
    print("Button clicked!")
    ZidiuUI:Notify("Button was clicked", "success", 2)
end)
```

### Toggle
```lua
local Toggle = Section:CreateToggle("Auto Sprint", true, function(state)
    print("Toggle state:", state)
end)

-- Update toggle state programmatically
Toggle:SetState(false)
```

### Dropdown
```lua
local Dropdown = Section:CreateDropdown("Select Weapon", {"Knife", "Pistol", "Rifle"}, function(selected)
    print("Selected:", selected)
end)

-- Refresh dropdown options
Dropdown:Refresh({"Sword", "Bow", "Axe"}, "Bow")
```

### Multi Dropdown
```lua
local MultiDropdown = Section:CreateMultiDropdown("Select Players", {"Player1", "Player2", "Player3"}, function(selected)
    print("Selected players:", table.concat(selected, ", "))
end)

-- Refresh multi-dropdown options
MultiDropdown:Refresh({"Ally1", "Ally2", "Ally3"}, {"Ally1", "Ally3"})
```

### Textbox
```lua
local Textbox = Section:CreateTextbox("Enter Message", "Type here...", function(text)
    print("User typed:", text)
end)

-- Set text programmatically
Textbox:SetText("Hello World!")
```

### Slider
```lua
local Slider = Section:CreateSlider("Walk Speed", 16, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
```

### Dual Slider
```lua
local DualSlider = Section:CreateDualSlider("Range Filter", 0, 100, 20, 80, function(min, max)
    print("Range:", min, "-", max)
end)

-- Get current values
print(DualSlider:GetMin(), DualSlider:GetMax())

-- Set range programmatically
DualSlider:SetRange(30, 70)
```

### Keybind
```lua
local Keybind = Section:CreateKeybind("Teleport Key", Enum.KeyCode.T, function(key, modifiers)
    print("Key pressed:", key, "Shift:", modifiers.shift, "Ctrl:", modifiers.ctrl)
end)

-- Get current key
print(Keybind:GetKey())

-- Set key programmatically
Keybind:SetKey(Enum.KeyCode.Q)
```

### Label
```lua
local Label = Section:CreateLabel("Status: Idle")

-- Update label text
Label:SetText("Status: Active")
```

### Search Dropdown
```lua
local SearchDropdown = Section:CreateSearchDropdown("Search Player", {"Alice", "Bob", "Charlie"}, function(selected)
    print("Selected:", selected)
end, true) -- 'true' enables multi-select mode

-- Get selected items
local selected = SearchDropdown:GetSelected()

-- Set new options
SearchDropdown:SetOptions({"David", "Eve", "Frank"})

-- Clear search field
SearchDropdown:ClearSearch()
```

### ExLabel (Independent Window)
The ExLabel creates a completely independent, floating text window with its own ScreenGui. Perfect for displaying logs, help texts, or any information you want to keep visible separately from the main UI.

```lua
local InfoWindow = Section:CreateExLabel("Script Logs", "Initializing script...\nLoading modules...\nReady!")

-- Update content
InfoWindow:SetText("New log entry:\nSomething happened!")

-- Change title
InfoWindow:SetTitle("System Console")

-- Show/hide window
InfoWindow:Open()
InfoWindow:Close()

-- Bring window to front
InfoWindow:Focus()

-- Destroy window completely
InfoWindow:Destroy()
```

### Tooltip
```lua
local Button = Section:CreateButton("Settings", function() end)
Button:SetTooltip("Click to open settings menu")
```

## Global Functions

### Notify (Toast Notification)
```lua
-- Types: "info", "success", "error", "warning"
ZidiuUI:Notify("Operation completed successfully!", "success", 3)
ZidiuUI:Notify("Something went wrong!", "error", 4)
```

### Set Toast Position
```lua
ZidiuUI:SetToastPosition("bottom-center")  -- "bottom-center", "bottom-right", "top-center"
```

## Complete Demo Script
```lua
-- Load the library
local ZidiuUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/musicmaker-web/ZidiuUI/refs/heads/main/ZidiuUI.lua"))()

-- Create main window
local Window = ZidiuUI:CreateWindow("ZidiuUI Demo")

-- ==== Player Tab ====
local PlayerTab = Window:CreateTab("Player", "👤")
local PlayerSection = PlayerTab:CreateSection("Movement Settings")

-- Walk speed slider
local SpeedSlider = PlayerSection:CreateSlider("Walk Speed", 16, 200, 16, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
    end
    StatusLabel:SetText("Walk Speed: " .. value)
end)

-- Jump power slider
local JumpSlider = PlayerSection:CreateSlider("Jump Power", 50, 150, 50, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = value
    end
end)

-- Auto sprint toggle
local SprintToggle = PlayerSection:CreateToggle("Auto Sprint", false, function(state)
    if state then
        SpeedSlider:SetValue(200)
        ZidiuUI:Notify("Auto Sprint enabled", "success", 2)
    else
        SpeedSlider:SetValue(16)
        ZidiuUI:Notify("Auto Sprint disabled", "info", 2)
    end
end)

-- Status label
local StatusLabel = PlayerSection:CreateLabel("Walk Speed: 16")

-- ==== Teleport Tab ====
local TeleportTab = Window:CreateTab("Teleport", "📍")
local TeleportSection = TeleportTab:CreateSection("Waypoints")

-- Waypoint selection dropdown
local Waypoints = {"Spawn", "Shop", "Arena", "Lobby"}
local WaypointDropdown = TeleportSection:CreateDropdown("Select Waypoint", Waypoints, function(selected)
    TeleportLabel:SetText("Selected: " .. selected)
end)

-- Teleport button
local TeleportButton = TeleportSection:CreateButton("Teleport", function()
    local selected = WaypointDropdown:GetValue()
    ZidiuUI:Notify("Teleporting to " .. selected .. "...", "info", 2)
    -- Teleport logic here
    TeleportLabel:SetText("Teleported to: " .. selected)
end)

-- Teleport status label
local TeleportLabel = TeleportSection:CreateLabel("No waypoint selected")

-- ==== Combat Tab ====
local CombatTab = Window:CreateTab("Combat", "⚔️")
local CombatSection = CombatTab:CreateSection("Weapons")

-- Weapon selection (multi)
local Weapons = {"Sword", "Bow", "Staff", "Dagger"}
local WeaponSelect = CombatSection:CreateMultiDropdown("Select Weapons", Weapons, function(selected)
    CombatLabel:SetText("Equipped weapons: " .. table.concat(selected, ", "))
end)

-- Combat toggle
local CombatToggle = CombatSection:CreateToggle("Auto Attack", false, function(state)
    if state then
        ZidiuUI:Notify("Auto Attack ENABLED", "warning", 2)
    else
        ZidiuUI:Notify("Auto Attack DISABLED", "info", 2)
    end
end)

local CombatLabel = CombatSection:CreateLabel("Select weapons above")

-- ==== Info Tab ====
local InfoTab = Window:CreateTab("Info", "ℹ️")
local InfoSection = InfoTab:CreateSection("Script Information")

-- Info button with tooltip
local InfoButton = InfoSection:CreateButton("Show Credits", function()
    local CreditsWindow = InfoSection:CreateExLabel("Credits", 
        "ZidiuUI v2.5\n\nCreated by: Zidiu\n\n" ..
        "Components:\n✓ ExLabel Windows\n✓ Search Dropdowns\n✓ Dual Sliders\n✓ Keybinds\n" ..
        "✓ Toast Notifications\n✓ Tooltip System"
    )
    CreditsWindow:Open()
end)
InfoButton:SetTooltip("Click to view script credits and version info")

-- Help ExLabel
local HelpWindow = InfoSection:CreateExLabel("Help & Tips", 
    "Welcome to ZidiuUI Demo!\n\n" ..
    "Tips:\n" ..
    "• Use '⊞ Resize' to toggle window resizing\n" ..
    "• Use '⤢ Move O/C' to move the FAB button\n" ..
    "• Use '✥ Move UI' to move the entire window\n" ..
    "• Click '?' buttons for tooltips\n" ..
    "• Toast notifications appear at bottom-right\n\n" ..
    "The Changelog tab (📋) is automatically created!"
)

InfoSection:CreateButton("Open Help Window", function()
    HelpWindow:Open()
end)

-- Show welcome notification
ZidiuUI:Notify("Welcome to ZidiuUI Demo!", "success", 3)
ZidiuUI:SetToastPosition("bottom-right")
```

## Notes
- The **Changelog tab** is automatically created in every window and cannot be removed.
- Toast notifications can be positioned using `ZidiuUI:SetToastPosition()`.
- Tooltips appear as popup frames when clicking the "?" button.
- Keybinds use `ContextActionService` and support modifier keys (Shift, Ctrl, Alt).
- The ExLabel component creates a **completely independent** window with its own ScreenGui, drag functionality, resizing, minimize/close buttons, and a built-in copy button for the text content. ✅
