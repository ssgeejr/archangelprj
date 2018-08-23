@echo off
cls

set TIMESTAMP=%DATE:~4,2%%DATE:~7,2%%DATE:~10,4%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
rem echo %TIMESTAMP%


git add .
git commit -m "autopush %TIMESTAMP%"
git push origin develop

