/****

          System: WVWClip
                  Copyright (c) 2016-2022, Ashfaq Sial

            Date: December, 16

         Program: WVWCLIP.PRG
                  Visual Clipper via GTWVW.

*/                  

#include "inkey.ch"
#include "common.ch"
#include "getexit.ch"
#include "wvwclip.ch"

#define LABELFONTNAME    "Arial"
#define LABELFONTSIZE    15
#define DATAFONTNAME     "Consolas"
#define DATAFONTSIZE     20
#define LINESPACING      6

// Array of codeblocks, for each window, used for repainting GUI
// objects via wvw_Paint().
STATIC aGuiObjs := {}

// Array of codeblocks, for each window, used for destroying
// native GUI objects.
STATIC aGUICtls := {}

// Window type array
STATIC aWinType := {}

STATIC cAppIcon := ''
STATIC lGUIApp  := .T.

FUNCTION WSetup( lIsGUI, cIcon )

   LOCAL nLineSpacing, LSColor, aPalette

   DEFAULT lIsGUI TO .F.
   DEFAULT cIcon TO ''
   
   SET EVENTMASK TO INKEY_ALL 

   cAppIcon := cIcon
   lGUIApp := lIsGUI

   GetList := {}

   // Setup colours to match Windows controls.
   aPalette := wvw_GetPalette()
   aPalette[ 01 ] := GetSysColor( COLOR_WINDOWTEXT )  // Text in windows     N  Black
   aPalette[ 08 ] := GetSysColor( COLOR_MENU )        // Menu                W  White
   aPalette[ 09 ] := GetSysColor( COLOR_GRAYTEXT )    // Greyed Text         N+ Grey
   aPalette[ 10 ] := GetSysColor( COLOR_HIGHLIGHT )   // Selected Item       B+ Blue
   aPalette[ 16 ] := GetSysColor( COLOR_WINDOW )      // Window Background   W+ Bright White
   wvw_SetPalette( aPalette )

   // Setup GTWVW - Global
   wvw_SetAltF4Close( .F. )
   wvw_SetMainCoord( .F. )          // Standard mode (Default)
   wvw_SetPaintRefresh( 50 )        // 0-Immediate, Minimum 50, Default 100
   wvw_NoStartupSubWindow( .T. )    // New window will remain hidden (Default .T.)
   wvw_SetVertCaret( .F. )

   // Settings for main window.
   IF lGUIApp

      // Settings for GUI application.
      nLineSpacing := LINESPACING

      // Default font and colour settings.
      wvw_SetFont( , DATAFONTNAME, DATAFONTSIZE, 0 )
      SetColor( "N/W, W+/B*, , , N/W*" )
      LSColor := ColorToN( "W" )
      
   ELSE
   
      // Settings for console application.
      // Set screen font - Must keep the width at 11 otherwise windows controls don't lineup
      // DOC wvw_SetFont( WinNum, cFontFace, nFontHeight, nFontWidth, nFontWeight, nFontQuality )
      nLineSpacing := 0
      
      // Default font and colour settings.
      wvw_SetFont( , DATAFONTNAME, DATAFONTSIZE + 2 , ( DATAFONTSIZE + 2 ) / 2 )
      SetColor( "W/N, N/W, , , W/N" )
      LSColor := ColorToN( "N" )

   ENDIF
   
   // Remeber window type
   AAdd( aWinType, { lGUIApp, nLineSpacing } )
   
   // Application screen width is now set. Srollbars depend on it.
   // All windows, GUI or Console, will be created using main window's data font size.
   // However, sub-windows can have different properties.

   // First call creates the default fonts.
   wvw_ebSetFont( , LABELFONTNAME, Std_FontSize() + 2, 0 )
   wvw_pbSetFont( , LABELFONTNAME, Std_FontSize(), 0 )
   wvw_cbSetFont( , LABELFONTNAME, Std_FontSize(), 0 )
   wvw_cxSetFont( , LABELFONTNAME, Std_FontSize(), 0 )
   wvw_sbSetFont( , LABELFONTNAME, Std_FontSize(), 0 )

   // Set linepacing colour
   wvw_SetDefLSpaceColor( LSColor )
   wvw_SetLSpaceColor( , LSColor )
   wvw_SetPen( PS_SOLID, , LSColor )

   // Line spacing - Line space colour affects the get field height.
   // MUST BE AFTER FONTS ARE SET
   wvw_SetDefLineSpacing( aWinType[ Len( aWinType ), 2 ] )
   wvw_SetLineSpacing( , aWinType[ Len( aWinType ), 2 ] )

   // This must be here. See notes below
   wvw_Size_Ready( .F. )
   
   RETURN NIL


