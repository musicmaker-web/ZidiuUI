# ZidiuUI – Modern UI Library for Roblox Executors

**ZidiuUI** is a powerful, modern UI framework designed for Roblox executors (like Rayfield, Kavo, etc.). It provides an intuitive API for creating windows, tabs, sections, and interactive elements with elegant design, touch support, and many useful features.

> **⚠️ Important:** This library is **obfuscated** and meant to be used as an **external library** (like Rayfield or Kavo). You **DO NOT** need to download it.
---

## 📦 Installation (One Line)

Add this to your script:

```lua
local ZidiuUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/musicmaker-web/ZidiuUI/refs/heads/main/ZidiuUI.lua"))()
```

That's it! No downloading, no ModuleScript creation.

---

## 🚀 Complete API Reference

### 1. Create Window – `ZidiuUI:CreateWindow(title)`
Creates the main window with animated background and controls (Resize, Drag, Keybind toggle, FAB).

```lua
local Window = ZidiuUI:CreateWindow("My Admin Tool")
```

---

### 2. Create Tab – `Window:CreateTab(name, icon)`
Adds a tab with name and optional icon (default: "•").

```lua
local PlayerTab = Window:CreateTab("Players", "👤")
local SettingsTab = Window:CreateTab("Settings", "⚙️")
```

---

### 3. Create Section – `Tab:CreateSection(name)`
A collapsible section with green border for grouping elements.

```lua
local CombatSection = PlayerTab:CreateSection("Combat Settings")
```

---

### 4. Button – `Section:CreateButton(text, callback)`
Clickable button with animations and flash effect.

```lua
local btn = CombatSection:CreateButton("Teleport to Me", function()
    ZidiuUI:Notify("Teleport executed!", "success", 2)
end)

btn:SetTooltip("Teleports everyone to your location")
```

---

### 5. Toggle – `Section:CreateToggle(text, default, callback)`
Switch with green/red state and animated knob.

```lua
local godToggle = CombatSection:CreateToggle("Godmode", false, function(state)
    print("Godmode:", state)
end)

-- Change later
godToggle:SetState(true)
print(godToggle:GetState()) -- true
```

---

### 6. Dropdown (Single) – `Section:CreateDropdown(text, options, callback)`
Select one option from a list. Refreshable with `:Refresh()`.

```lua
local weaponDD = CombatSection:CreateDropdown("Weapon", {"Sword", "Bow", "Axe"}, function(selected)
    print("Selected:", selected)
end)

-- Update options later
weaponDD:Refresh({"Sword", "Hammer", "Spear"}, "Hammer")
print(weaponDD:GetValue()) -- "Hammer"
```

---

### 7. Multi-Dropdown – `Section:CreateMultiDropdown(text, options, callback)`
Select multiple options (checkboxes). Returns a table of selected values.

```lua
local effectsDD = CombatSection:CreateMultiDropdown("Effects", {"Fire", "Lightning", "Ice"}, function(selectedTable)
    print(table.concat(selectedTable, ", "))
end)

effectsDD:Refresh({"Fire", "Poison", "Stun"}, {"Fire", "Stun"})
```

---

### 8. Textbox – `Section:CreateTextbox(label, placeholder, callback)`
Text input with 0.5 second debounce.

```lua
local nameBox = SettingsTab:CreateSection("General"):CreateTextbox("Username", "Enter name...", function(text)
    print("New name:", text)
end)

nameBox:SetText("Player123")
print(nameBox:GetText()) -- "Player123"
```

---

### 9. Slider – `Section:CreateSlider(text, min, max, default, callback)`
Numeric slider with live value display.

```lua
local dmgSlider = CombatSection:CreateSlider("Damage Multiplier", 0, 10, 5, function(value)
    print("Multiplier:", value)
end)

dmgSlider:SetValue(7.5)
print(dmgSlider:GetValue()) -- 7.5
```

---

