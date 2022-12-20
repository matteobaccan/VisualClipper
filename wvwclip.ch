/****

          System: WVWClip
                  Copyright (c) 2016-2022, Ashfaq Sial

            Date: December, 16

         Program: WVWSTD.CH
                  Visual Clipper via GTWVW.

*/

#include "wingdi.ch"
#include "winuser.ch"

// Must match with HBGTWVW.H
#define WVW_DEFAULT_MENUKEYEVENT  1024

// Our preferred method of COMBOBOX behavior.
#define WVW_CB_KBD_STANDARD  0
#define WVW_CB_KBD_CLIPPER   1

// Default button size in characters.
#define WVW_PB_WIDTH         7

// Default scrollbar alignment, 2 char wide.
#define VXB_OFFSET           { 0, 2, 0, -3 } 

#define TOPWINDOW            wvw_nNumWindows() - 1

MEMVAR GetList

// xcommand matches all characters. #command only first four.

#xtranslate WOPEN( [<x,...>] )     => W_OPEN( <x> )
#xtranslate WCLOSE()               => W_CLOSE()
   
#xcommand EXTEND OBJECT <!oObj!> WITH DATA <!VarName!> => ;
      __objAddData( <oObj>, #<VarName> ) ; ;
      __objSetValueList( <oObj>, { { #<VarName>, NIL } } )

#xcommand EXTEND OBJECT <!oObj!> WITH MESSAGE <!Message!> INLINE <code,...> => ;
      __objAddInLine( <oObj>, #<Message>,   ;
      { | Self | HB_SYMBOL_UNUSED( Self ), <code> } )

#xcommand @ <nTop>, <nLeft>, <nBottom>, <nRight> BOX <bt:RAISED,RECESSED,GROUP> ;
      [CAPTION <cCaption>] ;
      [OFFSET <aOffset>] ;
      => ;
      AddGuiObj( , { | nWindow | wvw_DrawBox<bt>( nWindow, <nTop>, <nLeft>, <nBottom>, <nRight>, <aOffset> ) } ) ; ;
      WVWDrawLabel():New( <nTop>, <nLeft>, <cCaption>, TA_LEFT )

#xcommand @ <nRow>, <nCol> SAY <sayexp> ;
      [CAPTION <cCaption>] ;
      [PICTURE <pic>] ;
      [COLOR <cClr>] ;
      => ;
      DevPos( <nRow>, <nCol> ) ; DevOutPict( <sayexp>, <pic>, <cClr> ) ; ;
      WVWDrawLabel():New( <nRow>, <nCol>-1, <cCaption>, TA_RIGHT )

#xcommand @ <nRow>, <nCol> SAY PUSHBUTTON ;
      [CAPTION <cCaption>] ;
      [WIDTH <nWidth>] ;
      [STATE <bAction>] ;
      [OFFSET <aOffset>] ;
      => ;
      wvwPushButton():New( <nRow>, <nCol>, <cCaption>, <{bAction}>, <aOffset>, <nWidth> )

#xcommand @ <nRow>, <nCol> GET <v> ;
      [CAPTION <cCaption>] ;
      [PICTURE <pic>] ;
      [VALID <valid>] [WHEN <when>] ;
      [SEND <snd>] ;
      => ;
      WVWDrawLabel():New( <nRow>, <nCol>-1, <cCaption>, TA_RIGHT ) ; ;
      SetPos( <nRow>, <nCol> ) ; ;
      AAdd( GetList, _GET_( <v>, <(v)>, <pic>, <{valid}>, <{when}> ) ) ; ;
    [ ATail( GetList ):<snd> ;] ;
      ATail( GetList ):Display()

#xcommand @ <nRow>, <nCol> GET <v> CHECKBOX ;
      [CAPTION <cCaption>] ;
      [VALID <valid>] [WHEN <when>] ;
      => ;
      SetPos( <nRow>, <nCol> ) ; ;
      AAdd( GetList, _GET_( <v>, <(v)>, , <{valid}>, <{when}> ) ) ; ;
      ATail( GetList ):control := WVWCheckBox():New( <nRow>, <nCol>, <cCaption> ); ;
      ATail( GetList ):control:SetCheckBox( <v> ) ; ;
      ATail( GetList ):reader := { | a | GenReader( a ) } ; ;
      ATail( GetList ):Display()

#xcommand @ <nTop>, <nLeft>, <nBottom>, <nRight> GET <v> EDITBOX ;
      [CAPTION <cCaption>] ;
      [FONT <aFont>] ;
      [STYLE <nStyle>] ;
      [MAXCHAR <nMaxchar>] ;
      [OFFSET <aOffset>] ;
      => ;
      WVWDrawLabel():New( <nTop>, <nLeft>-1, <cCaption>, TA_RIGHT ) ; ;
      SetPos( <nTop>, <nLeft> ) ; ;
      AAdd( GetList, _GET_( <v>, <(v)>, Replicate( 'X', <nRight>-<nLeft>+1 ), , ) ) ; ;
      ATail( GetList ):control := wvwEditBox():New( <nTop>, <nLeft>, <nBottom>, <nRight>, <nStyle>, <nMaxchar>, <aOffset>, <aFont> ) ; ;
      ATail( GetList ):control:SetText( <v> ) ; ;
      ATail( GetList ):reader := { | a | GenReader( a ) } ; ;
      ATail( GetList ):Display()

#xcommand @ <nTop>, <nLeft>, <nBottom>, <nRight> GET <v> LISTBOX <aOptions> ;
      [VALID <valid>] [WHEN <when>] ;
      [DROPDOWN] ;
      [CAPTION <cCaption>] ;
      [OFFSET <aOffset>] ;
      => ;
      WVWDrawLabel():New( <nTop>, <nLeft>-1, <cCaption>, TA_RIGHT ) ; ;
      SetPos( <nTop>, <nLeft> ); ;
      AAdd( GetList, _GET_( <v>, <(v)>, '@KS5', <{valid}>, <{when}> ) ) ; ;
      ATail( GetList ):control := wvwComboBox():New( <nTop>, <nLeft>, <nRight>-<nLeft>+1, <aOptions>, WVW_CB_KBD_STANDARD, <aOffset> ) ; ;
      ATail( GetList ):control:SetIndex( <v> ) ; ;
      ATail( GetList ):reader := { | a | GenReader( a ) } ; ;
      ATail( GetList ):Display()

#xcommand @ <nRow>, <nCol> GET <v> PUSHBUTTON ;
      [CAPTION <cCaption>] ;
      [WIDTH <nWidth>] ;
      [VALID <valid>] [WHEN <when>] ;
      [STATE <bAction>] ;
      [OFFSET <aOffset>] ;
      => ;
      SetPos( <nRow>, <nCol> ) ; ;
      AAdd( GetList, _GET_( <v>, <(v)>, , <{valid}>, <{when}> ) ) ; ;
      ATail( GetList ):control := wvwPushButton():New( <nRow>, <nCol>, <cCaption>, <{bAction}>, <aOffset>, <nWidth> ); ;
      ATail( GetList ):reader := { | a | GenReader( a, <{bAction}> ) } ; ;
      ATail( GetList ):Display()

#xcommand @ <nTop>, <nLeft>, <nBottom>, <nRight> GET <v> RADIOGROUP <aButtons> ;
      [CAPTION <cCaption>] ;
      [VALID <valid>] [WHEN <when>] ;
      [OFFSET <aOffset>] ;
      => ;
      WVWDrawLabel():New( <nTop>-1, <nLeft>, <cCaption>, TA_LEFT ) ; ;
      AddGuiObj( , { | nWindow | wvw_DrawBoxGroup( nWindow, <nTop>, <nLeft>, <nBottom>, <nRight>, <aOffset> ) } ) ; ;
      SetPos( <nTop>, <nLeft> + 1 ) ; ;
      AAdd( GetList, _GET_( <v>, <(v)>, '99', <{valid}>, <{when}> ) ) ; ;
      ATail( GetList ):control := WVWRadioGroup():New( <nTop>, <nLeft>, <nBottom>, <nRight>, <v>, <aButtons>, <aOffset> ) ; ;
      ATail( GetList ):control:SetButton( <v> ) ; ;
      ATail( GetList ):reader := { | a | GenReader( a ) } ; ;
      ATail( GetList ):Display()

#xcommand @ <nTop>, <nLeft>, <nBottom>, <nRight> GET <v> TBROWSE <oBrowse> ;
      [VALID <valid>] [WHEN <when>] ;
      [SEND <snd>] [GUISEND <gsnd>] => ;
      AddGuiObj( , { | nWindow | wvw_DrawBoxRecessed( nWindow, <nTop>, <nLeft>, <nBottom>, <nRight> ) } ) ; ;
      AddGuiObj( , { | nWindow | wvw_DrawGridHorz( nWindow, <nTop>+1, <nLeft>, <nRight>, <nBottom>-<nTop>+1 ) } ) ; ;
      SetPos( <nTop>, <nLeft> ) ; ;
      AAdd( GetList, _GET_( <v>, <(v)>, , <{valid}>, <{when}> ) ) ; ;
      EXTEND OBJECT <oBrowse> WITH DATA nVXBid ; ;
      EXTEND OBJECT <oBrowse> WITH MESSAGE SetFocus INLINE ( NIL ) ; ;
      <oBrowse>:ntop := ATail( GetList ):row ; ;
      <oBrowse>:nleft := ATail( GetList ):col ; ;
      <oBrowse>:nbottom := <nBottom> ; ;
      <oBrowse>:nright := <nRight> - 1 ; ;
      <oBrowse>:Configure() ; ;
      <oBrowse>:nVXBid := WVWScrollBar():New( 1, <oBrowse>, VXB_OFFSET )  ; ;
      <oBrowse>:goTopBlock    := { || DbGoTop() } ; ;
      <oBrowse>:goBottomBlock := { || DbGoBottom() } ; ;
      <oBrowse>:skipBlock := { |nSkip| <oBrowse>:nVXBid:Skipper( nSkip ) } ; ;
      AddGuiCtl( , { || <oBrowse>:nVXBid:Destroy() } ) ; ;
      ATail( GetList ):Control := <oBrowse> ; ;
      ATail( GetList ):reader := { | a, b, c, d | TBReader( a, b, c, d ) } ;
     [ ; ATail( GetList ):<snd>] [ ; ATail( GetList ):Control:<gsnd>]

#xcommand @ <nTop>, <nLeft>[, <nBottom>[, <nRight>]] LABELOBJ <cLabel> ;
      [WIDTH <nWidth>] ;
      [<jright:RIGHT>] ;
      [FONT <aFont>] ;
      [OFFSET <aOffset>] ;
      [COLOR <cClr>] ;
      => ;
      wvwDrawLabelObj():New( <nTop>, <nLeft>, <nBottom>, <nRight>, <cLabel>, <nWidth>, iif( <.jright.>, TA_RIGHT, TA_LEFT ), <cClr>, <aFont>, <aOffset> )

#xcommand @ <nRow>, <nCol> LABEL <cLabel> ;
      [FONT <aFont>] ;
      [<jright:RIGHT>] ;
      [COLOR <cClr>] ;
      => ;
      WVWDrawLabel():New( <nRow>, <nCol>, <cLabel>, iif( <.jright.>, TA_RIGHT, TA_LEFT ), , <cClr> , <aFont> )

#xcommand @ <nTop>, <nLeft>, <nBottom>, <nRight> IMAGE <cFile> ;
      [<transp:TBITMAP>] ;
      [OFFSET <aOffset>] ;
      => ;
      AddGuiObj( , { | nWindow | wvw_DrawImage( nWindow, <nTop>, <nLeft>, <nBottom>, <nRight>, <cFile>, <aOffset>, iif( <.transp.>, .T., .F. ) ) } )

#xcommand WMENU TO <nOpt> ;
      => ;
      <nOpt> := iif( Inkey( 0 ) == WVW_DEFAULT_MENUKEYEVENT, wvw_GetLastMenuEvent(), LastKey() )

#xcommand WAlert(<cMsg>[, <cHead>]) ;
      => ;
      wapi_MessageBox( wvw_GetWindowHandle(), ;
      StrTran( hb_CStr( <cMsg> ), ";", chr( 13 ) ), ;
      iif( Empty( #<cHead> ), "Alert", <cHead> ), ;
      MB_APPLMODAL )


// EOF: WVWSTD.CH
