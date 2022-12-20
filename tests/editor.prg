/****

          System: WVWClip
                  Copyright (c) 2016-2022, Ashfaq Sial

            Date: April 2020

         Program: EDITOR.PRG
                  Sample program.

*/
#include "inkey.ch"
#include "wvwclip.ch"

PROCEDURE Editor

   LOCAL lOK   := .F.
   LOCAL lDay  := .F.
   LOCAL lCancel := .F.

   LOCAL nBtn  := 0
   LOCAL cSurn := Pad( "Bloggs", 20 )
   LOCAL cMemo := MemoRead( hb_DirBase() + "\memo.txt" )
   LOCAL cDate := Date()

   PRIVATE nWinNum
   PRIVATE GetList    := {}
   
   nWinNum := WOpen( 2, 3, 18, 65, "Editor Test" )
   
   @ 00, 01 LABEL 'Editor' FONT HeadFont()
   
   @ 02, 10 GET cSurn CAPTION "Name:"
   @ 03, 10, 11, 60 GET cMemo EDITBOX CAPTION "Notes:" STYLE ES_MULTILINE OFFSET { 0, - 2, 0, 1 }
   
   @ 12, 54 SAY PUSHBUTTON  CAPTION 'Today' ;
      WIDTH 5 ;
      STATE {|| EBPaste2( '[' + SubStr( CDoW( Date() ), 1, 3 ) + ;
      ' ' + DToS( Date() ) + ' ' + SubStr( Time(), 1, 5 ) + ']' ) }
   
   @ 13, 10 GET cDate CAPTION "Date:"
   
   @ 15, 10 GET lOK ;
      PUSHBUTTON  CAPTION 'OK' ;
         STATE {|| nBtn := 1, hb_keyPut( K_CTRL_W ) }   

   @ 15, 20 GET lCancel ;
      PUSHBUTTON  CAPTION 'Cancel' ;
      STATE {|| hb_keyPut( K_ESC ) }

   DO WHILE .T.

      nBtn := 0

      READ SAVE

      IF nBtn = 0
         EXIT
      ENDIF

      IF nBtn == 1
         cMemo :=  GetList[ 2 ]:control:GetText()
         WAlert( cMemo )
         EXIT
      ENDIF

   ENDDO

   // thispb:Destroy()
   
   WClose()

   RETURN

FUNCTION EBPaste2( cText )

   LOCAL oGet :=  GetActive()

   IF HB_ISOBJECT( oGet:control ) 
      oGet:control:SetFocus()
      IF oGet:control:cClassName == 'EDITBOX'
         oGet:control:PasteText( cText )
      ENDIF
   ENDIF

   oGet:SetFocus()

   RETURN NIL

// EOF: EDITOR.PRG
