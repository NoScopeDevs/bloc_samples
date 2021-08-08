
@echo off
setLocal EnableDelayedExpansion

set relPath=!cd:%MELOS_ROOT_PATH%\=!

if exist pubspec.yaml (
  if exist coverage\ (
    if not exist %MELOS_ROOT_PATH%\coverage\ (
      mkdir %MELOS_ROOT_PATH%\coverage
    )
    for /f "delims=" %%a in (coverage\lcov.info) do (
        SET s=%%a
        SET s=!s:SF:lib\=SF:%relPath%\lib\!
        echo !s!>>%MELOS_ROOT_PATH%\coverage\lcov.info
    )
  )
)

endLocal