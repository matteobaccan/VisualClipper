#include "inkey.ch"
#include "wvwclip.ch"

REQUEST DBFCDX
REQUEST HB_CODEPAGE_FRWIN

FUNCTION Main()

LOCAL lDummy := .F.
LOCAL oBrowse := NIL

PRIVATE GetList := {}

SET DEFAULT TO .\data

hb_cdpSelect( "FRWIN" )
hb_langSelect( "EN" )

SetMode( 7, 30 )

WSetup( .T. )
WInit('Browse Example')

USE currency INDEX currency VIA "DBFCDX" SHARED

// Setup browse.
oBrowse           := TBrowse():New()
oBrowse:colorspec := 'N/W*, W/B*'
oBrowse:autoLite  := .F.

// Add columns.
oBrowse:AddColumn( TBColumn():New( 'ID',       { || currency->currid } ) )
oBrowse:AddColumn( TBColumn():New( 'Currency', { || currency->descript } ) )
oBrowse:AddColumn( TBColumn():New( 'Symbol',   { || currency->symb } ) )

@ 1, 1, 5, 28 GET lDummy TBROWSE oBrowse GUISEND forceStable()

READ

USE

RETURN NIL
