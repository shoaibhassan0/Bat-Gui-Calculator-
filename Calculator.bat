@echo off
setlocal enabledelayedexpansion
mode 27,29
cd files
color 0f
Title Calculator
::::::::::::::::::::::::::::::Setting values::::::::::::::::::::::::::
set "Left="
set "Right="
set /a LngE=-1 , LN=0 , _LN=0
set "bx=/c 0xf0"
set "g1=/g 0 0"  
set "g2=/g 0 1"
set "g3=/g 0 2"
set LINE1=20 12 24 14 8 8 12 10 14 8 18 10 20 8 24 10
set LINE2=2 12 6 14 8 12 12 14 14 12 18 14 2 8 6 10
set LINE3=2 16 6 18 8 16 12 18 14 16 18 18 20 16 24 18
set LINE4=2 20 6 22 8 20 12 22 14 20 18 22 20 20 24 22
set LINE5=2 24 6 26 8 24 12 26 14 24 18 26 20 24 24 26
set LINER=%LINE1% %LINE2% %LINE3% %LINE4% %LINE5% 
colorbox /ff 0 0 26 28 /d
colorbox /a 1 1 25 6 /d
call :Main
call :GetInput
:Main
::::::::::::::::::::::::::::::Making Buttons::::::::::::::::::::::::::
batkit /o 2 8 %bx% %g1% /d "     " %g2% /d " <-- " %g3% /d "     "
batkit /o 8 8 %bx% %g1% /d "     " %g2% /d "  C  " %g3% /d "     "
batkit /o 14 8 %bx% %g1% /d "     " %g2% /d "  (  " %g3% /d "     "
batkit /o 20 8 %bx% %g1% /d "     " %g2% /d "  )  " %g3% /d "     "
batkit /o 2 12 %bx% %g1% /d "     " %g2% /d "  7  " %g3% /d "     "
batkit /o 8 12 %bx% %g1% /d "     " %g2% /d "  8  " %g3% /d "     "
batkit /o 14 12 %bx% %g1% /d "     " %g2% /d "  9  " %g3% /d "     "
batkit /o 20 12 %bx% %g1% /d "     " %g2% /d "  " /a 246 /d "  " %g3% /d "     "
batkit /o 2 16 %bx% %g1% /d "     " %g2% /d "  4  " %g3% /d "     "
batkit /o 8 16 %bx% %g1% /d "     " %g2% /d "  5  " %g3% /d "     "
batkit /o 14 16 %bx% %g1% /d "     " %g2% /d "  6  " %g3% /d "     "
batkit /o 20 16 %bx% %g1% /d "     " %g2% /d "  x  " %g3% /d "     "
batkit /o 2 20 %bx% %g1% /d "     " %g2% /d "  1  " %g3% /d "     "
batkit /o 8 20 %bx% %g1% /d "     " %g2% /d "  2  " %g3% /d "     "
batkit /o 14 20 %bx% %g1% /d "     " %g2% /d "  3  " %g3% /d "     "
batkit /o 20 20 %bx% %g1% /d "     " %g2% /d "  -  " %g3% /d "     "
batkit /o 2 24 %bx% %g1% /d "     " %g2% /d "  .  " %g3% /d "     "
batkit /o 8 24 %bx% %g1% /d "     " %g2% /d "  0  " %g3% /d "     "
batkit /o 14 24 %bx% %g1% /d "     " %g2% /d "  =  " %g3% /d "     "
batkit /o 20 24 %bx% %g1% /d "     " %g2% /d "  +  " %g3% /d "     "
batkit /c 0x07
batkit /g 3 3
exit /b
::::::::::::::::::::::::::::::Button Hover::::::::::::::::::::::::::
:GetInput
GetInput /M %LINER% %Left% %Right% /H 90
set keyp=%errorlevel%
call :Main
call :keyp %keyp% Ch
set "Exp=%Exp%%Ch%"
set "Ch="
:: Left button settings
batkit /g 3 3 /d " " /g 21 3 /d " "
if %LngE% geq 21 (
    batkit /c 0x0a /g 2 3 /d "<" /c 0x07
    set "Left=2 3 2 3"
    if not "%k%"=="D" if "%_1%"=="false"  (set /a LN+=1)
)
if %LN%==0 (batkit /g 3 2 /d " " & set "Left=")
:: Right button settings
set /a _LN= LngE - LN
if %_LN% gtr 21 (
    batkit /c 0x0a /g 24 3 /d ">" /c 0x07
    set Right=24 3 24 3
)
if %_LN%==20 (batkit /g 21 3 /d " " & set "Right=")
if %LngE% geq 21 (set Exp1=!Exp:~%LN%,21!) else (set "Exp1=")
if defined Exp1 (set "_Exp=%Exp1%") else (set "_Exp=%Exp%")		
batkit /g 3 3 /d "                     " /g 3 3 /d "%_Exp%"

