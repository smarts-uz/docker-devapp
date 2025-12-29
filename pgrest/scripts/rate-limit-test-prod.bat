@echo off
setlocal enabledelayedexpansion

:: Set URL and token
set "URL=https://api.proliga.uz/tour_team?select=*&limit=1"
set "AUTH=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MjUyNSwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJleHAiOjE3NzIwMDIyMzQsImlhdCI6MTc2NjgxODIzNH0.lpnlnmk4kWXGUGmbpFLTQtBFWbMuE4BK4Zn1pPY2J8Q"

:: Loop 100 times
for /l %%i in (1,1,100) do (
    echo Request #%%i
    curl --silent --location "!URL!" --header "Authorization: !AUTH!" --header "Prefer: count=estimated"
    echo.
    echo ---------------------------
)

pause
