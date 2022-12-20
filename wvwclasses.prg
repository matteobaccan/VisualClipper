/****

          System: WVWClip
                  Copyright (c) 2016-2022, Ashfaq Sial

            Date: December, 16

         Program: WVWCLASSES.PRG
                  Classes to manage GTWVW interface.
*/

#include "inkey.ch"
#include "common.ch"
#include "hbclass.ch"
#include "hbgtinfo.ch"
#include "wvwclip.ch"

#define WVW_CONTROL_EDITBOX  5

#ifdef _HB32_
   // These functions in HB32 are flawed and therefore replaced with hb_gtInfo equivalents.
   #xtranslate wvw_SetClipboard( <x> )  => hb_gtInfo( HB_GTI_CLIPBOARDDATA, <x> )
   #xtranslate wvw_GetClipboard()       => hb_gtInfo( HB_GTI_CLIPBOARDDATA )
#endif

CLASS WVWDrawLabel

   EXPORT:

   DATA cClassName    INIT "DRAWLABEL"
   DATA nControlID    INIT {}

   DATA nRow
   DATA nCol
   DATA cLabel
   DATA nAlign
   DATA nEscapement
   DATA nTextColor
   DATA nBkColor
   DATA cFontFace
   DATA nHeight
   DATA nWeight

   METHOD New( nRow, nCol, cLabel, nAlign, nEscapement, cClr, aFont )

ENDCLASS

METHOD New( nRow, nCol, cLabel, nAlign, nEscapement, cClr, aFont ) CLASS WVWDRAWLABEL

   DEFAULT nAlign       TO TA_RIGHT
   DEFAULT cClr         TO SetColor()
   DEFAULT aFont        TO LabelFont()

   ::nRow        := nRow
   ::nCol        := nCol
   ::cLabel      := cLabel
   ::nAlign      := nAlign
   ::nEscapement := nEscapement
   ::nTextColor  := wvw_GetRGBColor( hb_ColorToN( Token( cClr, "/", 1 ) ) )
   ::nBkColor    := wvw_GetRGBColor( hb_ColorToN( AtRepl( "*", Token( cClr, "/,", 2 ), "+" ) ) )
   ::cFontFace   := aFont[ 1 ]
   ::nHeight     := aFont[ 2 ] + 1
   ::nWeight     := aFont[ 3 ]

   // DOC 
   // wvw_DrawLabel( nWinNum, ;
   //    nRow, nCol, cLabel, nAlign, nEscapement, nTextColor, ;
   //    nBkColor, cFontFace, nHeight, nWidth, nWeight, ;
   //    nQuality, nCharSet, lItalic, lUnderline, lStrikeOut )

   // Add this codeblock to the list of GUI objects
   IF ::cLabel != NIL
      AddGuiObj( , { | nWindow | wvw_DrawLabel( nWindow, ::nRow, ::nCol, ::cLabel, ::nAlign, ::nEscapement, ::nTextColor, ::nBkColor, ::cFontFace, ::nHeight, 0, ::nWeight, PROOF_QUALITY ) } )
   ENDIF

   RETURN Self


CLASS WVWDrawLabelObj

   EXPORT:

   DATA cClassName    INIT "DRAWLABELOBJ"
   DATA nControlID    INIT {}

   DATA nTop
   DATA nLeft
   DATA nBottom
   DATA nRight
   DATA cLabel
   DATA nAlignHorz
   DATA nAlignVert
   DATA nTextColor
   DATA nBkColor
   DATA hFont
   DATA aOffset

   METHOD New( nTop, nLeft, nBottom, nRight, cLabel, nWidth, nAlignH, cClr, aFont, aOffSet )

ENDCLASS

METHOD New(  nTop, nLeft, nBottom, nRight, cLabel, nWidth, nAlignH, cClr, aFont, aOffSet ) CLASS WVWDRAWLABELOBJ

   DEFAULT nBottom      TO nTop 
   DEFAULT nRight       TO nLeft + Len( cLabel ) 
   DEFAULT nWidth       TO Len( cLabel )
   DEFAULT nAlignH      TO TA_RIGHT
   DEFAULT cClr         TO SetColor()
   DEFAULT aFont        TO LabelFont()

   ::nTop        := nTop
   ::nLeft       := nLeft
   ::nBottom     := nBottom
   ::nRight      := nRight 
   ::cLabel      := cLabel
   ::nAlignHorz  := nAlignH
   ::nTextColor  := wvw_GetRGBColor( hb_ColorToN( Token( cClr, "/", 1 ) ) )
   ::nBkColor    := wvw_GetRGBColor( hb_ColorToN( AtRepl( "*", Token( cClr, "/,", 2 ), "+" ) ) )
   ::hFont       := wvw_CreateFont(  aFont[ 1 ], aFont[ 2 ], 0, aFont[ 3 ] )
   ::aOffset     := aOffset

   // DOC
   // wvw_DrawLabelObj( nWinNum,
   //    nTop, nLeft, nBottom, nRight, cLabel, nAlignHorz, nAlignVert,
   //    nTextColor, nBkColor, hFont, aOffset )

   // Add this codeblock to the list of GUI objects
   IF ::cLabel != NIL
      AddGuiObj( , { | nWindow | wvw_DrawLabelObj( nWindow, ::nTop, ::nLeft, ::nBottom, ::nRight, ::cLabel, ::nAlignHorz, , ::nTextColor, ::nBkColor, ::hFont, ::aOffSet ) } )
   ENDIF

   RETURN Self


