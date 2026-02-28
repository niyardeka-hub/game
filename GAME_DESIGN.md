# 🎮 Gun Arena - Game Design Document

## 📋 Table of Contents
1. [Game Overview](#game-overview)
2. [Architecture](#architecture)
3. [Game Mechanics](#game-mechanics)
4. [Network Protocol](#network-protocol)
5. [Game State Management](#game-state-management)
6. [Collision & Hit Detection](#collision--hit-detection)
7. [Future Improvements](#future-improvements)

---

## Game Overview

**Gun Arena** is a real-time 2D side-scroller multiplayer shooter where 2 players compete in a confined arena.

### Core Features
- Real-time movement & shooting
- Server-authoritative game logic
- 60 FPS game loop
- Mouse aiming with automatic reload
- HP & ammo management

### Visual Style
- Side-scroller perspective
- Neon cyberpunk aesthetic
- Minimalist geometric shapes
- Dark background with bright accents

---

## Architecture

### Backend Server

```
┌─────────────────────────────────────────┐
│       Node.js + Express + Socket.io     │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   GameManager                   │   │
│  │  - Manages all game rooms       │   │
│  │  - Handles room creation/join   │   │
│  └─────────────────────────────────┘   │
│           │                             │
│           ├─→ GameRoom 1                │
│           ├─→ GameRoom 2                │
│           └─→ GameRoom N                │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   Game Loop (60 FPS)            │   │
│  │  - Update player positions       │   │
│  │  - Update bullet positions       │   │
│  │  - Check collisions              │   │
│  │  - Broadcast game state          │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

### Frontend Client

```
┌─────────────────────────────────────────┐
│           React App                     │
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────┐  ┌────────────┐       │
│  │   Lobby    │  │  GameCanvas│       │
│  │  - Create  │  │  - Render  │       │
│  │  - Join    │  │  - Input   │       │
│  └────────────┘  └────────────┘       │
│                    │                   │
│                    ├─→ Players         │
│                    ├─→ Bullets         │
│                    ├─→ UI Elements     │
│                    └─→ Crosshair       │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   Socket.io Connection          │   │
│  │  - Event listeners              │   │
│  │  - State synchronization        │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

---

## Game Mechanics

### Player

```
Player Object:
{
  id: string,
  name: string,
  x: number,           // Position X
  y: number,           // Position Y
  velocityX: number,   // Current velocity X
  velocityY: number,   // Current velocity Y
  hp: number,          // Health (0-100)
  ammo: number,        // Ammo (0-30)
  angle: number,       // Gun angle (radians)
  isReloading: boolean,
  lastShotTime: number // Timestamp
}
```

### Bullet

```
Bullet Object:
{
  x: number,
  y: number,
  velocityX: number,   // Direction * speed
  velocityY: number,
  ownerId: string,     // Player who shot
  damage: number       // Always 10 (no client control)
}
```

### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| PLAYER_HP | 100 | Initial health |
| PLAYER_SPEED | 5 | Movement speed factor |
| MAX_AMMO | 30 | Ammo per magazine |
| RELOAD_TIME | 1500ms | Time to reload |
| SHOOT_COOLDOWN | 100ms | Minimum time between shots |
| BULLET_DAMAGE | 10 | Damage per bullet |
| BULLET_SPEED | 8 | Pixels per frame |
| ARENA_WIDTH | 1200px | Play area width |
| ARENA_HEIGHT | 600px | Play area height |

---

## Network Protocol

### Socket.io Events

#### Client → Server

**playerMove**
```javascript
// WASD input - 60 FPS (best effort)
emit('playerMove', { 
  keys: { w: bool, a: bool, s: bool, d: bool }
})
```

**playerAim**
```javascript
// Mouse position - continuous updates
emit('playerAim', { 
  angle: number  // Radians from player center
})
```

**playerShoot**
```javascript
// Right-click event - triggered by player
emit('playerShoot', { 
  angle: number  // Gun angle at time of click
})
```

**playerReload**
```javascript
// Spacebar - manual reload
emit('playerReload', {})
```

**playerChangeGun**
```javascript
// X key - change gun (placeholder for future phases)
emit('playerChangeGun', {})
```

#### Server → Client

**gameState**
```javascript
// 60 FPS broadcast to all players in room
on('gameState', {
  players: [
    { id, name, x, y, hp, ammo, angle, isReloading },
    ...
  ],
  bullets: [
    { x, y, velocityX, velocityY },
    ...
  ],
  gameStarted: boolean
})
```

**gameStarted**
```javascript
// Sent when room is full and game begins
on('gameStarted', { gameState: {...} })
```

**gameOver**
```javascript
// Sent when a player's HP reaches 0
on('gameOver', { winnerId: string })
```

---

## Game State Management

### Room Lifecycle

```
1. LOBBY
   └─→ Player Creates Room
       └─→ WAITING (Player 1 waiting for Player 2)
           └─→ Player Joins Room
               └─→ FULL (Both players ready)
                   └─→ PLAYING (Game starts automatically)
                       └─→ GAME_OVER (Someone reaches 0 HP)
                           └─→ LOBBY (Can join new room)
```

### Server Game Loop (16.67ms tick)

```javascript
for each room:
  1. Update all player positions (based on velocity)
  2. Handle boundary collisions (arena walls)
  3. Update bullet positions
  4. Check bullet-to-player collisions
  5. Remove out-of-bounds bullets
  6. Update reload state
  7. Check win condition (HP ≤ 0)
  8. Broadcast gameState to all players
```

---

## Collision & Hit Detection

### Boundary Collision (Player)
```
if (player.x < 0) player.x = 0
if (player.x + PLAYER_WIDTH > ARENA_WIDTH) player.x = ARENA_WIDTH - PLAYER_WIDTH
// Similar for Y axis
```

### AABB Collision (Bullet ↔ Player)
```javascript
function isColliding(bullet, player) {
  return (
    bullet.x < player.x + PLAYER_WIDTH &&
    bullet.x + BULLET_SIZE > player.x &&
    bullet.y < player.y + PLAYER_HEIGHT &&
    bullet.y + BULLET_SIZE > player.y
  );
}
```

### Important: Server-Side Only
- ✅ All collision detection happens on server
- ✅ Damage is applied server-side
- ✅ HP is authoritative on server
- ❌ Client cannot modify game state
- ❌ Client cannot predict damage

---

## Future Improvements

### Phase 2: Polish
- [ ] Sound effects (shoot, reload, hit, win)
- [ ] Particle effects (bullet impact, reload flash)
- [ ] Animated reload bar
- [ ] Better bullet trails
- [ ] Different gun types (shotgun, sniper)
- [ ] Smooth camera shake on hit

### Phase 3: Features
- [ ] Dash ability (consume stamina)
- [ ] Shield power-up (temporary invulnerability)
- [ ] Health potion power-up
- [ ] Environmental obstacles (walls, boxes)
- [ ] Ranked matchmaking
- [ ] Player stats tracking
- [ ] Replay system
- [ ] Map rotation
- [ ] Custom room options (no abilities, specific guns)

### Phase 4: Optimization
- [ ] Delta compression for gameState
- [ ] Spatial partitioning for collision checks
- [ ] Client-side prediction (reduce perceived latency)
- [ ] Server-side replay for death cam
- [ ] WebGL rendering for better performance
- [ ] Connection quality indicators

### Phase 5: Monetization/Social
- [ ] Cosmetics (skins, trails, effects)
- [ ] Leaderboards
- [ ] Friend system
- [ ] Spectator mode
- [ ] Chat system
- [ ] Replays shared to community

---

## Performance Considerations

### Current Bottlenecks
- Broadcast to all sockets every 16.67ms
- AABB collision checks (O(n·m) for n bullets, m players)
- Canvas rendering at full arena size

### Optimization Strategies
1. **Spatial Hashing** - Only check nearby bullets
2. **Interest Management** - Only send visible state
3. **Interpolation** - Smooth movement on client
4. **Prediction** - Client-side speculation (careful!)
5. **Networking** - Delta compression instead of full state

---

## Debugging Tips

### Check Server Logs
```bash
# Terminal 1:
cd backend && npm start
```
You'll see connection logs and any errors.

### Check Browser Console
```javascript
// In DevTools Console:
// Enable detailed logging
localStorage.setItem('debug', '*')
// Or filter socket.io:
localStorage.setItem('debug', 'socket.io-client')
```

### Inspect Game State
```javascript
// In React DevTools:
// Look at GameCanvas component props
// gameState shows players and bullets in real-time
```

---

## Testing Checklist

- [ ] Can create a room
- [ ] Can join a full room
- [ ] Can't join a locked room (game in progress)
- [ ] WASD movement works both ways
- [ ] Mouse aiming updates correctly
- [ ] Click fires bullets
- [ ] Bullets detect collision
- [ ] HP decreases on hit
- [ ] Ammo counter updates
- [ ] Reload works (auto after emptying)
- [ ] Winner screen shows
- [ ] Disconnect handling works
- [ ] Multiple rooms simultaneously
- [ ] No client-side damage cheating possible

---

**Last Updated:** February 28, 2026
**Version:** 1.0.0 (Phase 1 - MVP)
