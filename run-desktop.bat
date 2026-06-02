@echo off
chcp 65001 > nul
title تشغيل نظام إدارة المعتمرين

where node >nul 2>nul
if %errorlevel% neq 0 (
  echo خطأ: Node.js غير مثبت. حمله من https://nodejs.org
  pause
  exit /b 1
)

if not exist node_modules (
  call npm install
  if %errorlevel% neq 0 (
    echo فشل تثبيت الحزم.
    pause
    exit /b 1
  )
)

call npm run build
if %errorlevel% neq 0 (
  echo فشل بناء واجهة البرنامج.
  pause
  exit /b 1
)

call npx electron electron/main.cjs