// Open a new window.
FUNCTION W_Open( nTop, nLeft, nBottom, nRight, cTitle, lGUIWin, lCentre, nLineSpacing )

   PRIVATE nWinNum

   // Default to main window's values.
   DEFAULT lGUIWin TO lGUIApp
   DEFAULT nLineSpacing TO iif( lGUIWin, LINESPACING, 0 )

   // DOC wvw_nOpenWindow( cWinName, row1, col1, row2, col2, nStyle, nParentWin, nExStyle )
   nWinNum := wvw_nOpenWindow( cTitle, nTop, nLeft, nBottom, nRight )

   IF lGUIWin
      wvw_SetLSpaceColor( , ColorToN( "W" ) )
      wvw_SetFont( nWinNum, DATAFONTNAME, DATAFONTSIZE, 0 )
   ENDIF

   // Line spacing.
   wvw_SetLineSpacing( nWinNum, nLineSpacing )
   
   AAdd( aWinType, { lGUIWin, nLineSpacing } )

   // Centre and paint.
   wvw_SetWindowCentre( nWinNum, lCentre, .T. )

   // Initialise window's GUI objects.
   // Subwindows are GUI by default.
   WInit( cTitle )

   RETURN nWinNum


// Initialise window related GUI objects.
FUNCTION WInit( cTitle )

   wvw_SetIcon( , cAppIcon )
   wvw_EnableShortcuts( , .T. )

   IF cTitle <> NIL
      wvw_SetTitle( , cTitle )
   ENDIF

   // Clear window and it's GUI objects.
   WClear()

   // Display window
   wvw_ShowWindow( , SW_SHOWNORMAL )
   
   // GET boxes for GetList belonging to this window except
   // for GETs which have visual controls attached to them.
   IF aWinType[ Len( aWinType ), 1 ]
      AddGuiObj( , ;
         { || AEval( GetList, { | oGet | iif( Empty( oGet:control ), ;
            wvw_DrawBoxGet( , oGet:Row, oGet:Col, Len( Transform( oGet:VarGet(), oGet:PICTURE ) ) ), ;
                .T. ) } ) } ;
               )
   ENDIF

   RETURN NIL


// Clear topmost window and it's GUI objects.
FUNCTION WClear()

   ClrGuiObjs( TOPWINDOW )
   ClrGuiCtls( TOPWINDOW )

   GetList := {}

   Scroll()
   
   RETURN NIL


// Close top most window.
FUNCTION W_Close()

   // Clear window and it's GUI objects.
   WClear()

   wvw_tbDestroy()
   wvw_lCloseWindow()

   IF Len( aWinType ) > 1
      ASize( aWinType, Len( aWinType ) - 1 )
   ENDIF

   RETURN NIL

   
// *** custom get reader for GUI controls ***
//
// Custom reader for oGet, a GET object hidden beneath a Control.
// oGet:control contains control object:
//

