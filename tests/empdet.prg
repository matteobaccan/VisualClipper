/****

          System: WVWClip
                  Copyright (c) 2016-2022, Ashfaq Sial

            Date: December, 16

         Program: EMPDET.PRG
                  Sample program.

*/

#include "inkey.ch"
#include "wvwclip.ch"

PROCEDURE empdet

   LOCAL cName     := 'Fred Bloggs Jr.'
   LOCAL dDOB      := Date() - 20000
   LOCAL cStatus   := 'Single'
   LOCAL nSalary   := 95000 
   LOCAL lEmployed := .T.
   LOCAL lOK       := ' '
   LOCAL lCancel   := ' '

   PRIVATE nWinNum
   PRIVATE GetList := {}

   nWinNum := WOpen( 2, 3, 11, 35, "Edit Employee Details", .T. )

   @ 00, 01 LABEL 'Employee Details' FONT HeadFont()

   @ 02, 12 GET cName      CAPTION 'Name:'         PICTURE '@K'
   @ 03, 12 GET dDOB       CAPTION 'Birth Date:'   PICTURE '@D'
   @ 04, 12, 08, 21 GET cStatus LISTBOX { 'Unknown', 'Married', 'Single' } ;
      DROPDOWN CAPTION 'Status:'
   @ 05, 12 GET nSalary    CAPTION 'Salary:'       PICTURE '999,999'
   @ 06, 12 GET lEmployed  CHECKBOX CAPTION 'Employed?'

   @ 08, 12 GET lOK      PUSHBUTTON  CAPTION 'OK' ;
      STATE {|| hb_keyPut( K_CTRL_W ) }

   @ 08, 20 GET lCancel      PUSHBUTTON  CAPTION 'Cancel' ;
      STATE {|| hb_keyPut( K_ESC ) }

   READ SAVE

   IF LastKey() <> K_ESC

      WAlert( cName + ';' + ;
         DToC( dDOB ) + ';' + ;
         cStatus + ';' + ;
         Str( nSalary ) + ';' + ;
         iif( lEmployed, 'Y', 'N' ) ;
         )

   ENDIF

   WClose()

   RETURN


// The example demonstrates how radio button groups can be integrated
// in the Get list.
FUNCTION RadioButton()

   LOCAL aRadio1[ 3 ]
   LOCAL aRadio2[ 4 ]
   LOCAL cName := "Fred's Brother        "
   LOCAL nRB1, nRB2
   LOCAL lSave := .F.
   LOCAL lCancel := .F.

   PRIVATE nWinNum
   PRIVATE GetList := {}

   nWinNum := WOpen( 4, 5, 18, 40, "Radio Buttons", , , 4 )

   aRadio1[ 1 ] := "Red"
   aRadio1[ 2 ] := "Green"
   aRadio1[ 3 ] := "Blue"

   nRB1 := 1            // default to first item.

   aRadio2[ 1 ] := "Five"
   aRadio2[ 2 ] := "Ten"
   aRadio2[ 3 ] := "Twenty"
   aRadio2[ 4 ] := "Fifty"

   nRB2 := 2            // default to 2nd item.

   @ 00, 01 LABEL 'Radio Buttons' FONT HeadFont()

   @  2, 8,  4, 15 GET nRB1 ;
      RADIOGROUP aRadio1 ;
      CAPTION "Colour" ;
      OFFSET { - 5, - 2, 2, 2 }

   @  6, 8 GET cName CAPTION 'Purser:'

   @  8, 18,  11, 25 GET nRB2 ;
      RADIOGROUP aRadio2 ;
      CAPTION "Denomination" ;
      OFFSET { - 5, - 2, 2, 2 }

   @ 13,  8 GET lSave      PUSHBUTTON  CAPTION 'Save' ;
      STATE {|| hb_keyPut( K_CTRL_W ) }

   @ 13, 16 GET lCancel      PUSHBUTTON  CAPTION 'Cancel' ;
      STATE {|| hb_keyPut( K_ESC ) }

   READ

   IF LastKey() <> K_ESC
      WAlert( 'Colour' + Str( nRB1 ) + ';Note' + Str( nRB2 ) )
   ENDIF

   WClose()

   RETURN NIL


FUNCTION CTb()

   LOCAL lClose := .F.
   LOCAL oBrowse := NIL
   LOCAL cid := Space( 3 )
   LOCAL dDate := Date()
   LOCAL lBrow := .F.

   PRIVATE nWinNum
   PRIVATE GetList := {}

   SET DEFAULT TO .\data

   nWinNum := WOpen( 4, 5, 18, 52, "Browse Example", .T., .T., 0 )

   USE currency INDEX currency VIA "DBFCDX" SHARED

   oBrowse := TBrowse():New()
   oBrowse:colorspec := 'N/W*, W/B*'
   oBrowse:autoLite := .F.

   // Select columns
   oBrowse:AddColumn( TBColumn():New( 'ID',       {|| currency->currid } ) )
   oBrowse:AddColumn( TBColumn():New( 'Currency', {|| currency->descript } ) )
   oBrowse:AddColumn( TBColumn():New( 'Symbol',   {|| currency->symb } ) )

   @ 00, 01 LABEL 'Browse Table' FONT HeadFont()

   @ 02, 12 GET cid CAPTION 'Currency ID:' PICTURE '!!!'

   @ 04, 12, 8, 42 GET lBrow TBROWSE oBrowse GUISEND forceStable()
   @ 10, 12 GET dDate CAPTION 'Date:' PICTURE '@D'

   @ 13, 12 GET lClose PUSHBUTTON  CAPTION 'Close' ;
      STATE {|| hb_keyPut( K_ESC ) }

   READ

   USE

   WClose()

   RETURN NIL

// EOF: EMPDET.PRG
