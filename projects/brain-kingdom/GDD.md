# Brain Kingdom - Game Design Document

**Version:** 2.0  
**Date:** 2026-02-20  
**Genre:** Educational Puzzle / Brain Training  
**Platform:** Mobile (iOS/Android)

---

## 1. Game Overview

**Title:** Brain Kingdom 🧠🏰  
**Tagline:** Train your brain, build your kingdom  
**Total Levels:** **2000**  
**Core Loop:** Solve puzzles → Earn coins & stars → Build/upgrade kingdom → Unlock harder levels

---

## 2. Level Structure (2000 Levels)

### Kingdom Tiers (Realms)

| Realm | Levels | Difficulty | Unlock Requirement |
|-------|--------|------------|-------------------|
| 🌱 Grove | 1-400 | Beginner | Start |
| 🏕️ Village | 401-800 | Easy | 100 ⭐ |
| 🏘️ Town | 801-1200 | Medium | 300 ⭐ |
| 🏙️ City | 1201-1600 | Hard | 600 ⭐ |
| 🏰 Kingdom | 1601-1900 | Expert | 1000 ⭐ |
| 👑 Empire | 1901-2000 | Master | 1500 ⭐ |

### Sub-Divisions (within each Realm)
- Each Realm has **4 Provinces** (100 levels each)
- Each Province has **10 Districts** (10 levels each)
- Each District = 1 puzzle level

---

## 3. Puzzle Distribution

### Per Level Types (Rotating)

| Puzzle Type | Frequency | Examples |
|-------------|-----------|----------|
| 🔢 Math | 30% | Arithmetic, Algebra, Geometry |
| 🏷️ Riddles | 20% | Wordplay, Logic |
| 🔬 Science | 15% | Physics, Chem, Bio, Space |
| 🎯 Patterns | 15% | Sequences, Shapes |
| 🧠 Memory | 10% | Recall, Match |
| 📝 Words | 10% | Anagrams, Spelling |

### Distribution Formula
- **Levels 1-400 (Grove):** 80% Easy, 20% Medium
- **Levels 401-800 (Village):** 50% Easy, 40% Medium, 10% Hard
- **Levels 801-1200 (Town):** 20% Easy, 50% Medium, 30% Hard
- **Levels 1201-1600 (City):** 10% Medium, 60% Hard, 30% Expert
- **Levels 1601-1900 (Kingdom):** 40% Hard, 50% Expert, 10% Master
- **Levels 1901-2000 (Empire):** 100% Master

---

## 4. Difficulty Progression

### Math Difficulty Curve

| Realm | Operations | Examples |
|-------|-----------|----------|
| Grove | +, -, ×, ÷ | 5 + 3 = ?, 12 ÷ 4 = ? |
| Village | Powers, Roots, Basic Algebra | x + 5 = 12, √16 = ? |
| Town | Equations, Percentages, Geometry | 2x + 3 = 15, 25% of 80 |
| City | Trigonometry, Quadratics | sin(30°), x² - 5x + 6 = 0 |
| Kingdom | Calculus Intro, Limits | dy/dx of x², lim x→∞ 1/x |
| Empire | Advanced Calculus, Series | ∫x²dx, Σn from 1 to ∞ |

### Science Depth

| Realm | Topics |
|-------|--------|
| Grove | Basic facts, Planets, Animals |
| Village | Weather, Simple chemistry, Anatomy |
| Town | Physics formulas, Periodic table |
| City | Quantum concepts, Genetics |
| Kingdom | Astrophysics, Advanced chemistry |
| Empire | Research-level questions |

---

## 5. Scoring System

### Stars per Level
| Condition | Stars |
|-----------|-------|
| Correct (1st try) | ⭐⭐⭐ |
| Correct (2nd try) | ⭐⭐ |
| Correct (3rd try) | ⭐ |
| Used hint | ⭐ (max) |
| Skip | No stars |

### Speed Bonus
| Time | Bonus |
|------|-------|
| <3 sec | +1 ⭐ |
| <5 sec | +1 ⭐ |

### Streak System
| Streak | Bonus |
|--------|-------|
| 5 correct | +10 coins |
| 10 correct | +25 coins |
| 25 correct | +100 coins |

---

## 6. Coin Economy

### Earning
| Action | Coins |
|--------|-------|
| Correct answer | 5-15 (by difficulty) |
| Star bonus | 2-5 per star |
| Daily challenge | 50-200 |

### Spending
| Item | Cost |
|------|------|
| Hint | 25 coins |
| +10 seconds | 15 coins |
| Skip puzzle | 10 coins |
| 50/50 | 30 coins |
| Unlock realm | 500-2000 coins |

---

## 7. Kingdom Building (Cosmetic)

### Kingdom Elements