goto :GetInput

:keyp
set x=0
set _1=false

if %1==21 (
    if %LN% gtr 0 (set /a LN-=1) else (set /a LN+=1)
    set "%2="
    set _1=true
    exit /b
)
if %1==22 (
    set /a LN+=1
    set "%2="
    set _1=true
    exit /b
)
for %%i in (
    "k=/" "k=C" "k=(" "k=)" "k=7" "k=8" "k=9" "k=D" "k=4" "k=5" 
    "k=6" "k=x" "k=1" "k=2" "k=3" "k=-" "k=." "k=0" "k==" "k=+"
) do (set /a x+=1 & if %1==!x! (set %%i))
::Verifiying
if "%1"=="49" (set "k=1")
if "%1"=="50" (set "k=2")
if "%1"=="51" (set "k=3")
if "%1"=="52" (set "k=4")
if "%1"=="53" (set "k=5")
if "%1"=="54" (set "k=6")
if "%1"=="55" (set "k=7")
if "%1"=="56" (set "k=8")
if "%1"=="57" (set "k=9")
if "%1"=="48" (set "k=0")
if "%1"=="46" (set "k=.")
if "%1"=="47" (set "k=/")
if "%1"=="42" (set "k=*")
if "%1"=="43" (set "k=+")
if "%1"=="45" (set "k=-")
if "%1"=="61" (set "k==")
if "%k%"=="x" (set "k=*")
if "%1"=="302" (set "k=C")
if "%k%"=="C" (
	set "_Exp="
    set "Exp="
    set "%2="
    set /a LngE=-1
    set /a LN=0
    
)

if "%k%"=="=" if not "%Exp%"=="" (
	set /a LngE=-1 , LN=0 , _LN=0
    call :Calc_Result "%Exp%"
    set "%2="
    if %LN% gtr 0 (set /a LN-=1)
)
if "%k%"=="D" (if !LngE! geq 0 (
    set /a LngE-=1
    set Exp=!Exp:~0,%LngE%!
    if %LN% gtr 0 (set /a LN-=1)
)) else (if not "%k%"=="="  if not "%k%"=="C" (
    set /a LngE+=1
    set "%2=%k%"
))
exit /b
:Calc_Result
set "Result="
for /f "tokens=*" %%i in ('cscript //nologo Eval.vbs "%Exp%" 2^>nul') do (set "Result=%%i")
if defined Result (batkit /g 3 5 /d "                     " /c 0x0b /g 2 5 /d "= %Result%" /c 0x07&&set "Exp="
) else (
batkit /g 8 5 /c 0x0c /d "Syntax error" /w 100 /g 8 5 /c 0x07 /d "Syntax error" /g 8 5 /c 0x0c /d "Syntax error" /w 100 /g 8 5 /c 0x07 
batkit /d "Syntax error" /g 8 5 /c 0x0c /d "Syntax error" /w 100 /g 8 5 /c 0x07 /d "Syntax error" /w 100 /g 8 5 /c 0x0c /d "Syntax error"&&set "Exp="
)
exit /b