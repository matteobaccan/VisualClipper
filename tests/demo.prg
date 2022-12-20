/****

      demo.prg
      An example of integrating GTWVW GUI controls in Harbour.

      This work is based on ideas from cbtest6.prg
      Copyright 2005 Budyanto Dj. <budyanto@centrin.net.id>

      Copyright 2016-2022 Ashfaq Sial

      To Build:
      hbmk2 demo.hbp

*/

#include "inkey.ch"
#include "wvwclip.ch"

REQUEST DBFCDX
REQUEST HB_CODEPAGE_FRWIN

FUNCTION Main()

   LOCAL nOpt

   SET CENTURY ON
   SET SCOREBOARD OFF
   SET CONFIRM ON
   SET CURSOR OFF

   // Correct codepage
   hb_cdpSelect( "FRWIN" )
   hb_langSelect( "EN" )

   SetMode( 20, 80 )
   SetCancel( .F. )

   // Setup GTWVW for GUI application
   WSetUp( .T., hb_DirBase() + "..\resource\wvwclip.ico" )

   WInit( 'Visual Clipper via GTWVW' )

   // Couldn't think of a better way.
   MainMenu()

   DO WHILE .T.

      // Process menu events.
      WMENU TO nOpt

      IF LastKey() == K_ESC
         EXIT
      ENDIF

      DO CASE

      CASE nOpt == 1601
         DO empdet

      CASE nOpt == 1602
         RadioButton()

      CASE nOpt == 1603
         Editor()

      CASE nOpt == 1604
         CTb()

      CASE nOpt == 1605
         EXIT

      CASE nOpt == 1707
         WAlert( "Built On: " + BuiltOn()+";"+Version() )

      ENDCASE

   ENDDO

   RETURN NIL


FUNCTION BuiltOn()

   // Returns the date .exe was built on.
   LOCAL dDate :=  __DATE__
   LOCAL tTime :=  __TIME__

   RETURN dDate + ' ' + SubStr( tTime, 1, 5 )

// EOF: DEMO.PRG
