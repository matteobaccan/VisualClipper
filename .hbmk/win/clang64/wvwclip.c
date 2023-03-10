/* C source generated by Harbour */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( WSETUP );
HB_FUNC_EXTERN( SET );
HB_FUNC_EXTERN( WVW_GETPALETTE );
HB_FUNC_EXTERN( GETSYSCOLOR );
HB_FUNC_EXTERN( WVW_SETPALETTE );
HB_FUNC_EXTERN( WVW_SETALTF4CLOSE );
HB_FUNC_EXTERN( WVW_SETMAINCOORD );
HB_FUNC_EXTERN( WVW_SETPAINTREFRESH );
HB_FUNC_EXTERN( WVW_NOSTARTUPSUBWINDOW );
HB_FUNC_EXTERN( WVW_SETVERTCARET );
HB_FUNC_EXTERN( WVW_SETFONT );
HB_FUNC_EXTERN( SETCOLOR );
HB_FUNC_EXTERN( COLORTON );
HB_FUNC_EXTERN( AADD );
HB_FUNC_EXTERN( WVW_EBSETFONT );
HB_FUNC_STATIC( STD_FONTSIZE );
HB_FUNC_EXTERN( WVW_PBSETFONT );
HB_FUNC_EXTERN( WVW_CBSETFONT );
HB_FUNC_EXTERN( WVW_CXSETFONT );
HB_FUNC_EXTERN( WVW_SBSETFONT );
HB_FUNC_EXTERN( WVW_SETDEFLSPACECOLOR );
HB_FUNC_EXTERN( WVW_SETLSPACECOLOR );
HB_FUNC_EXTERN( WVW_SETPEN );
HB_FUNC_EXTERN( WVW_SETDEFLINESPACING );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( WVW_SETLINESPACING );
HB_FUNC_EXTERN( WVW_SIZE_READY );
HB_FUNC( W_OPEN );
HB_FUNC_EXTERN( __MVPRIVATE );
HB_FUNC_EXTERN( WVW_NOPENWINDOW );
HB_FUNC_EXTERN( WVW_SETWINDOWCENTRE );
HB_FUNC( WINIT );
HB_FUNC_EXTERN( WVW_SETICON );
HB_FUNC_EXTERN( WVW_ENABLESHORTCUTS );
HB_FUNC_EXTERN( WVW_SETTITLE );
HB_FUNC( WCLEAR );
HB_FUNC_EXTERN( WVW_SHOWWINDOW );
HB_FUNC( ADDGUIOBJ );
HB_FUNC_EXTERN( AEVAL );
HB_FUNC_EXTERN( EMPTY );
HB_FUNC_EXTERN( WVW_DRAWBOXGET_XP );
HB_FUNC_EXTERN( TRANSFORM );
HB_FUNC_EXTERN( WVW_DRAWBOXGET );
HB_FUNC( CLRGUIOBJS );
HB_FUNC_EXTERN( WVW_NNUMWINDOWS );
HB_FUNC( CLRGUICTLS );
HB_FUNC_EXTERN( SCROLL );
HB_FUNC( W_CLOSE );
HB_FUNC_EXTERN( WVW_TBDESTROY );
HB_FUNC_EXTERN( WVW_LCLOSEWINDOW );
HB_FUNC_EXTERN( ASIZE );
HB_FUNC( GENREADER );
HB_FUNC_EXTERN( __GETLISTACTIVE );
HB_FUNC_EXTERN( INKEY );
HB_FUNC_EXTERN( HB_ISBLOCK );
HB_FUNC_EXTERN( MROW );
HB_FUNC_EXTERN( MCOL );
HB_FUNC_EXTERN( SETKEY );
HB_FUNC( WVW_SETFOCUS );
HB_FUNC_EXTERN( WIN_SETFOCUS );
HB_FUNC_EXTERN( WVW_GETWINDOWHANDLE );
HB_FUNC_EXTERN( GETACTIVE );
HB_FUNC( WVW_PAINT );
HB_FUNC( WVW_SIZE );
HB_FUNC( LENGUIOBJS );
HB_FUNC( RESIZEGUIOBJS );
HB_FUNC( ADDGUICTL );
HB_FUNC( LENGUICTLS );
HB_FUNC( REPORTFONT );
HB_FUNC( HEADFONT );
HB_FUNC( MENUFONT );
HB_FUNC( LABELFONT );
HB_FUNC( COLUMNFONT );
HB_FUNC( BUSY );
HB_FUNC_EXTERN( WVW_SBSETTEXT );
HB_FUNC( CREATETOOLBAR );
HB_FUNC_EXTERN( WVW_TBCREATE );
HB_FUNC_EXTERN( WVW_TBADDBUTTON );
HB_FUNC_INITSTATICS();

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_WVWCLIP )
{ "WSETUP", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( WSETUP ) }, NULL },
{ "SET", { HB_FS_PUBLIC }, { HB_FUNCNAME( SET ) }, NULL },
{ "GETLIST", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "WVW_GETPALETTE", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_GETPALETTE ) }, NULL },
{ "GETSYSCOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( GETSYSCOLOR ) }, NULL },
{ "WVW_SETPALETTE", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETPALETTE ) }, NULL },
{ "WVW_SETALTF4CLOSE", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETALTF4CLOSE ) }, NULL },
{ "WVW_SETMAINCOORD", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETMAINCOORD ) }, NULL },
{ "WVW_SETPAINTREFRESH", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETPAINTREFRESH ) }, NULL },
{ "WVW_NOSTARTUPSUBWINDOW", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_NOSTARTUPSUBWINDOW ) }, NULL },
{ "WVW_SETVERTCARET", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETVERTCARET ) }, NULL },
{ "WVW_SETFONT", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETFONT ) }, NULL },
{ "SETCOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( SETCOLOR ) }, NULL },
{ "COLORTON", { HB_FS_PUBLIC }, { HB_FUNCNAME( COLORTON ) }, NULL },
{ "AADD", { HB_FS_PUBLIC }, { HB_FUNCNAME( AADD ) }, NULL },
{ "WVW_EBSETFONT", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_EBSETFONT ) }, NULL },
{ "STD_FONTSIZE", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( STD_FONTSIZE ) }, NULL },
{ "WVW_PBSETFONT", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_PBSETFONT ) }, NULL },
{ "WVW_CBSETFONT", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_CBSETFONT ) }, NULL },
{ "WVW_CXSETFONT", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_CXSETFONT ) }, NULL },
{ "WVW_SBSETFONT", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SBSETFONT ) }, NULL },
{ "WVW_SETDEFLSPACECOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETDEFLSPACECOLOR ) }, NULL },
{ "WVW_SETLSPACECOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETLSPACECOLOR ) }, NULL },
{ "WVW_SETPEN", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETPEN ) }, NULL },
{ "WVW_SETDEFLINESPACING", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETDEFLINESPACING ) }, NULL },
{ "LEN", { HB_FS_PUBLIC }, { HB_FUNCNAME( LEN ) }, NULL },
{ "WVW_SETLINESPACING", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETLINESPACING ) }, NULL },
{ "WVW_SIZE_READY", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SIZE_READY ) }, NULL },
{ "W_OPEN", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( W_OPEN ) }, NULL },
{ "NWINNUM", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "__MVPRIVATE", { HB_FS_PUBLIC }, { HB_FUNCNAME( __MVPRIVATE ) }, NULL },
{ "WVW_NOPENWINDOW", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_NOPENWINDOW ) }, NULL },
{ "WVW_SETWINDOWCENTRE", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETWINDOWCENTRE ) }, NULL },
{ "WINIT", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( WINIT ) }, NULL },
{ "WVW_SETICON", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETICON ) }, NULL },
{ "WVW_ENABLESHORTCUTS", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_ENABLESHORTCUTS ) }, NULL },
{ "WVW_SETTITLE", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SETTITLE ) }, NULL },
{ "WCLEAR", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( WCLEAR ) }, NULL },
{ "WVW_SHOWWINDOW", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SHOWWINDOW ) }, NULL },
{ "ADDGUIOBJ", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( ADDGUIOBJ ) }, NULL },
{ "AEVAL", { HB_FS_PUBLIC }, { HB_FUNCNAME( AEVAL ) }, NULL },
{ "EMPTY", { HB_FS_PUBLIC }, { HB_FUNCNAME( EMPTY ) }, NULL },
{ "CONTROL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "WVW_DRAWBOXGET_XP", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_DRAWBOXGET_XP ) }, NULL },
{ "ROW", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "COL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "TRANSFORM", { HB_FS_PUBLIC }, { HB_FUNCNAME( TRANSFORM ) }, NULL },
{ "VARGET", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "PICTURE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "WVW_DRAWBOXGET", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_DRAWBOXGET ) }, NULL },
{ "CLRGUIOBJS", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( CLRGUIOBJS ) }, NULL },
{ "WVW_NNUMWINDOWS", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_NNUMWINDOWS ) }, NULL },
{ "CLRGUICTLS", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( CLRGUICTLS ) }, NULL },
{ "SCROLL", { HB_FS_PUBLIC }, { HB_FUNCNAME( SCROLL ) }, NULL },
{ "W_CLOSE", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( W_CLOSE ) }, NULL },
{ "WVW_TBDESTROY", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_TBDESTROY ) }, NULL },
{ "WVW_LCLOSEWINDOW", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_LCLOSEWINDOW ) }, NULL },
{ "ASIZE", { HB_FS_PUBLIC }, { HB_FUNCNAME( ASIZE ) }, NULL },
{ "GENREADER", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( GENREADER ) }, NULL },
{ "__GETLISTACTIVE", { HB_FS_PUBLIC }, { HB_FUNCNAME( __GETLISTACTIVE ) }, NULL },
{ "SETFOCUS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "INKEY", { HB_FS_PUBLIC }, { HB_FUNCNAME( INKEY ) }, NULL },
{ "HB_ISBLOCK", { HB_FS_PUBLIC }, { HB_FUNCNAME( HB_ISBLOCK ) }, NULL },
{ "EVAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_EXITSTATE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "CCLASSNAME", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "PREVITEM", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "VARPUT", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NBUTTON", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NEXTITEM", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "HITTEST", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "MROW", { HB_FS_PUBLIC }, { HB_FUNCNAME( MROW ) }, NULL },
{ "MCOL", { HB_FS_PUBLIC }, { HB_FUNCNAME( MCOL ) }, NULL },
{ "SETKEY", { HB_FS_PUBLIC }, { HB_FUNCNAME( SETKEY ) }, NULL },
{ "GETDOSETKEY", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "EXITSTATE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "KILLFOCUS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "WVW_SETFOCUS", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( WVW_SETFOCUS ) }, NULL },
{ "WIN_SETFOCUS", { HB_FS_PUBLIC }, { HB_FUNCNAME( WIN_SETFOCUS ) }, NULL },
{ "WVW_GETWINDOWHANDLE", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_GETWINDOWHANDLE ) }, NULL },
{ "GETACTIVE", { HB_FS_PUBLIC }, { HB_FUNCNAME( GETACTIVE ) }, NULL },
{ "WVW_PAINT", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( WVW_PAINT ) }, NULL },
{ "WVW_SIZE", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( WVW_SIZE ) }, NULL },
{ "LENGUIOBJS", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( LENGUIOBJS ) }, NULL },
{ "RESIZEGUIOBJS", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( RESIZEGUIOBJS ) }, NULL },
{ "ADDGUICTL", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( ADDGUICTL ) }, NULL },
{ "LENGUICTLS", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( LENGUICTLS ) }, NULL },
{ "REPORTFONT", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( REPORTFONT ) }, NULL },
{ "HEADFONT", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( HEADFONT ) }, NULL },
{ "MENUFONT", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( MENUFONT ) }, NULL },
{ "LABELFONT", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( LABELFONT ) }, NULL },
{ "COLUMNFONT", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( COLUMNFONT ) }, NULL },
{ "BUSY", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( BUSY ) }, NULL },
{ "WVW_SBSETTEXT", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_SBSETTEXT ) }, NULL },
{ "CREATETOOLBAR", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( CREATETOOLBAR ) }, NULL },
{ "WVW_TBCREATE", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_TBCREATE ) }, NULL },
{ "WVW_TBADDBUTTON", { HB_FS_PUBLIC }, { HB_FUNCNAME( WVW_TBADDBUTTON ) }, NULL },
{ "(_INITSTATICS00005)", { HB_FS_INITEXIT | HB_FS_LOCAL }, { hb_INITSTATICS }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_WVWCLIP, "", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_WVWCLIP
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_WVWCLIP )
   #include "hbiniseg.h"