CLASS WVWPushButton

   EXPORT:

   DATA cClassName    INIT "PUSHBUTTON"
   DATA nControlID    INIT {}

   DATA nRow
   DATA nCol
   DATA nWidth
   DATA cCaption
   DATA bSBlock
   DATA aOffSet

   DATA bBlock
   DATA buffer

   METHOD New( nRow, nCol, cCaption, bSBlock, aOffset, nWidth )
   METHOD Destroy()
   METHOD Disable()
   METHOD Enable()
   METHOD SetFocus()
   METHOD HitTest( nMRow, nMCol )

   HIDDEN:

   METHOD PBHandler( nWinnum, nId )

ENDCLASS

METHOD New( nRow, nCol, cCaption, bSBlock, aOffSet, nWidth ) CLASS WVWPushButton

   DEFAULT nWidth  TO WVW_PB_WIDTH

   ::nRow       := nRow
   ::nCol       := nCol
   ::nWidth     := nWidth
   ::cCaption   := cCaption
   ::bSBlock    := bSBlock
   ::aOffSet    := aOffSet

   // This codeblock is executed whenever an ON_CLICKED event occurs.
   ::bBlock     :=  { | nWinNum, nId | ::PBHandler( nWinNum, nId ) }

   // DOC
   // wvw_pbCreate( nWinNum , 
   //    nTop, nLeft, nBottom, nRight, cText, cImage/nImage, bBlock, aOffset,
   //    nStretchBitmap, lMap3DColors, @hControl, nStyle )
   ::nControlID := { wvw_pbCreate( , ::nRow, ::nCol, ::nRow, ::nCol + ::nWidth - 1, ::cCaption, , ::bBlock, ::aOffSet ) }

   AddGuiCtl( , { || ::Destroy() } )

   // This works but is not usefull in our context.
   // wvw_pbSetStyle( , ::nControlID[ 1 ], BS_DEFPUSHBUTTON )

   RETURN Self