### 10. Keybind – `Section:CreateKeybind(text, defaultKey, callback)`
Assign a keyboard shortcut. Callback receives key and modifiers (Shift, Ctrl, Alt).

```lua
local flyKey = SettingsTab:CreateSection("Controls"):CreateKeybind("Fly", Enum.KeyCode.F, function(key, modifiers)
    print("Key:", key, "Shift?", modifiers.shift)
end)

flyKey:SetKey(Enum.KeyCode.G)
print(flyKey:GetKey()) -- Enum.KeyCode.G
flyKey:SetTooltip("Press this key to toggle flying")
```

---

### 11. Label – `Section:CreateLabel(text)`
Static or dynamic text. Use `:SetText()` to update.

```lua
local infoLabel = CombatSection:CreateLabel("Current status: Ready")
infoLabel:SetText("Current status: In Combat")
print(infoLabel:GetText()) -- "Current status: In Combat"
```

---

### 12. Search Dropdown – `Section:CreateSearchDropdown(label, options, callback, multi)`
Dropdown with live search – perfect for long lists. `multi` (true/false) controls single/multi selection.

```lua
local searchDD = SettingsTab:CreateSection("Advanced"):CreateSearchDropdown("Search Player", {"Alex", "Ben", "Clara"}, function(selected)
    print("Selected:", selected)
end, false) -- false = single selection
```

---

### 13. Dual Slider (Range) – `Section:CreateDualSlider(label, min, max, defaultMin, defaultMax, callback)`
Range slider with two knobs for min/max values.

```lua
local rangeSlider = SettingsTab:CreateSection("Advanced"):CreateDualSlider("Level Range", 1, 100, 10, 50, function(minVal, maxVal)
    print("Min:", minVal, "Max:", maxVal)
end)
```

---

### 14. Tooltip – `element:SetTooltip(text)`
Adds a "?" button next to the element that shows a tooltip when clicked.

```lua
local btn = CombatSection:CreateButton("Special Attack", function() end)
btn:SetTooltip("Performs a powerful area attack (30 second cooldown)")
```

---

### 15. Toast Notification – `ZidiuUI:Notify(message, type, duration)`
Shows a fading notification. Types: `"info"`, `"success"`, `"error"`, `"warning"`. Duration in seconds.

```lua
ZidiuUI:Notify("Welcome to the hub!", "success", 3)
ZidiuUI:Notify("Connection failed", "error", 5)
ZidiuUI:Notify("Server restart in 10 seconds", "warning", 4)
```

---

### 16. Toast Position – `ZidiuUI:SetToastPosition(pos)`
Available positions: `"bottom-right"` (default), `"bottom-center"`, `"top-center"`.

```lua
ZidiuUI:SetToastPosition("top-center")
```

---

### 17. Manual Tooltip – `ZidiuUI:ShowTooltip(text, position)` & `ZidiuUI:HideTooltip()`
Shows a freely positionable tooltip at a screen coordinate (Vector2).

```lua
-- Show tooltip
ZidiuUI:ShowTooltip("This is a hint", Vector2.new(200, 300))

-- Hide later
ZidiuUI:HideTooltip()
```

---

## 🧪 Complete Demo Script