| Element | Unlock Realm | Cost |
|---------|--------------|------|
| 🌱 Garden | Grove | Free |
| 🏕️ Houses | Village | 100 coins |
| 🌾 Farm | Village | 150 coins |
| 🏘️ Market | Town | 300 coins |
| ⛪ Church | Town | 400 coins |
| 🏰 Castle | City | 750 coins |
| 🏛️ Academy | City | 1000 coins |
| 🔬 Lab | Kingdom | 1500 coins |
| 🛸 UFO | Empire | 2500 coins |

---

## 8. Puzzle Types (Detailed)

### 8.1 Math (600+ levels)
- Arithmetic operations
- Algebraic equations
- Geometry (area, perimeter, angles)
- Trigonometry
- Calculus basics
- Number sequences
- Percentages & ratios
- Statistics basics

### 8.2 Riddles (400+ levels)
- Classic riddles
- Wordplay
- Lateral thinking
- Logic puzzles
- "What am I?" puzzles

### 8.3 Science (300+ levels)
- Astronomy (planets, stars, space)
- Physics (forces, energy, waves)
- Chemistry (elements, reactions)
- Biology (anatomy, ecosystems)
- Earth science (weather, geology)

### 8.4 Patterns (300+ levels)
- Number sequences
- Shape patterns
- Matrix completion
- Odd one out
- Analogies

### 8.5 Memory (200+ levels)
- Sequence recall
- Match pairs
- Remember details
- Image recall

### 8.6 Words (200+ levels)
- Anagrams
- Spelling
- Synonyms/Antonyms
- Word search
- Fill in the blank

---

## 9. Procedural Generation (For Scale)

### Auto-Generated Puzzles

**Math:**
- Random arithmetic (Tier-based difficulty)
- Equation generators
- Sequence generators

**Patterns:**
- Shape/grid patterns
- Number sequences (arithmetic, geometric, Fibonacci)

**Science Facts:**
- Database of 500+ facts
- Random selection by tier

### Hand-Crafted Puzzles
- Riddles (need creativity)
- Memory games (need design)
- Complex logic puzzles

---

## 10. Content Generation Plan

### Phase 1: Core (1-500 levels)
- 150 Math (procedural)
- 100 Riddles (hand-crafted)
- 75 Science (database)
- 75 Patterns (procedural)
- 50 Memory (designed)
- 50 Words (hand-crafted)

### Phase 2: Expansion (501-1000)
- Same distribution
- Increase difficulty

### Phase 3: Expansion (1001-1500)
- More procedural
- Expert-level content

### Phase 4: Final (1501-2000)
- Master-level
- Special challenges

---

## 11. Sample Puzzles by Realm

### Grove (1-400)
**Level 1:** Math: 2 + 3 = ?  
**Level 50:** Riddle: What has keys but can't open locks? (Piano)  
**Level 100:** Science: What is H2O? (Water)  
**Level 200:** Pattern: 2, 4, 6, 8, ? (10)  
**Level 350:** Memory: Show 5 items, recall after 3 seconds  

### Village (401-800)
**Level 450:** Math: 3x = 12, find x (4)  
**Level 500:** Pattern: 1, 1, 2, 3, 5, ? (8 - Fibonacci)  
**Level 650:** Science: What planet is the largest? (Jupiter)  
**Level 750:** Riddle: I speak without a mouth... (Echo)  

### Town (801-1200)
**Level 850:** Math: 25% of 80 = ? (20)  
**Level 950:** Geometry: Area of rectangle 5×4 = ? (20)  
**Level 1050:** Science: What gas do plants need? (CO2)  
**Level 1150:** Pattern: Complete: 3, 6, 12, 24, ? (48)  

### City (1201-1600)
**Level 1250:** Math: Solve: x² = 16 (x = ±4)  
**Level 1350:** Trigonometry: sin(90°) = ? (1)  
**Level 1500:** Science: What is photosynthesis?  

### Kingdom (1601-1900)
**Level 1650:** Math: dy/dx of x³ (3x²)  
**Level 1800:** Physics: What is E = mc²? (Einstein's formula)  

### Empire (1901-2000)
**Level 1950:** Calculus: ∫2x dx = ? (x² + C)  
**Level 2000:** Ultimate challenge - mixed types!  

---

## 12. Development Roadmap

### MVP (Levels 1-200)
- [ ] Core puzzle engine
- [ ] 200 hand-crafted + procedural levels
- [ ] Basic scoring & stars
- [ ] Simple kingdom UI

### Alpha (Levels 1-500)
- [ ] All 6 puzzle types
- [ ] 500 levels
- [ ] Streak system
- [ ] Coins & shop

### Beta (Levels 1-1000)
- [ ] 1000 levels
- [ ] All 5 realms
- [ ] Daily challenges
- [ ] Save/load

### Release (Levels 1-2000)
- [ ] Full 2000 levels
- [ ] All features
- [ ] Polish & testing
- [ ] Release!

---

*2000 levels of brain power! 🧠⚡*
