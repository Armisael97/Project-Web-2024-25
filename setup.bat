@echo off
echo ====================================
echo Thesis Support System Setup
echo ====================================
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running. Please start Docker Desktop and try again.
    pause
    exit /b 1
)

echo [1/5] Creating .env file from template...
if not exist .env (
    copy .env.example .env
    echo .env file created. Please review and update the configuration if needed.
) else (
    echo .env file already exists.
)

echo.
echo [2/5] Building Docker images...
docker-compose build

echo.
echo [3/5] Starting PostgreSQL database...
docker-compose up -d postgres

echo.
echo [4/5] Waiting for database to be ready...
timeout /t 10 /nobreak >nul

echo.
echo [5/5] Starting all services...
docker-compose up -d

echo.
echo ====================================
echo Setup Complete!
echo ====================================
echo.
echo Services are starting up. Please wait a moment for all services to be ready.
echo.
echo Access the application at:
echo - Frontend: http://localhost:3000
echo - Backend API: http://localhost:5000
echo - Database: localhost:5432
echo.
echo Sample login credentials:
echo - Faculty: prof.smith / password123
echo - Student: student1 / password123  
echo - Secretariat: secretary / password123
echo.
echo To view logs: docker-compose logs -f
echo To stop services: docker-compose down
echo.
pause