METHOD Destroy() CLASS WVWPushButton

   wvw_pbDestroy( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD Disable() CLASS WVWPushButton

   wvw_pbEnable( , ::nControlID[ 1 ], .F. )

   RETURN NIL

METHOD Enable() CLASS WVWPushButton

   wvw_pbEnable( , ::nControlID[ 1 ], .T. )

   RETURN NIL

METHOD SetFocus() CLASS WVWPushButton

   wvw_pbSetFocus( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD HitTest( nMRow, nMCol ) CLASS WVWPushButton

   IF nMRow == ::nRow .AND. ;
      nMCol >= ::nCol .AND. ;
      nMCol <= ::nCol + ::nWidth - 1
      RETURN HTCLIENT
   ENDIF

   RETURN HTNOWHERE

METHOD PBHandler( nWinNum, nId ) CLASS WVWPushButton

   HB_SYMBOL_UNUSED( nWinnum )
   HB_SYMBOL_UNUSED( nId )

   // Just do it.
   Eval( ::bSBlock )

   RETURN NIL


CLASS WVWCheckBox

   EXPORT:

   DATA cClassName      INIT "CHECKBOX"
   DATA nControlID      INIT {}

   DATA nRow
   DATA nCol
   DATA cCaption

   DATA bBlock
   DATA TypeOut        INIT .F.
   DATA Buffer

   METHOD New( nRow, nCol, cCaption )
   METHOD Destroy()
   METHOD SetFocus()
   METHOD KillFocus()
   METHOD SetCheckBox( lVar )
   METHOD GetCheckBox()
   METHOD HitTest( nMRow, nMCol )

   HIDDEN:

   METHOD CXHandler( nWinnum, nId )

ENDCLASS

METHOD New( nRow, nCol, cCaption ) CLASS WVWCheckBox

   DEFAULT cCaption TO ''

   ::nRow       := nRow
   ::nCol       := nCol
   ::cCaption   := iif( Len( cCaption ) < 4, Pad( cCaption, 4 ), cCaption )

   // This codeblock is executed whenever an BN_CLICK event occurs.
   ::bBlock     :=  { | nWinNum, nId | ::CXHandler( nWinNum, nId ) }

   // DOC
   // wvw_cxCreate( nWinNum ,
   //    nTop, nLeft, nBottom, nRight, cText, cImage/nImage, bBlock, aOffset,
   //    nStretchBitmap, lMap3DColors, @hControl, nStyle )
   ::nControlID := { wvw_cxCreate( , ::nRow, ::nCol, ::nRow, ::nCol + Len( ::cCaption ), ::cCaption, , ::bBlock ) }

   AddGuiCtl( , { || ::Destroy() } )

   RETURN Self

METHOD Destroy() CLASS WVWCheckBox

   wvw_cxDestroy( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD SetFocus() CLASS WVWCheckBox

   wvw_cxSetFocus( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD KillFocus() CLASS WVWCheckBox

   RETURN NIL

METHOD SetCheckBox( lVar ) CLASS WVWCheckBox

   wvw_cxSetCheck( , ::nControlID[ 1 ], iif( lVar, 1, 0 ) )

   RETURN NIL

METHOD GetCheckBox() CLASS WVWCheckBox

   RETURN wvw_cxGetCheck( , ::nControlID[ 1 ] ) == 1

METHOD HitTest( nMRow, nMCol ) CLASS WVWCheckBox

   IF nMRow == ::nRow .AND. ;
      nMCol >= ::nCol .AND. ;
      nMCol <= ::nCol + 3
      RETURN HTCLIENT
   ENDIF

   RETURN HTNOWHERE

METHOD cxHandler( nWinnum, nId ) CLASS WVWCheckBox

   LOCAL i
   LOCAL oGet := GetActive()

   HB_SYMBOL_UNUSED( nWinnum )

   IF Empty( oGet )
      // Ignore this event as READ session has already ended.
      RETURN NIL
   ENDIF

   i := AScan( GetList, { | o | iif( HB_ISOBJECT( o:control ), ;
      o:control:nControlID[ 1 ] == nId, ;
      .F. ;
      ) } )

   IF i > 0

      IF oGet:name != GetList[ i ]:name
         MSetPos( GetList[ i ]:row, GetList[ i ]:col + 1 )
         hb_keyPut( K_LBUTTONDOWN )
      ENDIF

   ENDIF

   // Put current status of checkbox into GET variable underneath it.
   GetList[ i ]:varput( GetList[ i ]:control:GetCheckBox() )

   RETURN NIL


CLASS WVWEditBox

   EXPORT:

   DATA cClassName    INIT "EDITBOX"
   DATA nControlID    INIT {}

   DATA nTop
   DATA nLeft
   DATA nBottom
   DATA nRight
   DATA nStyle
   DATA nMaxChar
   DATA aOffSet
   DATA aFont
   DATA lMultiline
   DATA lReadOnly

   DATA bBlock
   DATA buffer

   METHOD New( nTop, nLeft, nBottom, nRight, nStyle, nMaxChar, aOffset, aFont )
   METHOD Destroy()
   METHOD SetFocus()
   METHOD SetText( cVar )
   METHOD GetText()
   METHOD PasteText( cVar )
   METHOD HitTest( nMRow, nMCol )

   HIDDEN:

   METHOD EBHandler( nWinNum, nId, nEvent )

ENDCLASS

METHOD New( nTop, nLeft, nBottom, nRight, nStyle, nMaxChar, aOffset, aFont ) CLASS WVWEditBox
   
   ::nTop       := nTop
   ::nLeft      := nLeft
   ::nBottom    := nBottom
   ::nRight     := nRight
   ::nStyle     := nStyle
   ::nMaxChar   := nMaxChar
   ::aOffSet    := aOffSet
   ::aFont      := aFont

   ::lMultiline := hb_bitAnd( nStyle, ES_MULTILINE ) > 0
   ::lReadOnly  := hb_bitAnd( nStyle, ES_READONLY ) > 0

   // This codeblock is executed whenever an EN_SETFOCUS or EN_KILLFOCUS event occurs.
   ::bBlock     :=  { | nWinNum, nId, nEvent | ::EBHandler( nWinNum, nId, nEvent ) }

   IF hb_IsArray(::aFont)
      wvw_ebSetFont( , ::aFont[ 1 ], ::aFont[ 2 ], 0 )
   ENDIF

   // DOC
   // wvw_ebCreate( [nWinNum],
   //    nTop, nLeft, nBottom, nRight, cText, bBlock, lMultiline, nMoreStyle,
   //    nMaxChar, nReserved, aOffset)
   ::nControlID := { wvw_ebCreate( , ::nTop, ::nLeft, ::nBottom, ::nRight, , ::bBlock, ::lMultiline, ::nStyle, ::nMaxChar, , ::aOffset ) }
   
   AddGuiCtl( , { || ::Destroy() } )

   RETURN Self

METHOD Destroy() CLASS WVWEditBox

   wvw_ebDestroy( , ::nControlID[ 1 ] )

   IF hb_IsArray(::aFont)
      // Restore default font name.
      wvw_ebSetFont( , ::aFont[ 1 ] )
   ENDIF

   RETURN NIL

METHOD SetFocus() CLASS WVWEditBox

   wvw_ebSetFocus( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD SetText( cVar ) CLASS WVWEditBox

   wvw_ebSetText( , ::nControlID[ 1 ], cVar )

   RETURN NIL

METHOD GetText() CLASS WVWEditBox

   // GTWVW(HB32) lSoftBreak .T. does not work accurately.
   RETURN wvw_ebGetText( , ::nControlID[ 1 ] ) 

METHOD PasteText( cVar ) CLASS WVWEditBox
   // Code sequence is important.
   LOCAL nhwnd := wvw_GetCtrlHandle( , WVW_CONTROL_EDITBOX, ::nControlID[ 1 ] )
   LOCAL clipbrd := wvw_GetClipboard()          // Save clipboard

   wvw_SetClipboard( cVar )                     // Setup clipboard
   win_SendMessage( nhwnd, WM_PASTE, 0, 0 )     // paste to editbox.
   wvw_SetClipboard( clipbrd )                  // restore clipboard
   
   RETURN NIL

METHOD HitTest( nMRow, nMCol ) CLASS WVWEditBox

   // Ckeck the whole EDITBOX
   IF nMRow >= ::nTop .AND. ;
      nMCol >= ::nLeft .AND. ;
      nMRow <= ::nBottom .AND. ;
      nMCol <= ::nRight

      RETURN HTCLIENT

   ENDIF

   RETURN HTNOWHERE

METHOD EBHandler( nWinNum, nId, nEvent ) CLASS WVWEditBox

   LOCAL i
   LOCAL oGet := GetActive()

   HB_SYMBOL_UNUSED( nWinnum )

   // SecondsSleep(.5)
   //DispOutAt(0,18,Str(nevent,3)+Str(Seconds()))

   IF Empty( GetList )
      // Ignore this event as READ session has already ended.
      RETURN NIL
   ENDIF

   i := AScan( GetList, { | o | iif( HB_ISOBJECT( o:control ), ;
      o:control:nControlID[ 1 ] == nId, ;
      .F. ;
      ) } )

   DO CASE

   CASE nEvent == EN_SETFOCUS // 256

      IF i > 0

         IF oGet:name != GetList[ i ]:name

            // Must be 1st column - EB uses this to place its own cursor on
            MSetPos( GetList[ i ]:row, GetList[ i ]:col )
            hb_keyPut( K_LBUTTONDOWN )

         ENDIF

      ENDIF

   CASE nEvent == EN_KILLFOCUS  // 512

      // Put current text of editbox into GET variable underneath it.
      IF ! ::lReadOnly
         GetList[ i ]:varput( ::GetText() )
      ENDIF

   ENDCASE

   RETURN NIL

CLASS WVWComboBox

   EXPORT:

   DATA cClassName    INIT "COMBOBOX"
   DATA nControlID    INIT {}

   DATA nRow
   DATA nCol
   DATA nWidth
   DATA aText
   DATA nKbdType
   DATA aOffSet

   DATA bBlock
   DATA buffer

   METHOD New( nRow, nCol, nWidth, aText, nKbdType, aOffset )
   METHOD Destroy()
   METHOD SetFocus()
   METHOD IsFocused()
   METHOD SetIndex( xVar )
   METHOD GetIndex()
   METHOD GetCurText()
   METHOD HitTest( nMRow, nMCol )

   HIDDEN:

   METHOD CBHandler( nWinNum, nId, nEvent, nIndex )

ENDCLASS

METHOD New( nRow, nCol, nWidth, aText, nKbdType, aOffset ) CLASS WVWComboBox

   // Needed to align with GET
   DEFAULT aOffSet TO { -2, - 2, 0, 0 }

   ::nRow       := nRow
   ::nCol       := nCol
   ::nWidth     := nWidth
   ::aText      := aText
   ::nKbdType   := nKbdType
   ::aOffSet    := aOffSet

   // This codeblock is executed whenever a CBN_SELCHANGE, CBN_SETFOCUS or CBN_KILLFOCUS event occurs.
   ::bBlock     :=  { | nWinNum, nId, nEvent, nIndex | ::CBHandler( nWinNum, nId, nEvent, nIndex ) }

   // DOC
   // wvw_cbCreate( nWinNum, nTop, nLeft, nWidth, aText, bBlock, nListLines,
   //    nReserved, nKbdType, aOffset, @hControl, nStyle )
   ::nControlID := { wvw_cbCreate( , ::nRow, ::nCol, ::nWidth, ::aText, ::bBlock, 9, , ::nKbdType, ::aOffSet ) }

   AddGuiCtl( , { || ::Destroy() } )

   RETURN Self

METHOD Destroy() CLASS WVWComboBox

   wvw_cbDestroy( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD SetFocus() CLASS WVWComboBox

   wvw_cbSetFocus( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD IsFocused() CLASS WVWComboBox

   RETURN wvw_cbIsFocused( , ::nControlID[ 1 ] )

METHOD SetIndex( xVar ) CLASS WVWComboBox

   LOCAL _tmp_

   _tmp_ := iif( ValType( xVar ) == "N", ;
      Max( xVar - 1, 0 ), ;
      wvw_cbFindString( , ::nControlID[ 1 ], Trim( xVar ) ) ;
      )
   wvw_cbSetIndex( , ::nControlID[ 1 ], _tmp_ )

   RETURN NIL

METHOD GetIndex() CLASS WVWComboBox

   RETURN wvw_cbGetIndex( , ::nControlID[ 1 ] ) + 1

METHOD GetCurText() CLASS WVWComboBox

   RETURN wvw_cbGetCurText( , ::nControlID[ 1 ] )

METHOD HitTest( nMRow, nMCol ) CLASS WVWComboBox

   // Check the whole ComboBox
   IF nMRow == ::nRow .AND. ;
      nMCol >= ::nCol .AND. ;
      nMCol <= ::nCol + ::nWidth //- 1
      RETURN HTCAPTION
   ENDIF

   RETURN HTNOWHERE

METHOD CBHandler( nWinNum, nId, nEvent, nIndex ) CLASS WVWComboBox

   LOCAL i
   LOCAL oGet := GetActive()

   // Debug
   //DispOutAt(0,18,Str(nevent,1)+Str(Seconds()))
   //DispOutAt(2,0,oget:name)

   HB_SYMBOL_UNUSED( nWinNum )
   HB_SYMBOL_UNUSED( nIndex )

   IF Empty( GetList )
      // Ignore this event as READ session has already ended.
      RETURN NIL
   ENDIF

   i := AScan( GetList, { | o | iif( HB_ISOBJECT( o:control ), ;
      o:control:nControlID[ 1 ] == nId, ;
      .F. ;
      ) } )

   // Debug
   //DispOutAt(1,0,Space(30))
   //DispOutAt(1,0,oget:name+' '+iif(oGet:hasfocus,'Y','N'))
   //DispOutAt(1,15,GetList[i]:name+' '+iif(GetList[i]:hasfocus,'Y','N'))

   DO CASE

   CASE nEvent == CBN_SELCHANGE  // 1

      //
      // Do nothing.
      //

   CASE nEvent == CBN_SETFOCUS  // 3

      IF i > 0

         IF oGet:name != GetList[ i ]:name

            MSetPos( GetList[ i ]:row, GetList[ i ]:col + 1 )
            hb_keyPut( K_LBUTTONDOWN )

         ENDIF

      ENDIF

   CASE nEvent == CBN_KILLFOCUS  // 4

      // Put current selection of control into GET variable underneath it.
      IF GetList[ i ]:type == "N"
         GetList[ i ]:varput( ::GetIndex() )
      ELSE
         GetList[ i ]:varput( ::GetCurText() )
      ENDIF

   ENDCASE

   RETURN NIL


CLASS WVWRadioGroup

   EXPORT:

   DATA cClassName    INIT "RADIOGROUP"
   DATA nControlID    INIT {}

   DATA nTop
   DATA nLeft
   DATA nBottom
   DATA nRight
   DATA aButtons
   DATA aOffSet
   DATA nButton
   DATA nBtnCnt

   DATA bBlock
   DATA buffer
   DATA nRow

   METHOD New( nTop, nLeft, nBottom, nRight, nVar, aButtons, aOffset )
   METHOD Destroy()
   METHOD SetFocus()
   METHOD SetButton( nVar )
   METHOD PrevItem()
   METHOD NextItem()
   METHOD HitTest( nMRow, nMCol )

   HIDDEN:

   METHOD RBHandler( nWinNum, nId )

ENDCLASS

METHOD New( nTop, nLeft, nBottom, nRight, nVar, aButtons, aOffset ) CLASS WVWRadioGroup

   LOCAL j

   ::nTop       := nTop
   ::nLeft      := nLeft
   ::nBottom    := nBottom
   ::nRight     := nRight
   ::nButton    := nVar
   ::aButtons   := aButtons
   ::aOffSet    := aOffSet
   ::nBtnCnt    := Len( aButtons )

   // This codeblock is executed whenever an ON_CLICK event occurs.
   ::bBlock     :=  { | nWinNum, nId | ::RBHandler( nWinNum, nId ) }

   // DOC
   // wvw_rbCreate( nWinNum , nTop, nLeft, nBottom, nRight, cText,
   //    cImage/nImage, bBlock, aOffset, nStretchBitmap, lMap3DColors, @hControl, nStyle )
   FOR j := 1 TO ::nBtnCnt
      AAdd( ::nControlID, NIL )
      ::nControlID[ j ] := wvw_rbCreate( , ::nTop + j - 1, ::nLeft + 1, ::nTop + j - 1, ::nRight - 1, aButtons[ j ], , ::bBlock, ::aOffset, , , , iif( j == 1, WS_GROUP, 0 ) )
   NEXT j

   AddGuiCtl( , { || ::Destroy() } ) ; ;

   RETURN Self

METHOD Destroy() CLASS WVWRadioGroup

   LOCAL x

   FOR x := 1 TO ::nBtnCnt
      wvw_cxDestroy( , ::nControlID[ x ] )
   NEXT x

   RETURN NIL

METHOD SetFocus() CLASS WVWRadioGroup

   wvw_cxSetFocus( , ::nControlID[ ::nButton ] )

   RETURN NIL

METHOD SetButton( nButton ) CLASS WVWRadioGroup

   wvw_cxSetCheck( , ::nControlID[ nButton ], BST_CHECKED )

   RETURN NIL

METHOD PrevItem() CLASS WVWRadioGroup

   wvw_cxSetCheck( , ::nControlID[ ::nButton ], BST_UNCHECKED )

   ::nButton -= 1
   IF ::nButton < 1
      ::nButton := 1
   ENDIF

   wvw_cxSetCheck( , ::nControlID[ ::nButton ], BST_CHECKED )
   wvw_cxSetFocus( , ::nControlID[ ::nButton ] )

   RETURN NIL

METHOD NextItem() CLASS WVWRadioGroup

   wvw_cxSetCheck( , ::nControlID[ ::nButton ], BST_UNCHECKED )

   ::nButton += 1
   IF ::nButton > ::nBtnCnt
      ::nButton := 1
   ENDIF

   wvw_cxSetCheck( , ::nControlID[ ::nButton ], BST_CHECKED )
   wvw_cxSetFocus( , ::nControlID[ ::nButton ] )

   RETURN NIL

METHOD HitTest( nMRow, nMCol ) CLASS WVWRadioGroup

   // Check for GROUPBOX
   IF nMRow >= ::nTop .AND. ;
      nMCol >= ::nLeft .AND. ;
      nMRow <= ::nBottom .AND. ;
      nMCol <= ::nRight
   
      RETURN ::nButton
   ENDIF

   RETURN HTNOWHERE

METHOD RBHandler( nWinNum, nId ) CLASS WVWRadioGroup

   LOCAL i
   LOCAL oGet := GetActive()

   HB_SYMBOL_UNUSED( nWinNum )

   IF Empty( GetList )
      // Ignore this event as READ session has already ended.
      RETURN NIL
   ENDIF

   i := AScan( GetList, { | o | iif( HB_ISOBJECT( o:control ), ;
      AScan( o:control:nControlID,  { | y | y == nId } ) > 0, ;
      .F. ;
      ) } )

   IF i > 0

      IF oGet:name != GetList[ i ]:name

         MSetPos( GetList[ i ]:row, GetList[ i ]:col + 1 )
         hb_keyPut( K_LBUTTONDOWN )

      ENDIF

      // Put radiobutton number into GET variable underneath it.
      ::nButton := AScan( GetList[ i ]:control:nControlID, nId )
      GetList[ i ]:varPut( ::nButton )

   ENDIF

   RETURN NIL


CLASS WVWScrollBar

   EXPORT:

   DATA cClassName    INIT "SCROLLBAR"
   DATA nControlID    INIT {}

   DATA nStyle
   DATA oBrowse
   DATA aOffset

   DATA nTop
   DATA nLeft
   DATA nLength
   DATA bBlock

   METHOD New( nStyle, oBrowse, aOffset )
   METHOD Destroy()
   METHOD Refresh()
   METHOD Visible( lVisible )
   METHOD Enable()
   METHOD Disable()
   METHOD Skipper( nSkip )

   HIDDEN:

   METHOD XBHandler( nWinNum, nXBid, nXBmsg, nXBPos )

ENDCLASS

METHOD New( nStyle, oBrowse, aOffset ) CLASS WVWScrollBar

   DEFAULT aOffset TO VXB_OFFSET

   ::nStyle  := nStyle
   ::oBrowse := oBrowse
   ::aOffset := aOffset

   // Column headings are not part of browse window. As we want the
   // scrollbar to include column headings, it should start from
   // the previous line; oBrowse:nTop less one. NOT IMPLEMENTED
   ::nTop    := oBrowse:nTop //- 1
   ::nLeft   := oBrowse:nRight
   ::nLength := oBrowse:nBottom - ::nTop + 1
   ::bBlock  := { | nWinNum, nXBid, nXBmsg, nXBpos | ::XBHandler( nWinNum, nXBid, nXBmsg, nXBpos ) }

   // DOC
   // wvw_xbCreate( nWinNum, nStyle, nTop, nLeft, nLength, bBlock, aOffset )
   ::nControlID := { wvw_xbCreate( , ::nStyle, ::nTop, ::nLeft, ::nLength, ::bBlock, ::aOffset ) }
   ::Disable()

   RETURN Self

METHOD Destroy() CLASS WVWScrollBar

   wvw_xbDestroy( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD Refresh() CLASS WVWScrollBar

   LOCAL xordKeyNo := iif( ordNumber() > 0, ordKeyNo(), RecNo() )
   LOCAL nLastRec  := iif( ordNumber() > 0, ordKeyCount(), LastRec() )

   // DOC 
   // wvw_xbUpdate( nWinNum, nXBId, nPos, nPageSize, nMin, nMax )
   wvw_xbUpdate( , ::nControlID[ 1 ], ;
      xordKeyNo, ;
      ::nLength, ;
      1, ;
      nLastRec + ::nLength - 1 ;
      )

   RETURN NIL

METHOD Visible( lVisible ) CLASS WVWScrollBar

   wvw_xbVisible( , ::nControlID[ 1 ], lVisible )

   RETURN NIL

METHOD Enable() CLASS WVWScrollBar

   wvw_xbEnable( , ::nControlID[ 1 ], ESB_ENABLE_BOTH )

   RETURN NIL

METHOD Disable() CLASS WVWScrollBar

   wvw_xbEnable( , ::nControlID[ 1 ], ESB_DISABLE_BOTH )

   RETURN NIL
   
METHOD Skipper( nSkip )

   // For use with @... BROWSE

   nSkip := dbSkipper( nSkip )

   ::oBrowse:nVXBid:Refresh()

   RETURN nSkip


METHOD XBHandler( nWinNum, nXBid, nXBmsg, nXBPos ) CLASS WVWScrollBar

   LOCAL xordKeyNo := iif( ordNumber() > 0, ordKeyNo(), RecNo() )
   LOCAL nLastRec  := iif( ordNumber() > 0, ordKeyCount(), LastRec() )
   LOCAL aInfo := wvw_xbInfo( nWinNum, nXBid )

   // DEBUG
   // alert(str(nwinnum)+str(TOPWINDOW))

   // if we can't handle non-topmost window we must return right away
   IF nWinNum <> TOPWINDOW ; RETURN NIL ; ENDIF

   DO CASE
   CASE nXBmsg == SB_LINEUP
      IF xordKeyNo == 1; RETURN NIL; ENDIF
      ::oBrowse:up()

   CASE nXBmsg == SB_LINEDOWN
      IF xordKeyNo == nLastRec; RETURN NIL; ENDIF
      ::oBrowse:down()

   CASE nXBmsg == SB_PAGEUP
      IF xordKeyNo == 1; RETURN NIL; ENDIF
      ::oBrowse:pageup()

   CASE nXBmsg == SB_PAGEDOWN
      IF xordKeyNo == nLastRec; RETURN NIL; ENDIF
      ::oBrowse:pagedown()

   CASE nXBmsg == SB_THUMBTRACK
      // Scroll thumb is being dragged at position nXBpos

      // *****
      // As nXBpos range is 1-65535 and it recycles thereafter, it is not useful
      // for scrolling files containg more than 65536 records.
      // aInfo[ 5 ] on the othe other hand contains ordKeyNo()/RecNo()
      // which can be used for our purposes.
      // *****

      /*
      DispOutAt(2,00, Str(nxbpos,7))
      DispOutAt(2,07, Str(aInfo[1],7))   //Min position
      DispOutAt(2,14, Str(aInfo[2],7))   //Max position
      DispOutAt(2,21, Str(aInfo[3],7))   //Page Size
      DispOutAt(2,28, Str(aInfo[4],7))   //Start position of scolling button before scroll begins
      DispOutAt(2,35, Str(aInfo[5],7))   //Current position of scrolling button
      */

      IF aInfo[ 5 ] == 1                     // min
         // Moving to TOP
         ::oBrowse:GoTop()
      ELSE
         IF aInfo[ 5 ] >= nLastRec
            // Moving to BOTTOM
            ::oBrowse:GoBottom()
         ELSE
            // Moving to a new position
            IF ordNumber() > 0
               ordKeyGoto( aInfo[ 5 ] )
            ELSE
               dbGoto( aInfo[ 5 ] )
            ENDIF
         ENDIF

      ENDIF

      // Update whole browse display to reflect
      // thumb track movement.
      ::oBrowse:RefreshAll()

   OTHERWISE
      // Ignore these events
      // SB_THUMBPOSITION
      // SB_ENDSCROLL

   ENDCASE

   // Essential to do this here.
   // Creates display that moves with scrollbar activity
   ::oBrowse:ForceStable()

   // Update scrollbar resulting from cursor movement.
   ::Refresh()

   RETURN NIL


CLASS WVWScrollBarA

   EXPORT:

   DATA cClassName    INIT "SCROLLBARA"
   DATA nControlID    INIT {}

   DATA nStyle
   DATA oBrowse
   DATA aOffset

   DATA nTop
   DATA nLeft
   DATA nLength
   DATA bBlock

   METHOD New( nStyle, oBrowse, aOffset )
   METHOD Destroy()
   METHOD Refresh( mRatio )
   METHOD Enable()
   METHOD Disable()
      
   HIDDEN:

   METHOD XBHandler( nWinNum, nXBid, nXBmsg, nXBPos )

ENDCLASS

METHOD New( nStyle, oBrowse, aOffset ) CLASS WVWScrollBarA

   DEFAULT aOffset TO VXB_OFFSET

   ::nStyle  := nStyle
   ::oBrowse := oBrowse
   ::aOffset := aOffset

   // Column headings are not part of browse window. As we want the
   // scrollbar to include column headings, it should start from
   // the previous line; oBrowse:nTop less one. NOT IMPLEMENTED
   ::nTop    := oBrowse:nTop //- 1
   ::nLeft   := oBrowse:nRight
   ::nLength := oBrowse:nBottom - ::nTop + 1
   ::bBlock  := { | nWinNum, nXBid, nXBmsg, nXBpos | ::XBHandler( nWinNum, nXBid, nXBmsg, nXBpos ) }

   // DOC 
   // wvw_xbCreate( nWinNum, nStyle, nTop, nLeft, nLength, bBlock, aOffset )
   ::nControlID := { wvw_xbCreate( , ::nStyle, ::nTop, ::nLeft, ::nLength, ::bBlock, ::aOffset ) }
   
   RETURN Self

#xtrans  :data   =>   :cargo\[1]
#xtrans  :recno  =>   :cargo\[2]

METHOD Destroy() CLASS WVWScrollBarA

   wvw_xbDestroy( , ::nControlID[ 1 ] )

   RETURN NIL

METHOD Refresh( mRatio ) CLASS WVWScrollBarA

   DEFAULT mRatio TO 1

   //DOC wvw_xbUpdate( nWinNum, nXBId, nPos, nPageSize, nMin, nMax )
   wvw_xbUpdate( , ::nControlID[ 1 ], ;
      ::oBrowse:recNo, ;
      ::oBrowse:RowCount / mRatio, ;
      1, ;
      ( Len( ::oBrowse:data ) + ::oBrowse:rowCount - 1 ) / mRatio ;
      )

   RETURN NIL

METHOD Visible( lVisible ) CLASS WVWScrollBarA

   wvw_xbVisible( , ::nControlID[ 1 ], lVisible )

   RETURN NIL

METHOD Enable() CLASS WVWScrollBarA

   wvw_xbEnable( , ::nControlID[ 1 ], ESB_ENABLE_BOTH )

   RETURN NIL

METHOD Disable() CLASS WVWScrollBarA

   wvw_xbEnable( , ::nControlID[ 1 ], ESB_DISABLE_BOTH )

   RETURN NIL
   
METHOD XBHandler( nWinNum, nXBid, nXBmsg, nXBPos ) CLASS WVWScrollBarA

   // Bof() and Eof() is not available here.
   LOCAL aInfo := wvw_xbInfo( nWinNum, nXBid )
   LOCAL nLastRec := Len( ::oBrowse:data )

   // DEBUG
   // alert(str(nwinnum)+str(TOPWINDOW))

   // if we can't handle non-topmost window we must return right away
   IF nWinNum <> TOPWINDOW ; RETURN NIL ; ENDIF

   DO CASE
   CASE nXBmsg == SB_LINEUP
      IF ::oBrowse:recNo == 1; RETURN NIL; ENDIF
      ::oBrowse:up()

   CASE nXBmsg == SB_LINEDOWN
      IF ::oBrowse:recNo == nLastRec; RETURN NIL; ENDIF
      ::oBrowse:down()

   CASE nXBmsg == SB_PAGEUP
      IF ::oBrowse:recNo == 1; RETURN NIL; ENDIF
      ::oBrowse:pageup()

   CASE nXBmsg == SB_PAGEDOWN
      IF ::oBrowse:recNo == nLastRec; RETURN NIL; ENDIF
      ::oBrowse:pagedown()

   CASE nXBmsg == SB_THUMBTRACK
      // Scroll thumb is being dragged at position nXBpos

      /*
      DispOutAt(2,00, Str(nxbpos,7))
      DispOutAt(2,07, Str(aInfo[1],7))   //Min position
      DispOutAt(2,14, Str(aInfo[2],7))   //Max position
      DispOutAt(2,21, Str(aInfo[3],7))   //Page Size
      DispOutAt(2,28, Str(aInfo[4],7))   //Start position of scolling button before scroll begins
      DispOutAt(2,35, Str(aInfo[5],7))   //Current position of scrolling button
      */

      IF nXBpos == 1              // min
         // Moving to TOP
         ::oBrowse:GoTop()
      ELSE
         IF nXBPos >= nLastRec
            // Moving to BOTTOM
            ::oBrowse:GoBottom() //pageDown()
         ELSE
            // Moving to a new position
            ::oBrowse:recNo := nXBpos
         ENDIF
      ENDIF

      // Update whole browse display to reflect
      // thumb track movement.
      ::oBrowse:RefreshAll()

   OTHERWISE
      // Ignore these events
      // SB_THUMBPOSITION
      // SB_ENDSCROLL

   ENDCASE

   // Essential to do this here.
   // Creates display that moves with scrollbar activity
   ::oBrowse:ForceStable()

   // Update scrollbar resulting from cursor movement.
   ::Refresh()
   
   RETURN NIL


// EOF: WVWCLASSES.PRG
