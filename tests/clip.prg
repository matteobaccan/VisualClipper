#include "inkey.ch"

PROCEDURE main()

   LOCAL cName     := 'Fred Bloggs Jr.'
   LOCAL dDOB      := Date() - 20000
   LOCAL cStatus   := 'Single'
   LOCAL nSalary   := 95000 
   LOCAL lEmployed := .T.
   LOCAL lOK       := ' '
   LOCAL lCancel   := ' '

   SET CENTURY ON
   SetMode( 10, 32 )
   
   CLS

   @ 00, 01 SAY 'Employee Details'

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

   READ

   IF LastKey() <> K_ESC
      Alert( cName + ';' + ;
         DToC( dDOB ) + ';' + ;
         cStatus + ';' + ;
         Str( nSalary ) + ';' + ;
         iif( lEmployed, 'Y', 'N' ) )
   ENDIF

   RETURN