FUNCTION GenReader( oGet, bAction )

   LOCAL nKey, nKeyStd, bKeyBlock
   LOCAL oGetList := __GetListActive()

   oGet:control:SetFocus()
   oGet:setfocus()

   nKeyStd := Inkey( 0 )

   DO CASE
   CASE nKeyStd == K_ENTER

      // NOTE that in WVW_CB_KBD_CLIPPER mode for COMBOBOX we will never get here
      
      IF HB_ISBLOCK( bAction )
         Eval( bAction )
         oGet:exitState := GE_NOEXIT
      ELSE
         oGet:exitState := GE_DOWN
      ENDIF

   CASE nKeyStd == K_UP .OR. nKeyStd == K_LEFT
      IF oGet:control:cClassName == 'RADIOGROUP'
         // Selection within a radio group.
         oGet:control:PrevItem()
         oGet:VarPut( oGet:control:nButton )
         oGet:exitState := GE_NOEXIT
      ELSE
         oGet:exitState := GE_UP
      ENDIF

   CASE nKeyStd == K_SH_TAB
      oGet:exitState := GE_UP

   CASE nKeyStd == K_DOWN .OR. nKeyStd == K_RIGHT

      // NOTE that in WVW_CB_KBD_STANDARD mode for COMBOBOX we will never get here

      IF oGet:control:cClassName == 'RADIOGROUP'
         // Selection within a radio group.
         oGet:control:NextItem()
         oGet:VarPut( oGet:control:nButton )
         oGet:exitState := GE_NOEXIT
      ELSE
         oGet:exitState := GE_DOWN
      ENDIF

   CASE nKeyStd == K_TAB
      oGet:exitState := GE_DOWN

   CASE nKeyStd == K_ESC
      IF Set( _SET_ESCAPE )
         oGet:exitState := GE_ESCAPE
      ENDIF

   CASE nKeyStd == K_PGUP
      oGet:exitState := GE_WRITE

   CASE nKeyStd == K_PGDN
      oGet:exitState := GE_WRITE

   CASE nKeyStd == K_CTRL_W
      oGet:exitState := GE_WRITE

   CASE nKeyStd == K_CTRL_HOME
      oGet:exitState := GE_TOP

   CASE nKeyStd == K_CTRL_END
      oGet:exitState := GE_BOTTOM

   CASE nKeyStd == K_LBUTTONDOWN
      IF Empty( oGetList:HitTest( MRow(), MCol() ) )
         // No GET object hit.
         oGet:exitState := GE_NOEXIT
      ELSE
         oGet:exitState := GE_MOUSEHIT
      ENDIF

   CASE HB_ISBLOCK( bKeyBlock := SetKey( nKeyStd ) )
      // Evaluate key codeblock.
      // Example: SetKey( K_F7,  { || EBPrint( cText ) } )
      Eval( bKeyBlock )
      oGet:exitState := GE_NOEXIT
   
   OTHERWISE
      // Ignore all other keystrokes.
      oGet:exitState := GE_NOEXIT

   ENDCASE

   IF oGet:exitState != GE_NOEXIT
      oGet:killfocus()
   ENDIF

   RETURN NIL

// WVW Callback functions

// Called after application window is restored or when
// user clicks on a window
FUNCTION wvw_SetFocus( nWinNum )

   LOCAL oGet

   IF nWinNum <> TOPWINDOW
      // Set focus to topmost window
      win_SetFocus( wvw_GetWindowHandle( TOPWINDOW ) )
      
      // ... and to GET if any.
      // This is needed to ensure GUI control does not lose focus.
      oGet := GetActive()
      
      IF ! Empty( oGet )
         // IF HB_ISOBJECT( oGet:control ) // TODO
         IF ! Empty( oGet:control )
            // Focus on GUI control
            oGet:control:SetFocus()
         ENDIF
      ENDIF
   ENDIF
      
   RETURN NIL


// This function is called when a window gets WM_PAINT message.
// It receives only nWinNum parameter.
FUNCTION wvw_Paint( nWinNum )

   DEFAULT nWinNum TO TOPWINDOW

   IF Len( aGuiObjs ) >= nWinNum + 1
      AEval( aGuiObjs[ nWinNum + 1 ], { | e | Eval( e, nWinNum ) } )
   ENDIF

   RETURN NIL


FUNCTION wvw_Size( nWinNum, hWnd, message, wParam, lParam )

   HB_SYMBOL_UNUSED( hWnd )
   HB_SYMBOL_UNUSED( message )
   HB_SYMBOL_UNUSED( lParam )

   DEFAULT nWinNum TO TOPWINDOW

   IF ! wvw_Size_Ready()
      RETURN NIL
   ENDIF

   IF nWinNum <> 0
      // Only care about the Main Window
      RETURN NIL
   ENDIF

   // Avoid re-entry
   wvw_Size_Ready( .F. )

   DO CASE
   CASE wParam == SIZE_MINIMIZED    // 1
      // After wnidow is minimized
   CASE wParam == SIZE_RESTORED     // 0
      // After window is restored
   ENDCASE

   wvw_Size_Ready( .T. )

   RETURN NIL


// Functions to manage the repainting of non-native GUI objects.
// GETBOX, LABEL, LABELOBJ, BOX, IMAGE
FUNCTION ClrGuiObjs( nWinNum )

   DEFAULT nWinNum TO TOPWINDOW

   DO WHILE Len( aGuiObjs ) < nWinNum + 1
      // Create one if missing.
      AAdd( aGuiObjs, {} )
   ENDDO

   aGuiObjs[ nWinNum + 1 ] := {}

   RETURN .T.


