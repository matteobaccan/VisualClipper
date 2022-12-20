/****

          System: WVWClip
                  Copyright (c) 2016-2022, Ashfaq Sial

            Date: December, 16

         Program: WVWMENU.PRG
                  Sample menu program.

*/

#include "inkey.ch"
#include "wvwclip.ch"

FUNCTION MainMenu()

   LOCAL oTopBar
   LOCAL oPopUp

   oTopBar := wvw_CreateMenu()

   // File Menu
   oPopUp := wvw_CreatePopUpMenu()
   wvw_AppendMenu( oPopUp, MF_ENABLED + MF_STRING, 1601, "Employee Details" )
   wvw_AppendMenu( oPopUp, MF_ENABLED + MF_STRING, 1602, "Radio Buttons" )
   wvw_AppendMenu( oPopUp, MF_ENABLED + MF_STRING, 1603, "Editor" )
   wvw_AppendMenu( oPopUp, MF_ENABLED + MF_STRING, 1604, "Browse" )
   wvw_AppendMenu( oPopUp )
   wvw_AppendMenu( oPopUp, MF_ENABLED + MF_STRING, 1605, "Exit" )
   wvw_AppendMenu( oTopBar, MF_ENABLED + MF_POPUP, oPopUp, "&File" )

   // wvw_MenuItem_SetBitmaps( oPopUp, 1605, , 102)

   // Help Menu
   oPopUp := wvw_CreateMenu()
   wvw_AppendMenu( oPopUp, MF_ENABLED + MF_STRING, 1706, "Check for Updates" )
   wvw_AppendMenu( oPopUp, MF_ENABLED + MF_STRING, 1707, "About" )
   wvw_AppendMenu( oTopBar, MF_ENABLED + MF_POPUP, oPopUp, "&Help" )

   wvw_SetMenu( , oTopBar )

   RETURN NIL

// EOF: WVWMENU.PRG
