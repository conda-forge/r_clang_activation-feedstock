for /f "tokens=*" %%i in ('where clang.exe') do (
  echo %%i | findstr /i /c:"Microsoft Visual Studio\\2022\\Enterprise\\VC\\Tools" >nul
  if errorlevel 1 (
    set "CLANG_PATH=%%i"
    goto :clang_end
  )
)
:clang_end
set "CLANG_PATH_CYG=%CLANG_PATH:\=/%"
set "CLANG_PATH_CYG=/%CLANG_PATH_CYG::=%"

for /f "tokens=*" %%i in ('where r_clang_wrapper.bat') do (
  set "CLANG_WRAPPER_PATH=%%i"
  goto :clang_wrapper_end
)
:clang_wrapper_end
set "CLANG_WRAPPER_PATH_CYG=%CLANG_WRAPPER_PATH:\=/%"
set "CLANG_WRAPPER_PATH_CYG=/%CLANG_WRAPPER_PATH_CYG::=%"

for /f "tokens=*" %%i in ('where clang++.exe') do (
  echo %%i | findstr /i /c:"Microsoft Visual Studio\\2022\\Enterprise\\VC\\Tools" >nul
  if errorlevel 1 (
    set "CLANGXX_PATH=%%i"
    goto :clangxx_end
  )
)
:clangxx_end
set "CLANGXX_PATH_CYG=%CLANGXX_PATH:\=/%"
set "CLANGXX_PATH_CYG=/%CLANGXX_PATH_CYG::=%"

for /f "tokens=*" %%i in ('where r_clangxx_wrapper.bat') do (
  echo %%i | findstr /i /c:"Microsoft Visual Studio\\2022\\Enterprise\\VC\\Tools" >nul
  if errorlevel 1 (
    set "CLANGXX_WRAPPER_PATH=%%i"
    goto :clangxx_wrapper_end
  )
)
:clangxx_wrapper_end
set "CLANGXX_WRAPPER_PATH_CYG=%CLANGXX_WRAPPER_PATH:\=/%"
set "CLANGXX_WRAPPER_PATH_CYG=/%CLANGXX_WRAPPER_PATH_CYG::=%"

for /f "tokens=*" %%i in ('where llvm-ar.exe') do (
  echo %%i | findstr /i /c:"Microsoft Visual Studio\\2022\\Enterprise\\VC\\Tools" >nul
  if errorlevel 1 (
    set "LLVM_AR_PATH=%%i"
    goto :ar_end
  )
)
:ar_end
set "LLVM_AR_PATH_CYG=%LLVM_AR_PATH:\=/%"
set "LLVM_AR_PATH_CYG=/%LLVM_AR_PATH_CYG::=%"

for /f "tokens=*" %%i in ('where llvm-nm.exe') do (
  echo %%i | findstr /i /c:"Microsoft Visual Studio\\2022\\Enterprise\\VC\\Tools" >nul
  if errorlevel 1 (
    set "LLVM_NM_PATH=%%i"
    goto :nm_end
  )
)
:nm_end
set "LLVM_NM_PATH_CYG=%LLVM_NM_PATH:\=/%"
set "LLVM_NM_PATH_CYG=/%LLVM_NM_PATH_CYG::=%"

:uniqLoop
set "CLANG_MAKEVARS=%TEMP%\Makeconf.clang-%RANDOM%"
if exist "%CLANG_MAKEVARS%" goto :uniqLoop

if NOT [%R_MAKEVARS_SITE%] == [] (
  copy "%R_MAKEVARS_SITE%" "%CLANG_MAKEVARS%"
  set "R_MAKEVARS_SITE_1=%R_MAKEVARS_SITE%"
)

set "CXXFLAGS_MOD=%CXXFLAGS:c++14=%

echo. >> "%CLANG_MAKEVARS%"
echo AR = %LLVM_AR_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo CC = %CLANG_WRAPPER_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo CLFAGS = %CFLAGS:\=/% >> "%CLANG_MAKEVARS%"
echo CXX = %CLANGXX_WRAPPER_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo CXXFLAGS = %CXXFLAGS:\=/% >> "%CLANG_MAKEVARS%"
echo CXX98 = %CLANGXX_WRAPPER_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo CXX98FLAGS = %CXXFLAGS:\=/% >> "%CLANG_MAKEVARS%"
echo CXX11 = %CLANGXX_WRAPPER_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo CXX11FLAGS = %CXXFLAGS:\=/% >> "%CLANG_MAKEVARS%"
echo CXX14 = %CLANGXX_WRAPPER_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo CXX14FLAGS = %CXXFLAGS:\=/% >> "%CLANG_MAKEVARS%"
echo CXX17 = %CLANGXX_WRAPPER_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo CXX17FLAGS = %CXXFLAGS_MOD:\=/% -std=c++17 >> "%CLANG_MAKEVARS%"
echo NM = %LLVM_NM_PATH_CYG% >> "%CLANG_MAKEVARS%"
echo LDFLAGS = %LDFLAGS:\=/% >> "%CLANG_MAKEVARS%"
echo DLLFLAGS = %LDFLAGS:\=/% >> "%CLANG_MAKEVARS%"

set "R_MAKEVARS_SITE=%CLANG_MAKEVARS%"
