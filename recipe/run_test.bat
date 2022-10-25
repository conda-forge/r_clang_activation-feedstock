@echo on

@rem Test default compilation
R -e "usethis::create_package('compiletest')"
IF %ERRORLEVEL% NEQ 0 exit 1
md "compiletest\src"
IF %ERRORLEVEL% NEQ 0 exit 1
copy test.cpp "compiletest\src\test.cpp"
IF %ERRORLEVEL% NEQ 0 exit 1
R CMD INSTALL --build compiletest
IF %ERRORLEVEL% NEQ 0 exit 1

@rem Test compilation with C++17-only features
R -e "usethis::create_package('compiletest17')"
IF %ERRORLEVEL% NEQ 0 exit 1
md "compiletest17\src"
IF %ERRORLEVEL% NEQ 0 exit 1
copy test_cxx17.cpp "compiletest17\src\test_cxx17.cpp"
IF %ERRORLEVEL% NEQ 0 exit 1
echo CXX_STD=CXX17 > compiletest17\src\Makevars.win
IF %ERRORLEVEL% NEQ 0 exit 1
R CMD INSTALL --build compiletest17
IF %ERRORLEVEL% NEQ 0 exit 1
