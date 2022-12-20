rem @echo off
rem BUILD WVWClip Library

set PATH=C:\msys64\mingw32\bin;C:\hb\bin;%PATH%
set HB_COMPILER=mingw
set HB_PATH=C:\hb

hbmk2 wvwclip.hbp -rebuild
copy libwvwclip.a C:\hb\lib\win\clang

