@echo off
echo 🎮 Gun Arena - Quick Start
echo ==========================

where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js is not installed. Please install it from https://nodejs.org/
    exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo ✅ Node.js detected: %NODE_VERSION%

echo.
echo 📦 Installing backend dependencies...
cd backend
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Backend installation failed
    exit /b 1
)
echo ✅ Backend ready

echo.
echo 📦 Installing frontend dependencies...
cd ..\frontend
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Frontend installation failed
    exit /b 1
)
echo ✅ Frontend ready

echo.
echo 🚀 Setup complete!
echo.
echo To start the game:
echo 1. Terminal 1: cd backend ^&^& npm start
echo 2. Terminal 2: cd frontend ^&^& npm start
echo.
echo Then open http://localhost:3000 in your browser
echo.
echo ⚔️ Have fun!
pause
