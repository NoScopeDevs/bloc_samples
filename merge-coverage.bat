
@echo off
set escapePath=%pwd:/=\\%

if exist pubspec.yaml (
  if exist coverage\ (
    if not exist %MELOS_ROOT_PATH%\coverage_report\ (
      mkdir %MELOS_ROOT_PATH%\coverage_report
    )
    @REM bulk coverage data
  )
)