@echo off
chcp 65001 > nul
title بناء نظام إدارة المعتمرين

echo.
echo ============================================================
echo        نظام إدارة المعتمرين - بناء ملف Windows EXE
echo ============================================================
echo.

where node >nul 2>nul
if %errorlevel% neq 0 (
  echo خطأ: Node.js غير مثبت على الجهاز.
  echo حمله وثبته من: https://nodejs.org
  echo ثم شغل هذا الملف مرة ثانية.
  pause
  exit /b 1
)

where npm >nul 2>nul
if %errorlevel% neq 0 (
  echo خطأ: npm غير موجود. أعد تثبيت Node.js.
  pause
  exit /b 1
)

echo [1/3] تثبيت الحزم إن لم تكن مثبتة...
if not exist node_modules (
  call npm install
  if %errorlevel% neq 0 (
    echo فشل تثبيت الحزم.
    pause
    exit /b 1
  )
) else (
  echo الحزم مثبتة مسبقا.
)

echo.
echo [2/3] بناء واجهة البرنامج...
call npm run build
if %errorlevel% neq 0 (
  echo فشل بناء واجهة البرنامج.
  pause
  exit /b 1
)

echo.
echo [3/3] إنشاء ملف EXE المحمول...
call npx electron-builder --config electron-builder.yml --win portable
if %errorlevel% neq 0 (
  echo فشل إنشاء ملف EXE.
  pause
  exit /b 1
)

echo.
echo ============================================================
echo تم إنشاء البرنامج بنجاح.
echo الملف الناتج موجود هنا:
echo desktop-release\نظام إدارة المعتمرين.exe
echo ============================================================
echo.

if exist desktop-release explorer desktop-release
pause