```lua
-- Load the library
local ZidiuUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/musicmaker-web/ZidiuUI/refs/heads/main/ZidiuUI.lua"))()

-- Create window
local mainWin = ZidiuUI:CreateWindow("My Super Tool v2.4")

-- Create tabs
local combatTab = mainWin:CreateTab("Combat", "⚔️")
local settingsTab = mainWin:CreateTab("Settings", "⚙️")
local infoTab = mainWin:CreateTab("Info", "ℹ️")

-- === COMBAT SECTION ===
local combatSec = combatTab:CreateSection("Combat Options")

local attackBtn = combatSec:CreateButton("Attack", function()
    ZidiuUI:Notify("You attacked!", "success", 2)
end)
attackBtn:SetTooltip("Performs a normal attack")

local critToggle = combatSec:CreateToggle("Critical Strike", true, function(state)
    print("Critical:", state)
end)

local damageSlider = combatSec:CreateSlider("Damage", 1, 100, 50, function(val)
    print("Damage:", val)
end)

local weaponDD = combatSec:CreateDropdown("Weapon", {"Sword", "Axe", "Bow"}, function(sel)
    print("Weapon:", sel)
end)

-- === SETTINGS SECTION ===
local settingsSec = settingsTab:CreateSection("UI Controls")

local flyKeybind = settingsSec:CreateKeybind("Fly", Enum.KeyCode.F, function(key, mod)
    ZidiuUI:Notify("Fly toggled!", "info", 2)
end)
flyKeybind:SetTooltip("Press this key to toggle flying")

local posDropdown = settingsSec:CreateDropdown("Toast Position", {"bottom-right", "bottom-center", "top-center"}, function(pos)
    ZidiuUI:SetToastPosition(pos)
    ZidiuUI:Notify("Position changed to " .. pos, "info", 2)
end)

local nameBox = settingsSec:CreateTextbox("Player Name", "Enter new name...", function(txt)
    print("New name:", txt)
end)

-- Search dropdown example
local searchSec = settingsTab:CreateSection("Advanced")
local searchDD = searchSec:CreateSearchDropdown("Search Player", {"Alex", "Ben", "Clara", "David", "Emma"}, function(selected)
    print("Selected player:", selected)
end, false)

-- Dual slider example
local rangeSlider = searchSec:CreateDualSlider("Level Range", 1, 100, 10, 50, function(minVal, maxVal)
    print("Level range:", minVal, "-", maxVal)
end)

-- === INFO SECTION ===
local infoSec = infoTab:CreateSection("About This Tool")
infoSec:CreateLabel("Version 2.4")
infoSec:CreateLabel("Built with ZidiuUI")
infoSec:CreateButton("Visit GitHub", function()
    ZidiuUI:Notify("https://github.com/zidiu5/ZidiuUI", "info", 4)
end)

-- Show manual tooltip as welcome message
task.wait(2)
ZidiuUI:ShowTooltip("Welcome! Click the '?' buttons for help.", Vector2.new(100, 100))
task.wait(5)
ZidiuUI:HideTooltip()
```

---

## 📌 Important Notes

- The **Changelog Tab** is **automatically added** as the last tab – you don't need to create it yourself.
- All UI elements are **touch-compatible** (drag, resize, sliders, buttons).
- The **global keybind functionality** can be toggled on/off using the `⌨ Keybinds` button in the TopBar.
- Window controls: `⊞ Resize` (toggle resize handle), `⤢ Move O/C` (move FAB), `✥ Move UI` (move window).
- This library is **obfuscated** – do not attempt to modify it directly. Use the API as documented.

---

## 🆚 Compared to Other Libraries

| Feature | ZidiuUI | Rayfield | Kavo |
|---------|---------|----------|------|
| Touch Support | ✅ Full | ❌ Limited | ❌ No |
| Dual Slider | ✅ Yes | ❌ No | ❌ No |
| Search Dropdown | ✅ Yes | ❌ No | ❌ No |
| Toast Notifications | ✅ Yes | ❌ No | ❌ No |
| Keybinds with Modifiers | ✅ Yes | ✅ Yes | ❌ No |
| Automatic Changelog | ✅ Yes | ❌ No | ❌ No |

---

## 🎉 Conclusion

**ZidiuUI** is a modern, feature-rich UI library designed for Roblox executors. It combines the best features of popular libraries like Rayfield and Kavo while adding unique components like dual sliders, search dropdowns, and full touch support.

**Load it in one line and start building!**

```lua
local ZidiuUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/musicmaker-web/ZidiuUI/refs/heads/main/ZidiuUI.lua"))()
```
