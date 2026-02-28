# 🎮 Gun Arena - 2-Player Online Shooter

A real-time 2D side-scroller multiplayer shooter game built with React, Node.js, and Socket.io.

## 🎯 MVP Features (Phase 1)

- ✅ Create/Join Rooms (Max 2 players)
- ✅ Real-time Movement (WASD)
- ✅ Mouse Aiming & Shooting
- ✅ HP & Ammo System
- ✅ Bullet Physics & Collision Detection
- ✅ Server-side Game Logic (Anti-cheat)
- ✅ Winner Screen
- ✅ Live Game State Sync (60 FPS)

## 🛠️ Tech Stack

**Frontend:**
- React 18
- HTML5 Canvas
- Socket.io Client

**Backend:**
- Node.js
- Express
- Socket.io (Real-time communication)

## 📦 Installation

### Prerequisites
- Node.js v14+ installed
- npm or yarn

### Backend Setup

1. Navigate to backend folder:
```bash
cd backend
npm install
```

2. Start the server:
```bash
npm start
```
Server runs on `http://localhost:3001`

### Frontend Setup

1. Navigate to frontend folder:
```bash
cd frontend
npm install
```

2. Start the React app:
```bash
npm start
```
App runs on `http://localhost:3000`

## 🎮 How to Play

1. **Open the game**: Navigate to `http://localhost:3000` in your browser
2. **Enter your name** in the lobby
3. **Create a room** or join an existing one
4. **Wait for opponent** to join
5. **Battle!**
   - **WASD**: Move around
   - **Mouse**: Aim (crosshair follows cursor)
   - **Right-Click**: Shoot (30 ammo per magazine)
   - **Spacebar**: Reload (instantly refill ammo)
   - **X**: Change gun (future feature)
   - **HP**: Starts at 100, take damage from bullets
   - **First to 0 HP loses**

## 🎨 Visual Style

- **Side-scroller perspective**
- **Neon cyberpunk colors** (cyan, yellow, red)
- **Minimalist geometric design**
- **Pixel-art inspired UI**

## 🔧 Game Constants (Configurable)

In [backend/GameManager.js](backend/GameManager.js):
- PLAYER_HP: 100
- PLAYER_SPEED: 5
- MAX_AMMO: 30
- RELOAD_TIME: 1500ms
- SHOOT_COOLDOWN: 100ms
- BULLET_DAMAGE: 10
- BULLET_SPEED: 8

## 📡 Network Architecture

**Client → Server Events:**
- `playerMove`: WASD input
- `playerAim`: Mouse position (angle)
- `playerShoot`: Click event
- `startGame`: Begin match

**Server → Client Events:**
- `gameState`: Updated positions (60 FPS)
- `gameStarted`: Match begins
- `gameOver`: Winner ID
- `roomListUpdated`: Available rooms

## 🛡️ Anti-Cheat Features

- ✅ **Server-side collision detection** (bullets don't collide on client)
- ✅ **Server validates all damage** (frontend can't modify HP)
- ✅ **Server calculates bullet positions** (prevents speed hacks)
- ✅ **Input validation** (rate limiting on shots)

## 🚀 Phase 2 Features (Future)

- Sound effects
- Different gun types
- Visual reload animation
- Particle effects
- Better hit feedback

## 🚀 Phase 3 Features (Advanced)

- Character abilities (dash, shield)
- Power-ups
- Environmental obstacles
- Ranked leaderboard
- Replay system

## 📝 Project Structure

```
game/
├── backend/
│   ├── package.json
│   ├── server.js           # Express + Socket.io server
│   └── GameManager.js      # Core game logic
└── frontend/
    ├── package.json
    ├── public/
    │   └── index.html
    └── src/
        ├── App.js          # Main component
        ├── Lobby.js        # Room selection
        ├── GameCanvas.js   # Game rendering
        ├── socket.js       # Socket.io wrapper
        └── *.css           # Styling
```

## 🐛 Known Issues

- None currently!

## 📄 License

MIT

## 🎓 Learning Resources

- [Socket.io Docs](https://socket.io/docs/)
- [React Hooks](https://react.dev/reference/react)
- [Canvas API](https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API)

---

**Have fun destroying your opponents!** ⚔️