FUNCTION AddGuiObj( nWinNum, bAction )

   DEFAULT nWinNum TO TOPWINDOW

   // Add codeblock to repaint this control
   AAdd( aGuiObjs[ nWinNum + 1 ], bAction )

   RETURN .T.


FUNCTION LenGuiObjs( nWinNum )

   DEFAULT nWinNum TO TOPWINDOW

   RETURN Len( aGuiObjs[ nWinNum + 1 ] )


FUNCTION ReSizeGuiObjs( nWinNum, aLen )

   DEFAULT nWinNum TO TOPWINDOW

   ASize( aGuiObjs[ nWinNum + 1 ], aLen )

   RETURN NIL


// Functions to manage the destruction of persistant native GUI objects.
// CHECKBOX, EDITBOX, LISTBOX, PUSHBUTTON, RADIOGROUP
FUNCTION ClrGuiCtls( nWinNum )

   DEFAULT nWinNum TO TOPWINDOW

   DO WHILE Len( aGUICtls ) < nWinNum + 1
      // Create one if missing.
      AAdd( aGUICtls, {} )
   ENDDO

   // Destroy all controls for this window
   AEval( aGUICtls[ nWinNum + 1 ], { | e | Eval( e ) } )

   aGUICtls[ nWinNum + 1 ] := {}

   RETURN .T.


FUNCTION AddGuiCtl( nWinNum, bAction )

   DEFAULT nWinNum TO TOPWINDOW

   // Add method to destroy this control
   AAdd( aGUICtls[ nWinNum + 1 ], bAction )

   RETURN .T.


FUNCTION LenGuiCtls( nWinNum )

   DEFAULT nWinNum TO TOPWINDOW

   RETURN Len( aGuiCtls[ nWinNum + 1 ] )


/*
FONT Selection

Default font size is based on application type.
   Console  GUI
   16M      15M

Window   Console  GUI
Heading  +3B      +1M
Menu     +4M      n/a
Label    +1M      +0M
Column   -1N      -1N

Report Font Size is 16M

*/

STATIC FUNCTION Std_FontSize()

   IF aWinType[ Len( aWinType ), 1 ]
      // GUI window
      IF aWinType[ 1, 1 ]
         // GUI main window
         RETURN LABELFONTSIZE
      ENDIF

   ENDIF

   RETURN LABELFONTSIZE + 1


FUNCTION ReportFont()

   // Any smaller, the reports are unreadable
   RETURN { DATAFONTNAME, 16, FW_MEDIUM }


FUNCTION HeadFont()

   IF aWinType[ Len( aWinType ), 1 ]
      // GUI window
      RETURN { LABELFONTNAME, Std_FontSize() + 1, FW_MEDIUM }
   ENDIF

   RETURN { LABELFONTNAME, Std_FontSize() + 2, FW_BOLD }


FUNCTION MenuFont()

   // For Console style menus drawn using LABELOBJ only.
   RETURN { LABELFONTNAME, Std_FontSize() + 4, FW_MEDIUM }
   

FUNCTION LabelFont()

   IF aWinType[ Len( aWinType ), 1 ]
      // GUI window
      RETURN { LABELFONTNAME, Std_FontSize(), FW_MEDIUM }
   ENDIF

   RETURN { LABELFONTNAME, Std_FontSize() + 1, FW_MEDIUM }


FUNCTION ColumnFont()

   RETURN { LABELFONTNAME, Std_FontSize() - 1, FW_NORMAL }


// Display message in main windows's status bar.
FUNCTION Busy( busystr )

   DEFAULT busystr TO ''

   // Can colour first part only. I think!
   IF Empty( busystr )
      // Clear busy message area
      wvw_sbSetText( 0, 0, '', GetSysColor( 8 ), GetSysColor( 4 ) )
   ELSE
      // Display busy message.
      wvw_sbSetText( 0, 0, busystr, GetSysColor( 8 ), GetSysColor( 4 ) )
   ENDIF

   RETURN NIL


FUNCTION CreateToolbar( Tbar )

   // for toolbar:
   LOCAL nSysBitmap := 0     // 0:none 1:small 2:large
   LOCAL lDisplayText := .F. // text will be displayed as tooltip instead
   LOCAL hWndTB

   hWndTB := wvw_tbCreate( , lDisplayText, , nSysBitmap, 24, 24 )

   AEval( TBar, {| x | wvw_tbAddButton( , x[ 1 ], x[ 2 ], x[ 3 ] ) } )

   RETURN NIL


// EOF: WVWCLIP.PRG