#endif

HB_FUNC( WSETUP )
{
	static const HB_BYTE pcode[] =
	{
		13,3,2,116,97,0,36,44,0,95,1,100,8,28,5,9,80,1,36,
		45,0,95,2,100,8,28,7,106,1,0,80,2,36,47,0,176,1,0,
		92,39,93,255,0,20,2,36,49,0,95,2,82,4,0,36,50,0,95,
		1,82,5,0,36,52,0,4,0,0,81,2,0,36,55,0,176,3,0,
		12,0,80,5,36,56,0,176,4,0,92,8,12,1,95,5,122,2,36,
		57,0,176,4,0,92,4,12,1,95,5,92,8,2,36,58,0,176,4,
		0,92,17,12,1,95,5,92,9,2,36,59,0,176,4,0,92,13,12,
		1,95,5,92,10,2,36,60,0,176,4,0,92,5,12,1,95,5,92,
		16,2,36,61,0,176,5,0,95,5,20,1,36,64,0,176,6,0,9,
		20,1,36,65,0,176,7,0,9,20,1,36,66,0,176,8,0,92,50,
		20,1,36,67,0,176,9,0,120,20,1,36,68,0,176,10,0,9,20,
		1,36,71,0,103,5,0,28,79,36,74,0,92,6,80,3,36,77,0,
		176,11,0,100,106,9,67,111,110,115,111,108,97,115,0,92,20,121,20,
		4,36,78,0,176,12,0,106,21,78,47,87,44,32,87,43,47,66,42,
		44,32,44,32,44,32,78,47,87,42,0,20,1,36,79,0,176,13,0,
		106,2,87,0,12,1,80,4,25,74,36,86,0,121,80,3,36,89,0,
		176,11,0,100,106,9,67,111,110,115,111,108,97,115,0,92,22,92,11,
		20,4,36,90,0,176,12,0,106,18,87,47,78,44,32,78,47,87,44,
		32,44,32,44,32,87,47,78,0,20,1,36,91,0,176,13,0,106,2,
		78,0,12,1,80,4,36,96,0,176,14,0,103,3,0,103,5,0,95,
		3,4,2,0,20,2,36,103,0,176,15,0,100,106,6,65,114,105,97,
		108,0,176,16,0,12,0,92,2,72,121,20,4,36,104,0,176,17,0,
		100,106,6,65,114,105,97,108,0,176,16,0,12,0,121,20,4,36,105,
		0,176,18,0,100,106,6,65,114,105,97,108,0,176,16,0,12,0,121,
		20,4,36,106,0,176,19,0,100,106,6,65,114,105,97,108,0,176,16,
		0,12,0,121,20,4,36,107,0,176,20,0,100,106,6,65,114,105,97,
		108,0,176,16,0,12,0,121,20,4,36,110,0,176,21,0,95,4,20,
		1,36,111,0,176,22,0,100,95,4,20,2,36,112,0,176,23,0,121,
		100,95,4,20,3,36,116,0,176,24,0,103,3,0,176,25,0,103,3,
		0,12,1,1,92,2,1,20,1,36,117,0,176,26,0,100,103,3,0,
		176,25,0,103,3,0,12,1,1,92,2,1,20,2,36,120,0,176,27,
		0,9,20,1,36,122,0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( W_OPEN )
{
	static const HB_BYTE pcode[] =
	{
		13,0,8,116,97,0,36,128,0,176,30,0,108,29,20,1,36,131,0,
		95,6,100,8,28,7,103,5,0,80,6,36,132,0,95,8,100,8,28,
		13,95,6,28,6,92,6,25,3,121,80,8,36,135,0,176,31,0,95,
		5,95,1,95,2,95,3,95,4,12,5,83,29,0,36,137,0,95,6,
		28,43,36,138,0,176,22,0,100,176,13,0,106,2,87,0,12,1,20,
		2,36,139,0,176,11,0,100,106,9,67,111,110,115,111,108,97,115,0,
		92,20,121,20,4,36,143,0,176,26,0,100,95,8,20,2,36,145,0,
		176,14,0,103,3,0,95,6,95,8,4,2,0,20,2,36,148,0,176,
		32,0,100,95,7,120,20,3,36,152,0,176,33,0,95,5,20,1,36,
		154,0,109,29,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( WINIT )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,116,97,0,36,160,0,176,34,0,100,103,4,0,20,2,36,
		161,0,176,35,0,100,120,20,2,36,163,0,95,1,100,69,28,13,36,
		164,0,176,36,0,100,95,1,20,2,36,168,0,176,37,0,20,0,36,
		171,0,176,38,0,100,122,20,2,36,175,0,103,3,0,176,25,0,103,
		3,0,12,1,1,122,1,28,96,36,179,0,176,39,0,100,89,85,0,
		1,0,0,0,176,40,0,98,2,0,89,69,0,1,0,0,0,176,41,
		0,48,42,0,95,1,112,0,12,1,28,48,176,49,0,100,48,44,0,
		95,1,112,0,48,45,0,95,1,112,0,176,25,0,176,46,0,48,47,
		0,95,1,112,0,48,48,0,95,1,112,0,12,2,12,1,12,4,25,
		3,120,6,12,2,6,20,2,36,183,0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( WCLEAR )
{
	static const HB_BYTE pcode[] =
	{
		36,189,0,176,50,0,176,51,0,12,0,122,49,20,1,36,190,0,176,
		52,0,176,51,0,12,0,122,49,20,1,36,192,0,4,0,0,81,2,
		0,36,194,0,176,53,0,20,0,36,196,0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( W_CLOSE )
{
	static const HB_BYTE pcode[] =
	{
		116,97,0,36,203,0,176,37,0,20,0,36,205,0,176,55,0,20,0,
		36,206,0,176,56,0,20,0,36,208,0,176,25,0,103,3,0,12,1,
		122,15,28,23,36,209,0,176,57,0,103,3,0,176,25,0,103,3,0,
		12,1,122,49,20,2,36,212,0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( GENREADER )
{
	static const HB_BYTE pcode[] =
	{
		13,3,2,36,224,0,176,59,0,12,0,80,5,36,226,0,48,60,0,
		48,42,0,95,1,112,0,112,0,73,36,227,0,48,60,0,95,1,112,
		0,73,36,229,0,176,61,0,121,12,1,80,3,36,232,0,95,3,92,
		13,8,28,57,36,236,0,176,62,0,95,2,12,1,28,29,36,237,0,
		48,63,0,95,2,112,0,73,36,238,0,48,64,0,95,1,92,6,112,
		1,73,26,89,2,36,240,0,48,64,0,95,1,92,2,112,1,73,26,
		73,2,36,243,0,95,3,92,5,8,31,9,95,3,92,19,8,28,102,
		36,244,0,48,65,0,48,42,0,95,1,112,0,112,0,106,11,82,65,
		68,73,79,71,82,79,85,80,0,8,28,56,36,246,0,48,66,0,48,
		42,0,95,1,112,0,112,0,73,36,247,0,48,67,0,95,1,48,68,
		0,48,42,0,95,1,112,0,112,0,112,1,73,36,248,0,48,64,0,
		95,1,121,112,1,73,26,227,1,36,250,0,48,64,0,95,1,122,112,
		1,73,26,212,1,36,253,0,95,3,93,15,1,8,28,17,36,254,0,
		48,64,0,95,1,122,112,1,73,26,186,1,36,0,1,95,3,92,24,
		8,31,9,95,3,92,4,8,28,103,36,4,1,48,65,0,48,42,0,
		95,1,112,0,112,0,106,11,82,65,68,73,79,71,82,79,85,80,0,
		8,28,56,36,6,1,48,69,0,48,42,0,95,1,112,0,112,0,73,
		36,7,1,48,67,0,95,1,48,68,0,48,42,0,95,1,112,0,112,
		0,112,1,73,36,8,1,48,64,0,95,1,121,112,1,73,26,84,1,
		36,10,1,48,64,0,95,1,92,2,112,1,73,26,68,1,36,13,1,
		95,3,92,9,8,28,18,36,14,1,48,64,0,95,1,92,2,112,1,
		73,26,42,1,36,16,1,95,3,92,27,8,28,31,36,17,1,176,1,
		0,92,28,12,1,29,19,1,36,18,1,48,64,0,95,1,92,7,112,
		1,73,26,3,1,36,21,1,95,3,92,18,8,28,18,36,22,1,48,
		64,0,95,1,92,6,112,1,73,26,233,0,36,24,1,95,3,92,3,
		8,28,18,36,25,1,48,64,0,95,1,92,6,112,1,73,26,207,0,
		36,27,1,95,3,92,23,8,28,18,36,28,1,48,64,0,95,1,92,
		6,112,1,73,26,181,0,36,30,1,95,3,92,29,8,28,18,36,31,
		1,48,64,0,95,1,92,3,112,1,73,26,155,0,36,33,1,95,3,
		92,23,8,28,18,36,34,1,48,64,0,95,1,92,4,112,1,73,26,
		129,0,36,36,1,95,3,93,234,3,8,28,58,36,38,1,176,41,0,
		48,70,0,95,5,176,71,0,12,0,176,72,0,12,0,112,2,12,1,
		28,16,36,39,1,48,64,0,95,1,121,112,1,73,25,76,36,41,1,
		48,64,0,95,1,92,10,112,1,73,25,61,36,44,1,176,62,0,176,
		73,0,95,3,12,1,165,80,4,12,1,28,29,36,47,1,48,74,0,
		95,5,95,4,112,1,73,36,48,1,48,64,0,95,1,121,112,1,73,
		25,14,36,52,1,48,64,0,95,1,121,112,1,73,36,56,1,48,75,
		0,95,1,112,0,121,69,28,13,36,57,1,48,76,0,95,1,112,0,
		73,36,60,1,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( WVW_SETFOCUS )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,70,1,95,1,176,51,0,12,0,122,49,69,28,77,36,
		72,1,176,78,0,176,79,0,176,51,0,12,0,122,49,12,1,20,1,
		36,76,1,176,80,0,12,0,80,2,36,78,1,176,41,0,95,2,12,
		1,31,35,36,80,1,176,41,0,48,42,0,95,2,112,0,12,1,31,
		18,36,82,1,48,60,0,48,42,0,95,2,112,0,112,0,73,36,87,
		1,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( WVW_PAINT )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,116,97,0,36,94,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,96,1,176,25,0,103,1,0,12,1,95,1,122,
		72,16,28,37,36,97,1,176,40,0,103,1,0,95,1,122,72,1,89,
		19,0,1,0,1,0,1,0,48,63,0,95,1,95,255,112,1,6,20,
		2,36,100,1,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( WVW_SIZE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,5,36,111,1,95,1,100,8,28,11,176,51,0,12,0,122,49,
		80,1,36,113,1,176,27,0,12,0,31,8,36,114,1,100,110,7,36,
		117,1,95,1,121,69,28,8,36,119,1,100,110,7,36,123,1,176,27,
		0,9,20,1,36,126,1,95,4,122,8,31,10,36,128,1,95,4,121,
		8,73,36,132,1,176,27,0,120,20,1,36,134,1,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CLRGUIOBJS )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,116,97,0,36,141,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,143,1,176,25,0,103,1,0,12,1,95,1,122,
		72,35,28,18,36,145,1,176,14,0,103,1,0,4,0,0,20,2,25,
		224,36,148,1,4,0,0,103,1,0,95,1,122,72,2,36,150,1,120,
		110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( ADDGUIOBJ )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,116,97,0,36,155,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,158,1,176,14,0,103,1,0,95,1,122,72,1,
		95,2,20,2,36,160,1,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( LENGUIOBJS )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,116,97,0,36,165,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,167,1,176,25,0,103,1,0,95,1,122,72,1,
		20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( RESIZEGUIOBJS )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,116,97,0,36,172,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,174,1,176,57,0,103,1,0,95,1,122,72,1,
		95,2,20,2,36,176,1,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CLRGUICTLS )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,116,97,0,36,183,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,185,1,176,25,0,103,2,0,12,1,95,1,122,
		72,35,28,18,36,187,1,176,14,0,103,2,0,4,0,0,20,2,25,
		224,36,191,1,176,40,0,103,2,0,95,1,122,72,1,89,15,0,1,
		0,0,0,48,63,0,95,1,112,0,6,20,2,36,193,1,4,0,0,
		103,2,0,95,1,122,72,2,36,195,1,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( ADDGUICTL )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,116,97,0,36,200,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,203,1,176,14,0,103,2,0,95,1,122,72,1,
		95,2,20,2,36,205,1,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( LENGUICTLS )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,116,97,0,36,210,1,95,1,100,8,28,11,176,51,0,12,
		0,122,49,80,1,36,212,1,176,25,0,103,2,0,95,1,122,72,1,
		20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( STD_FONTSIZE )
{
	static const HB_BYTE pcode[] =
	{
		116,97,0,36,234,1,103,3,0,176,25,0,103,3,0,12,1,1,122,
		1,28,21,36,236,1,103,3,0,122,1,122,1,28,9,36,238,1,92,
		15,110,7,36,243,1,92,16,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( REPORTFONT )
{
	static const HB_BYTE pcode[] =
	{
		36,249,1,106,9,67,111,110,115,111,108,97,115,0,92,16,93,244,1,
		4,3,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( HEADFONT )
{
	static const HB_BYTE pcode[] =
	{
		116,97,0,36,254,1,103,3,0,176,25,0,103,3,0,12,1,1,122,
		1,28,28,36,0,2,106,6,65,114,105,97,108,0,176,16,0,12,0,
		122,72,93,244,1,4,3,0,110,7,36,3,2,106,6,65,114,105,97,
		108,0,176,16,0,12,0,92,2,72,93,188,2,4,3,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MENUFONT )
{
	static const HB_BYTE pcode[] =
	{
		36,9,2,106,6,65,114,105,97,108,0,176,16,0,12,0,92,4,72,
		93,244,1,4,3,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( LABELFONT )
{
	static const HB_BYTE pcode[] =
	{
		116,97,0,36,14,2,103,3,0,176,25,0,103,3,0,12,1,1,122,
		1,28,26,36,16,2,106,6,65,114,105,97,108,0,176,16,0,12,0,
		93,244,1,4,3,0,110,7,36,19,2,106,6,65,114,105,97,108,0,
		176,16,0,12,0,122,72,93,244,1,4,3,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( COLUMNFONT )
{
	static const HB_BYTE pcode[] =
	{
		36,24,2,106,6,65,114,105,97,108,0,176,16,0,12,0,122,49,93,
		144,1,4,3,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( BUSY )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,30,2,95,1,100,8,28,7,106,1,0,80,1,36,33,
		2,176,41,0,95,1,12,1,28,31,36,35,2,176,93,0,121,121,106,
		1,0,176,4,0,92,8,12,1,176,4,0,92,4,12,1,20,5,25,
		28,36,38,2,176,93,0,121,121,95,1,176,4,0,92,8,12,1,176,
		4,0,92,4,12,1,20,5,36,41,2,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CREATETOOLBAR )
{
	static const HB_BYTE pcode[] =
	{
		13,3,1,36,47,2,121,80,2,36,48,2,9,80,3,36,51,2,176,
		95,0,100,95,3,100,95,2,92,24,92,24,12,6,80,4,36,53,2,
		176,40,0,95,1,89,28,0,1,0,0,0,176,96,0,100,95,1,122,
		1,95,1,92,2,1,95,1,92,3,1,12,4,6,20,2,36,55,2,
		100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,97,0,5,0,116,97,0,4,0,0,82,1,0,4,0,0,82,2,
		0,4,0,0,82,3,0,106,1,0,82,4,0,120,82,5,0,7
	};

	hb_vmExecute( pcode, symbols );
}
