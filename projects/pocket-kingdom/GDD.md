# Pocket Kingdom - Game Design Document

**Version:** 1.0  
**Date:** 2026-02-20  
**Genre:** Match-3 + Kingdom Building  
**Platform:** Mobile (iOS/Android)

---

## 1. Game Overview

**Title:** Pocket Kingdom  
**Tagline:** Build your empire, one match at a time  
**Core Loop:** Match tiles → Earn resources → Build & upgrade kingdom → Progress through levels

---

## 2. Core Mechanics

### 2.1 Match-3 Puzzle

| Element | Description |
|---------|-------------|
| **Grid** | 8x8 tile grid |
| **Tile Types** | 🪙 Coin, 🌾 Wheat, 🪵 Wood, 💎 Gem, ⚔️ Sword |
| **Match** | 3+ same tiles in row/column |
| **Special Matches** | 4 in a row = Power-up, 5 in a row = Magic spell |

### 2.2 Resources

| Resource | Used For |
|---------|----------|
| 🪙 Coins | Upgrades, repairs |
| 🌾 Wheat | Feeding troops, population |
| 🪵 Wood | Buildings, repairs |
| 💎 Gems | Premium currency (optional) |
| ⚔️ Swords | Defense, events |

---

## 3. Kingdom Building

### 3.1 Buildings

| Building | Level | Effect |
|----------|-------|--------|
| 🏰 Castle | 1-10 | Main hub, determines max buildings |
| 🏠 House | 1-5 | +Population |
| 🌾 Farm | 1-5 | +Wheat generation |
| ⛏️ Mine | 1-5 | +Coins generation |
| 🪵 Lumber Mill | 1-5 | +Wood generation |
| 🛡️ Wall | 1-5 | Defense bonus |
| ⚔️ Barracks | 1-3 | Troop training |

### 3.2 Progression

- **Levels 1-10:** Unlock buildings one by one
- **Each level:** New puzzle challenge → Earn stars → Build rewards
- **3 stars per level:** Max rewards

---

## 4. User Interface

### 4.1 Screens

1. **Main Menu** - Play button, Settings
2. **World Map** - Select level/region
3. **Puzzle Screen** - Match-3 gameplay
4. **Kingdom View** - Tap to build/upgrade
5. **Shop** - Buy upgrades, power-ups

### 4.2 Visual Style

- **Art:** Colorful 2D cartoon style
- **Palette:** Warm, inviting colors (gold, green, brown)
- **UI:** Rounded buttons, clear icons

---

## 5. Monetization (Optional)

- **Ads:** Watch for extra moves
- **Gems:** Earn or purchase
- **No pay-to-win:** All content achievable free

---

## 6. Technical Stack

| Component | Recommendation |
|-----------|----------------|
| **Engine** | Godot 4.x (free) or Unity |
| **Language** | GDScript (Godot) or C# (Unity) |
| **Platform** | Export to Android/iOS |
| **Assets** | Kenney Assets or custom pixel art |

---

## 7. Development Phases

### Phase 1: Prototype (Week 1-2)
- [x] Basic match-3 grid
- [ ] Swap mechanics
- [ ] Match detection
- [ ] Basic UI

### Phase 2: Core Game (Week 3-4)
- [ ] Resource system
- [ ] Level progression
- [ ] Score calculation

### Phase 3: Kingdom (Week 5-6)
- [ ] Building placement
- [ ] Upgrade system
- [ ] Save/load

### Phase 4: Polish (Week 7-8)
- [ ] Graphics & animations
- [ ] Sound effects
- [ ] Testing & bugs

---

## 8. Immediate Next Steps

1. **Choose engine:** Godot (recommended for beginners)
2. **Install Godot** on your machine
3. **Create project** folder structure
4. **Build basic match-3 grid** as first prototype

---

*Let's build this! 🚀*
