//
// Copyright 2016 Ashfaq Sial 
//

#pragma -b-

#include "inkey.ch"

PROCEDURE ErrorSys()

   ErrorBlock( {| e | MyError( e ) } )

   RETURN

STATIC PROCEDURE MyError( e )

   LOCAL i := 1, cErr

   cErr := ;
      e:Description  + hb_eol() + ;
      hb_eol() + ;
      'Operation: ' + e:Operation + hb_eol() + ;
      Arguments( e ) + hb_eol() + ;
      "Call trace:" + hb_eol()


   DO WHILE ! Empty( ProcName( ++i ) )
      cErr += ' ' + RTrim( ProcName( i ) ) + "(" + hb_ntos( ProcLine( i ) ) + ")" + hb_eol()
   ENDDO

   WAlert( cErr )
   QUIT

   RETURN

STATIC FUNCTION Arguments( oErr )

   LOCAL xArg, cArguments := ""

   IF ValType( oErr:Args ) == "A"
      FOR EACH xArg IN oErr:Args
         cArguments += " [" + Str(xArg:__enumIndex(), 2 ) + "] = Type: " + ValType( xArg )

         IF xArg != NIL
            cArguments +=  " Val: " + hb_CStr( xArg ) + hb_eol()
         ENDIF
      NEXT
   ENDIF

   RETURN cArguments
