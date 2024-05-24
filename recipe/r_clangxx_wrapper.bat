rem remove tmp.def from command
rem This is only needed for m2w64 linking
set "args=%* -v"
%CLANGXX_PATH% %args: tmp.def = %
