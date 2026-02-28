# 🔧 Troubleshooting Guide

## Setup Issues

### ❌ "Node.js is not installed"

**Solution:** Download and install Node.js from https://nodejs.org/
- Recommended: LTS version
- After installation, restart your terminal
- Verify: Run `node --version`

---

### ❌ "npm command not found"

**Solution:** Node.js installation failed or Path not updated
1. Reinstall Node.js
2. Restart computer
3. Open **new** terminal/PowerShell
4. Try again: `node --version` and `npm --version`

---

### ❌ "Dependencies failed to install"

**Solution:**
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and package-lock.json
rm -rf node_modules package-lock.json

# Reinstall
npm install
```

**For Windows:**
```powershell
# Delete folders manually
rmdir /s /q node_modules
del package-lock.json

# Reinstall
npm install
```

---

### ❌ "Port 3000 or 3001 already in use"

**Solution:** Find and kill the process using the port

**Windows:**
```powershell
# Find process using port 3000
netstat -ano | findstr :3000

# Kill process (replace PID with actual number)
taskkill /PID <PID> /F

# For port 3001:
netstat -ano | findstr :3001
taskkill /PID <PID> /F
```

**Mac/Linux:**
```bash
# Find process
lsof -i :3000

# Kill process (replace PID)
kill -9 <PID>

# For port 3001:
lsof -i :3001
kill -9 <PID>
```

---

## Startup Issues

### ❌ "Cannot GET /" (Frontend blank)

**Possible causes:**
1. React dev server not started
2. Build failed silently
3. Different port

**Solution:**
1. Check Terminal 2 (frontend) for errors
2. Look for red text or "ERROR" in output
3. Verify port is 3000: `http://localhost:3000`
4. Try Ctrl+C and `npm start` again

---

### ❌ "Cannot find module 'express'"

**Solution:**
```bash
# Make sure you're in backend folder
cd backend
npm install

# Then start:
npm start
```

---

### ❌ Backend starts but frontend won't connect

**Solution:** Check browser console (F12)

**Common error:** `net::ERR_CONNECTION_REFUSED`
- Backend is not running (need to start in Terminal 1)
- Backend is on different port
- CORS issue (should be auto-fixed)

**Fix:**
1. Verify backend is running (should see "Game server running on port 3001")
2. Check [frontend/src/socket.js](../frontend/src/socket.js) for correct URL
3. Try hard refresh: `Ctrl+Shift+R` or `Cmd+Shift+R`

---

## Gameplay Issues

### ❌ "Waiting for opponent..." screen hangs

**Causes:**
1. Second player didn't join
2. Game didn't auto-start
3. Network issue

**Solution:**
1. Wait 10 seconds for automatic start
2. If still waiting, manually click "Start Game" button
3. If no button, reload and try another room
4. Check browser console for errors

---

### ❌ "Can't see opponent/bullets not working"

**Possible causes:**
1. Game state not syncing
2. Canvas not rendering
3. Graphics issue

**Solution:**
1. Check browser console (F12) for JavaScript errors
2. Disable browser extensions (especially ad blockers)
3. Try different browser (Chrome recommended)
4. Hard refresh with Ctrl+Shift+R

---

### ❌ "Bullet doesn't hit but looks like it did"

**Why:** This is likely latency (network delay)

**Normal behavior:**
- Server has ground truth
- You see slightly delayed positions
- Bullets register on server's timeline (not yours)
- 100-200ms latency is typical

**Not a bug!** This is why the server validates all hits.

---

### ❌ "Game freezes or lags"

**Possible causes:**
1. Too many bullets (rare on modern computer)
2. Browser is running other heavy tasks
3. Network latency spike

**Solution:**
1. Close other browser tabs
2. Close other applications
3. Check internet connection
4. Restart game

---

### ❌ "Sound effects don't work"

**Current status:** Phase 1 has no sounds yet

**Coming in Phase 2!**

---

## Network Issues

### ❌ "Opponent disconnected" message appears

**Why:** Their connection dropped or they closed the browser

**Solution:**
- Reload page
- Try another room
- Game state was reset

---

### ❌ "Connection lost" or frequent disconnects

**Causes:**
1. Unstable internet
2. Firewall blocking connection
3. VPN issues
4. Browser extension interference

**Solution:**
1. Check internet speed: https://fast.com
2. Disable VPN/Proxy
3. Disable browser extensions
4. Update your browser
5. Try different browser

---

## Server Output Issues

### ❌ "Cannot find module './GameManager'"

**Solution:**
```bash
# Make sure you're in the backend directory
pwd  # or 'cd' in Windows
# Should show: .../game/backend

# Check GameManager.js exists
ls  # or 'dir' in Windows

# If file exists, try:
npm start
```

---

### ❌ "Syntax error" in server logs

**Solution:**
1. Close server: Ctrl+C
2. Check for missing commas/braces in [backend/server.js](../backend/server.js)
3. Restart: `npm start`

---

## Browser Console Errors

### Error: "Cannot read property 'players' of undefined"

**Cause:** gameState not loaded yet

**Status:** Normal on startup, should resolve quickly

---

### Error: "Uncaught TypeError: emit is not a function"

**Cause:** Socket not initialized

**Solution:**
1. Hard refresh: Ctrl+Shift+R
2. Check backend is running
3. Check browser console for other errors

---

### Error: "WebSocket connection to 'ws://...' failed"

**Cause:** Backend not accessible

**Solution:**
1. Verify backend runs on 3001: `npm start` in backend folder
2. Check Windows Firewall isn't blocking port 3001
3. Try localhost instead of IP address

---

## Performance Optimization

If your game feels laggy:

1. **Close background apps** - Free up CPU/RAM
2. **Reduce browser tabs** - Only Gun Arena open
3. **Update graphics drivers** - Especially for Canvas performance
4. **Chrome DevTools Profiling:**
   - Press F12 → Performance tab
   - Click record → Play 5 seconds → Stop
   - Look for bottlenecks (long yellow/red bars)

---

## Getting Help

### Check These First:
1. ✅ Both terminals running (backend + frontend)
2. ✅ http://localhost:3000 is the correct URL
3. ✅ Browser console (F12) for errors
4. ✅ No port conflicts (3000 and 3001)

### Debug Mode:
```javascript
// In browser console:
localStorage.setItem('debug', '*')
location.reload()

// Now you'll see detailed Socket.io logs
```

### Reset Everything:
```bash
# Kill both servers (Ctrl+C in each terminal)

# In backend:
rm -rf node_modules package-lock.json
npm install

# In frontend:
rm -rf node_modules package-lock.json  
npm install

# Start again:
# Terminal 1: cd backend && npm start
# Terminal 2: cd frontend && npm start
```

---

## Still Having Issues?

1. **Check error message exactly** - Search this guide
2. **Look at browser console (F12)** - Red text has clues
3. **Check server terminal** - Red text has clues
4. **Try hard refresh** - Ctrl+Shift+R
5. **Restart both servers** - Ctrl+C then start again
6. **Restart computer** - Nuclear option!

---

**Last Updated:** February 28, 2026
