@echo off
setlocal

:: Configuración
SET DEFAULT_COMMIT_MESSAGE="Actualizacion de Mobiliio"
SET PAUSE_DURATION=5
SET DELAY_MESSAGE_ADD="Iniciando 'git add .' en %PAUSE_DURATION% segundos. Presiona cualquier tecla para cancelar."
SET DELAY_MESSAGE_COMMIT="Iniciando 'git commit' en %PAUSE_DURATION% segundos. Presiona cualquier tecla para cancelar."
SET DELAY_MESSAGE_PUSH="Iniciando 'git push' en %PAUSE_DURATION% segundos. Presiona cualquier tecla para cancelar."

echo.
echo ========================================
echo  Script de Actualizacion de Mobiliio en GitHub
echo ========================================
echo.

:: === PASO 1: Confirmacion inicial ===
set /p confirmation="¿Deseas iniciar el proceso de actualizacion (git add, commit, push)? (s/n): "
if /i "%confirmation%" neq "s" (
    echo Proceso cancelado por el usuario.
    goto :eof
)

echo.
echo ========================================
echo  PASO: git add .
echo ========================================
echo.

:: === Pausa y cancelacion para ADD ===
echo %DELAY_MESSAGE_ADD%
choice /c xy /n /t %PAUSE_DURATION% /d x >nul
if %errorlevel% neq 1 (
    echo Proceso 'git add' cancelado.
    goto :eof
)

:: === Ejecutar ADD ===
echo.
echo Ejecutando: git add .
git add .
if %errorlevel% neq 0 (
    echo ERROR: Fallo al ejecutar 'git add .'.
    goto :eof
)
echo 'git add .' completado.
echo.

:: === PASO: git commit ===
echo.
echo ========================================
echo  PASO: git commit
echo ========================================
echo.

:: Pedir mensaje de commit al usuario
set /p commit_message="Introduce el mensaje del commit (Enter para usar '%DEFAULT_COMMIT_MESSAGE%'): "
if "%commit_message%"=="" set commit_message=%DEFAULT_COMMIT_MESSAGE%

:: === Pausa y cancelacion para COMMIT ===
echo %DELAY_MESSAGE_COMMIT%
choice /c xy /n /t %PAUSE_DURATION% /d x >nul
if %errorlevel% neq 1 (
    echo Proceso 'git commit' cancelado.
    goto :eof
)

:: === Ejecutar COMMIT ===
echo.
echo Ejecutando: git commit -m "%commit_message%"
git commit -m "%commit_message%"
if %errorlevel% neq 0 (
    echo ERROR: Fallo al ejecutar 'git commit'.
    goto :eof
)
echo 'git commit' completado.
echo.

:: === PASO: git push ===
echo.
echo ========================================
echo  PASO: git push
echo ========================================
echo.

:: === Pausa y cancelacion para PUSH ===
echo %DELAY_MESSAGE_PUSH%
choice /c xy /n /t %PAUSE_DURATION% /d x >nul
if %errorlevel% neq 1 (
    echo Proceso 'git push' cancelado.
    goto :eof
)

:: === Ejecutar PUSH ===
echo.
echo Ejecutando: git push origin main
:: Puedes cambiar 'main' a 'master' si esa es tu rama principal
git push origin main
if %errorlevel% neq 0 (
    echo ERROR: Fallo al ejecutar 'git push'.
    goto :eof
)
echo 'git push' completado.
echo.

echo ========================================
echo  PROCESO DE ACTUALIZACION FINALIZADO.
echo ========================================
echo.

endlocal
pause