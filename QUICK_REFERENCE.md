# ⚔️ Gun Arena - Quick Reference

## 🚀 Quick Start (First Time)

### Step 1: Install Dependencies
```bash
# Windows
setup.bat

# Mac/Linux
bash setup.sh

# Manual
cd backend && npm install && cd ../frontend && npm install
```

### Step 2: Start Servers
```bash
# Terminal 1 (Backend)
cd backend
npm start

# Terminal 2 (Frontend)
cd frontend
npm start
```

### Step 3: Play
Open http://localhost:3000 in your browser

---

## 🎮 Controls

| Action | Key |
|--------|-----|
| Move Left | A |
| Move Right | D |
| Move Up | W |
| Move Down | S |
| Aim | Move Mouse |
| Shoot | Right-Click |
| Reload | Spacebar |
| Change Gun | X |
| View Game Design | Open [GAME_DESIGN.md](./GAME_DESIGN.md) |

---

## 📊 Game Stats

| Stat | Value |
|------|-------|
| Health | 100 HP |
| Ammo Per Magazine | 30 rounds |
| Damage Per Shot | 10 HP |
| Reload Time | 1.5 seconds |
| Shot Cooldown | 0.1 seconds |
| Bullet Speed | 8 px/frame |
| Player Speed | 5 px/frame |
| Arena Size | 1200 × 600 px |
| Update Rate | 60 FPS |

---

## 🏆 Winning

- Reduce opponent's HP to 0
- Last player standing wins
- Winner screen shows immediately
- Reload page to play again

---

## 📁 Project Structure

```
game/
├── README.md              # Main documentation
├── GAME_DESIGN.md        # Technical design doc
├── TROUBLESHOOTING.md    # Fix issues here
├── QUICK_REFERENCE.md    # This file
├── setup.sh              # Auto-setup for Mac/Linux
├── setup.bat             # Auto-setup for Windows
│
├── backend/
│   ├── package.json
│   ├── server.js         # Express + Socket.io server
│   └── GameManager.js    # Game logic (players, bullets, collisions)
│
└── frontend/
    ├── package.json
    ├── public/
    │   └── index.html
    ├── .env.example
    └── src/
        ├── App.js        # Main React component
        ├── Lobby.js      # Room selection
        ├── GameCanvas.js # Game rendering (Canvas)
        ├── socket.js     # Socket.io wrapper
        └── *.css         # Styling
```

---

## 🛠️ Common Commands

### Start Development
```bash
# Backend
cd backend && npm start

# Frontend (separate terminal)
cd frontend && npm start
```

### Install Dependencies
```bash
# Backend
cd backend && npm install

# Frontend
cd frontend && npm install
```

### Clean Install (if broken)
```bash
# Backend
cd backend
rm -rf node_modules package-lock.json
npm install

# Frontend
cd frontend
rm -rf node_modules package-lock.json
npm install
```

### View Server Logs
- Check Terminal 1 output
- Look for "Game server running on port 3001"
- Red text = errors

### View Client Logs
- Press F12 in browser
- Click "Console" tab
- Red text = errors

---

## 💡 Tips & Tricks

### For Gameplay
- ✅ Pre-aim where they're going, not where they are
- ✅ Strafe (move side-to-side) to dodge bullets
- ✅ Use the arena edges for cover
- ✅ Reload strategically with Spacebar (takes 1.5 seconds)
- ✅ Right-click rapidly to maximize damage output
- ✅ Remember: manual reload with Spacebar (no auto-reload)

### For Development
- ✅ Edit game constants in `backend/GameManager.js` to adjust difficulty
- ✅ Change colors in `frontend/src/GameCanvas.js` for new theme
- ✅ Modify UI in `frontend/src/Lobby.js` and `frontend/src/GameCanvas.js`
- ✅ Add new game events in `backend/server.js`

---

## 🔑 Key Files to Understand

### Backend
- **server.js** - Socket.io events and room management
- **GameManager.js** - All game logic (positions, collisions, HP)

### Frontend
- **App.js** - Main state management and routing
- **GameCanvas.js** - Canvas rendering and input handling
- **Lobby.js** - Room creation and joining UI
- **socket.js** - Socket.io connection wrapper

---

## 🚨 Quick Fixes

### Game won't start?
```bash
# Kill existing processes
netstat -ano | findstr :3000  # Find PID
taskkill /PID <PID> /F

# Restart
npm start
```

### Can't connect to server?
1. ✅ Verify backend is running (should see message in terminal)
2. ✅ Check you're using http://localhost:3000 (not localhost:3001)
3. ✅ Hard refresh: Ctrl+Shift+R

### Stuck on "Waiting for opponent"?
1. Wait 10 seconds (auto-start)
2. Check server logs for errors
3. Reload page and try new room

---

## 📈 What's Next?

### Phase 2 (Coming Soon)
- 🔊 Sound effects
- ✨ Particle effects
- 🎨 Gun variants
- 📊 Kill counter

### Phase 3 (Future)
- 🏃 Dash ability
- 🛡️ Shield power-up
- 🏆 Ranked leaderboard
- 🎬 Replay system

---

## 📞 Need Help?

1. Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
2. Check [GAME_DESIGN.md](./GAME_DESIGN.md) for technical details
3. Look for error messages in browser console (F12)
4. Check server terminal output

---

**Enjoy the game! ⚔️**
