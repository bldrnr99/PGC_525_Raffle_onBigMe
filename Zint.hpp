// CodeGear C++Builder
// Copyright (c) 1995, 2025 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Zint.pas' rev: 36.00 (Windows)

#ifndef ZintHPP
#define ZintHPP

#pragma delphiheader begin
#pragma option push
#if defined(__BORLANDC__) && !defined(__clang__)
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#endif
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Zint
{
//-- forward type declarations -----------------------------------------------
struct zint_vector_rect;
struct zint_vector_hexagon;
struct zint_vector_string;
struct zint_vector_circle;
struct zint_vector;
struct zint_structapp;
struct zint_seg;
struct zint_symbol;
//-- type declarations -------------------------------------------------------
typedef zint_vector_rect *zint_vector_rect_ptr;

struct DECLSPEC_DRECORD zint_vector_rect
{
public:
	float x;
	float y;
	float height;
	float width;
	int colour;
	zint_vector_rect_ptr next;
};


typedef zint_vector_hexagon *zint_vector_hexagon_ptr;

struct DECLSPEC_DRECORD zint_vector_hexagon
{
public:
	float x;
	float y;
	float diameter;
	int rotation;
	zint_vector_hexagon_ptr next;
};


typedef zint_vector_string *zint_vector_string_ptr;

struct DECLSPEC_DRECORD zint_vector_string
{
public:
	float x;
	float y;
	float fsize;
	float width;
	int length;
	int rotation;
	int halign;
	System::Byte *text;
	zint_vector_string_ptr next;
};


typedef zint_vector_circle *zint_vector_circle_ptr;

struct DECLSPEC_DRECORD zint_vector_circle
{
public:
	float x;
	float y;
	float diameter;
	float width;
	int colour;
	zint_vector_circle_ptr next;
};


typedef zint_vector *zint_vector_ptr;

struct DECLSPEC_DRECORD zint_vector
{
public:
	float width;
	float height;
	zint_vector_rect_ptr rectangles;
	zint_vector_hexagon_ptr hexagons;
	zint_vector_string_ptr strings;
	zint_vector_circle_ptr circles;
};


typedef zint_structapp *zint_structapp_ptr;

struct DECLSPEC_DRECORD zint_structapp
{
public:
	int index;
	int count;
	System::StaticArray<System::Byte, 32> id;
};


typedef zint_seg *zint_seg_ptr;

struct DECLSPEC_DRECORD zint_seg
{
public:
	System::Byte *source;
	int length;
	int eci;
};


typedef zint_symbol *zint_symbol_ptr;

struct DECLSPEC_DRECORD zint_symbol
{
public:
	int symbology;
	float height;
	float scale;
	int whitespace_width;
	int whitespace_height;
	int border_width;
	int output_options;
	System::StaticArray<System::Byte, 16> fgcolour;
	System::StaticArray<System::Byte, 16> bgcolour;
	System::Byte *fgcolor;
	System::Byte *bgcolor;
	System::StaticArray<System::Byte, 256> outfile;
	System::StaticArray<System::Byte, 128> primary;
	int option_1;
	int option_2;
	int option_3;
	int show_hrt;
	int input_mode;
	int eci;
	float dpmm;
	float dot_size;
	float text_gap;
	float guard_descent;
	zint_structapp structapp;
	int warn_level;
	int debug;
	System::StaticArray<System::Byte, 256> text;
	int text_length;
	int rows;
	int width;
	System::StaticArray<System::StaticArray<System::Byte, 144>, 200> encoded_data;
	System::StaticArray<float, 200> row_height;
	System::StaticArray<System::Byte, 100> errtxt;
	System::Byte *bitmap;
	int bitmap_width;
	int bitmap_height;
	System::Byte *alphamap;
	zint_vector *vector;
	System::Byte *memfile;
	int memfile_size;
	zint_seg_ptr raw_segs;
	int raw_seg_count;
};


typedef zint_symbol_ptr __cdecl (*ZBarcode_Create)(void);

typedef void __cdecl (*ZBarcode_Clear)(zint_symbol_ptr symbol);

typedef void __cdecl (*ZBarcode_Reset)(zint_symbol_ptr symbol);

typedef void __cdecl (*ZBarcode_Delete)(zint_symbol_ptr symbol);

typedef int __cdecl (*ZBarcode_Encode)(zint_symbol_ptr symbol, System::PByte source, int length);

typedef int __cdecl (*ZBarcode_Encode_Segs)(zint_symbol_ptr symbol, zint_seg_ptr segs, int seg_count);

typedef int __cdecl (*ZBarcode_Encode_File)(zint_symbol_ptr symbol, System::PByte filename);

typedef int __cdecl (*ZBarcode_Print)(zint_symbol_ptr symbol, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_and_Print)(zint_symbol_ptr symbol, System::PByte source, int length, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_Segs_and_Print)(zint_symbol_ptr symbol, zint_seg_ptr segs, int seg_count, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_File_and_Print)(zint_symbol_ptr symbol, System::PByte filename, int rotate_angle);

typedef int __cdecl (*ZBarcode_Buffer)(zint_symbol_ptr symbol, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_and_Buffer)(zint_symbol_ptr symbol, System::PByte source, int length, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_Segs_and_Buffer)(zint_symbol_ptr symbol, zint_seg_ptr segs, int seg_count, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_File_and_Buffer)(zint_symbol_ptr symbol, System::PByte filename, int rotate_angle);

typedef int __cdecl (*ZBarcode_Buffer_Vector)(zint_symbol_ptr symbol, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_and_Buffer_Vector)(zint_symbol_ptr symbol, System::PByte source, int length, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_Segs_and_Buffer_Vector)(zint_symbol_ptr symbol, zint_seg_ptr segs, int seg_count, int rotate_angle);

typedef int __cdecl (*ZBarcode_Encode_File_and_Buffer_Vector)(zint_symbol_ptr symbol, System::PByte filename, int rotate_angle);

typedef int __cdecl (*ZBarcode_ValidID)(int symbol_id);

typedef System::StaticArray<char, 32> TBarcodeName;

typedef int __cdecl (*ZBarcode_BarcodeName)(int symbol_id, /* out */ TBarcodeName &name);

typedef unsigned __cdecl (*ZBarcode_Cap)(int symbol_id, unsigned cap_flag);

typedef float __cdecl (*ZBarcode_Default_Xdim)(int symbol_id);

typedef float __cdecl (*ZBarcode_Scale_From_XdimDp)(int symbol_id, float x_dim_mm, float dpmm, char * filetype);

typedef float __cdecl (*ZBarcode_XdimDp_From_Scale)(int symbol_id, float scale, float x_dim_mm_or_dpmm, char * filetype);

typedef int __cdecl (*ZBarcode_UTF8_To_ECI)(int eci, char * source, int length, char * dest, /* out */ int &p_dest_length);

typedef int __cdecl (*ZBarcode_Dest_Len_ECI)(int eci, char * source, int length, /* out */ int &p_dest_length);

typedef int __cdecl (*ZBarcode_NoPng)(void);

typedef int __cdecl (*ZBarcode_Version)(void);

//-- var, const, procedure ---------------------------------------------------
static _DELPHI_CONST System::Int8 BARCODE_CODE11 = System::Int8(0x1);
static _DELPHI_CONST System::Int8 BARCODE_C25STANDARD = System::Int8(0x2);
static _DELPHI_CONST System::Int8 BARCODE_C25MATRIX = System::Int8(0x2);
static _DELPHI_CONST System::Int8 BARCODE_C25INTER = System::Int8(0x3);
static _DELPHI_CONST System::Int8 BARCODE_C25IATA = System::Int8(0x4);
static _DELPHI_CONST System::Int8 BARCODE_C25LOGIC = System::Int8(0x6);
static _DELPHI_CONST System::Int8 BARCODE_C25IND = System::Int8(0x7);
static _DELPHI_CONST System::Int8 BARCODE_CODE39 = System::Int8(0x8);
static _DELPHI_CONST System::Int8 BARCODE_EXCODE39 = System::Int8(0x9);
static _DELPHI_CONST System::Int8 BARCODE_EANX = System::Int8(0xd);
static _DELPHI_CONST System::Int8 BARCODE_EANX_CHK = System::Int8(0xe);
static _DELPHI_CONST System::Int8 BARCODE_GS1_128 = System::Int8(0x10);
static _DELPHI_CONST System::Int8 BARCODE_EAN128 = System::Int8(0x10);
static _DELPHI_CONST System::Int8 BARCODE_CODABAR = System::Int8(0x12);
static _DELPHI_CONST System::Int8 BARCODE_CODE128 = System::Int8(0x14);
static _DELPHI_CONST System::Int8 BARCODE_DPLEIT = System::Int8(0x15);
static _DELPHI_CONST System::Int8 BARCODE_DPIDENT = System::Int8(0x16);
static _DELPHI_CONST System::Int8 BARCODE_CODE16K = System::Int8(0x17);
static _DELPHI_CONST System::Int8 BARCODE_CODE49 = System::Int8(0x18);
static _DELPHI_CONST System::Int8 BARCODE_CODE93 = System::Int8(0x19);
static _DELPHI_CONST System::Int8 BARCODE_FLAT = System::Int8(0x1c);
static _DELPHI_CONST System::Int8 BARCODE_DBAR_OMN = System::Int8(0x1d);
static _DELPHI_CONST System::Int8 BARCODE_RSS14 = System::Int8(0x1d);
static _DELPHI_CONST System::Int8 BARCODE_DBAR_LTD = System::Int8(0x1e);
static _DELPHI_CONST System::Int8 BARCODE_RSS_LTD = System::Int8(0x1e);
static _DELPHI_CONST System::Int8 BARCODE_DBAR_EXP = System::Int8(0x1f);
static _DELPHI_CONST System::Int8 BARCODE_RSS_EXP = System::Int8(0x1f);
static _DELPHI_CONST System::Int8 BARCODE_TELEPEN = System::Int8(0x20);
static _DELPHI_CONST System::Int8 BARCODE_UPCA = System::Int8(0x22);
static _DELPHI_CONST System::Int8 BARCODE_UPCA_CHK = System::Int8(0x23);
static _DELPHI_CONST System::Int8 BARCODE_UPCE = System::Int8(0x25);
static _DELPHI_CONST System::Int8 BARCODE_UPCE_CHK = System::Int8(0x26);
static _DELPHI_CONST System::Int8 BARCODE_POSTNET = System::Int8(0x28);
static _DELPHI_CONST System::Int8 BARCODE_MSI_PLESSEY = System::Int8(0x2f);
static _DELPHI_CONST System::Int8 BARCODE_FIM = System::Int8(0x31);
static _DELPHI_CONST System::Int8 BARCODE_LOGMARS = System::Int8(0x32);
static _DELPHI_CONST System::Int8 BARCODE_PHARMA = System::Int8(0x33);
static _DELPHI_CONST System::Int8 BARCODE_PZN = System::Int8(0x34);
static _DELPHI_CONST System::Int8 BARCODE_PHARMA_TWO = System::Int8(0x35);
static _DELPHI_CONST System::Int8 BARCODE_CEPNET = System::Int8(0x36);
static _DELPHI_CONST System::Int8 BARCODE_PDF417 = System::Int8(0x37);
static _DELPHI_CONST System::Int8 BARCODE_PDF417COMP = System::Int8(0x38);
static _DELPHI_CONST System::Int8 BARCODE_PDF417TRUNC = System::Int8(0x38);
static _DELPHI_CONST System::Int8 BARCODE_MAXICODE = System::Int8(0x39);
static _DELPHI_CONST System::Int8 BARCODE_QRCODE = System::Int8(0x3a);
static _DELPHI_CONST System::Int8 BARCODE_CODE128AB = System::Int8(0x3c);
static _DELPHI_CONST System::Int8 BARCODE_CODE128B = System::Int8(0x3c);
static _DELPHI_CONST System::Int8 BARCODE_AUSPOST = System::Int8(0x3f);
static _DELPHI_CONST System::Int8 BARCODE_AUSREPLY = System::Int8(0x42);
static _DELPHI_CONST System::Int8 BARCODE_AUSROUTE = System::Int8(0x43);
static _DELPHI_CONST System::Int8 BARCODE_AUSREDIRECT = System::Int8(0x44);
static _DELPHI_CONST System::Int8 BARCODE_ISBNX = System::Int8(0x45);
static _DELPHI_CONST System::Int8 BARCODE_RM4SCC = System::Int8(0x46);
static _DELPHI_CONST System::Int8 BARCODE_DATAMATRIX = System::Int8(0x47);
static _DELPHI_CONST System::Int8 BARCODE_EAN14 = System::Int8(0x48);
static _DELPHI_CONST System::Int8 BARCODE_VIN = System::Int8(0x49);
static _DELPHI_CONST System::Int8 BARCODE_CODABLOCKF = System::Int8(0x4a);
static _DELPHI_CONST System::Int8 BARCODE_NVE18 = System::Int8(0x4b);
static _DELPHI_CONST System::Int8 BARCODE_JAPANPOST = System::Int8(0x4c);
static _DELPHI_CONST System::Int8 BARCODE_KOREAPOST = System::Int8(0x4d);
static _DELPHI_CONST System::Int8 BARCODE_DBAR_STK = System::Int8(0x4f);
static _DELPHI_CONST System::Int8 BARCODE_RSS14STACK = System::Int8(0x4f);
static _DELPHI_CONST System::Int8 BARCODE_DBAR_OMNSTK = System::Int8(0x50);
static _DELPHI_CONST System::Int8 BARCODE_RSS14STACK_OMNI = System::Int8(0x50);
static _DELPHI_CONST System::Int8 BARCODE_DBAR_EXPSTK = System::Int8(0x51);
static _DELPHI_CONST System::Int8 BARCODE_RSS_EXPSTACK = System::Int8(0x51);
static _DELPHI_CONST System::Int8 BARCODE_PLANET = System::Int8(0x52);
static _DELPHI_CONST System::Int8 BARCODE_MICROPDF417 = System::Int8(0x54);
static _DELPHI_CONST System::Int8 BARCODE_USPS_IMAIL = System::Int8(0x55);
static _DELPHI_CONST System::Int8 BARCODE_ONECODE = System::Int8(0x55);
static _DELPHI_CONST System::Int8 BARCODE_PLESSEY = System::Int8(0x56);
static _DELPHI_CONST System::Int8 BARCODE_TELEPEN_NUM = System::Int8(0x57);
static _DELPHI_CONST System::Int8 BARCODE_ITF14 = System::Int8(0x59);
static _DELPHI_CONST System::Int8 BARCODE_KIX = System::Int8(0x5a);
static _DELPHI_CONST System::Int8 BARCODE_AZTEC = System::Int8(0x5c);
static _DELPHI_CONST System::Int8 BARCODE_DAFT = System::Int8(0x5d);
static _DELPHI_CONST System::Int8 BARCODE_DPD = System::Int8(0x60);
static _DELPHI_CONST System::Int8 BARCODE_MICROQR = System::Int8(0x61);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_128 = System::Int8(0x62);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_39 = System::Int8(0x63);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_DM = System::Int8(0x66);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_QR = System::Int8(0x68);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_PDF = System::Int8(0x6a);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_MICPDF = System::Int8(0x6c);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_BLOCKF = System::Int8(0x6e);
static _DELPHI_CONST System::Int8 BARCODE_HIBC_AZTEC = System::Int8(0x70);
static _DELPHI_CONST System::Int8 BARCODE_DOTCODE = System::Int8(0x73);
static _DELPHI_CONST System::Int8 BARCODE_HANXIN = System::Int8(0x74);
static _DELPHI_CONST System::Int8 BARCODE_MAILMARK_2D = System::Int8(0x77);
static _DELPHI_CONST System::Int8 BARCODE_UPU_S10 = System::Int8(0x78);
static _DELPHI_CONST System::Int8 BARCODE_MAILMARK_4S = System::Int8(0x79);
static _DELPHI_CONST System::Int8 BARCODE_MAILMARK = System::Int8(0x79);
static _DELPHI_CONST System::Byte BARCODE_AZRUNE = System::Byte(0x80);
static _DELPHI_CONST System::Byte BARCODE_CODE32 = System::Byte(0x81);
static _DELPHI_CONST System::Byte BARCODE_EANX_CC = System::Byte(0x82);
static _DELPHI_CONST System::Byte BARCODE_GS1_128_CC = System::Byte(0x83);
static _DELPHI_CONST System::Byte BARCODE_EAN128_CC = System::Byte(0x83);
static _DELPHI_CONST System::Byte BARCODE_DBAR_OMN_CC = System::Byte(0x84);
static _DELPHI_CONST System::Byte BARCODE_RSS14_CC = System::Byte(0x84);
static _DELPHI_CONST System::Byte BARCODE_DBAR_LTD_CC = System::Byte(0x85);
static _DELPHI_CONST System::Byte BARCODE_RSS_LTD_CC = System::Byte(0x85);
static _DELPHI_CONST System::Byte BARCODE_DBAR_EXP_CC = System::Byte(0x86);
static _DELPHI_CONST System::Byte BARCODE_RSS_EXP_CC = System::Byte(0x86);
static _DELPHI_CONST System::Byte BARCODE_UPCA_CC = System::Byte(0x87);
static _DELPHI_CONST System::Byte BARCODE_UPCE_CC = System::Byte(0x88);
static _DELPHI_CONST System::Byte BARCODE_DBAR_STK_CC = System::Byte(0x89);
static _DELPHI_CONST System::Byte BARCODE_RSS14STACK_CC = System::Byte(0x89);
static _DELPHI_CONST System::Byte BARCODE_DBAR_OMNSTK_CC = System::Byte(0x8a);
static _DELPHI_CONST System::Byte BARCODE_RSS14_OMNI_CC = System::Byte(0x8a);
static _DELPHI_CONST System::Byte BARCODE_DBAR_EXPSTK_CC = System::Byte(0x8b);
static _DELPHI_CONST System::Byte BARCODE_RSS_EXPSTACK_CC = System::Byte(0x8b);
static _DELPHI_CONST System::Byte BARCODE_CHANNEL = System::Byte(0x8c);
static _DELPHI_CONST System::Byte BARCODE_CODEONE = System::Byte(0x8d);
static _DELPHI_CONST System::Byte BARCODE_GRIDMATRIX = System::Byte(0x8e);
static _DELPHI_CONST System::Byte BARCODE_UPNQR = System::Byte(0x8f);
static _DELPHI_CONST System::Byte BARCODE_ULTRA = System::Byte(0x90);
static _DELPHI_CONST System::Byte BARCODE_RMQR = System::Byte(0x91);
static _DELPHI_CONST System::Byte BARCODE_BC412 = System::Byte(0x92);
static _DELPHI_CONST System::Byte BARCODE_DXFILMEDGE = System::Byte(0x93);
static _DELPHI_CONST System::Byte BARCODE_LAST = System::Byte(0x93);
static _DELPHI_CONST System::Int8 BARCODE_BIND_TOP = System::Int8(0x1);
static _DELPHI_CONST System::Int8 BARCODE_BIND = System::Int8(0x2);
static _DELPHI_CONST System::Int8 BARCODE_BOX = System::Int8(0x4);
static _DELPHI_CONST System::Int8 BARCODE_STDOUT = System::Int8(0x8);
static _DELPHI_CONST System::Int8 READER_INIT = System::Int8(0x10);
static _DELPHI_CONST System::Int8 SMALL_TEXT = System::Int8(0x20);
static _DELPHI_CONST System::Int8 BOLD_TEXT = System::Int8(0x40);
static _DELPHI_CONST System::Byte CMYK_COLOUR = System::Byte(0x80);
static _DELPHI_CONST System::Word BARCODE_DOTTY_MODE = System::Word(0x100);
static _DELPHI_CONST System::Word GS1_GS_SEPARATOR = System::Word(0x200);
static _DELPHI_CONST System::Word OUT_BUFFER_INTERMEDIATE = System::Word(0x400);
static _DELPHI_CONST System::Word BARCODE_QUIET_ZONES = System::Word(0x800);
static _DELPHI_CONST System::Word BARCODE_NO_QUIET_ZONES = System::Word(0x1000);
static _DELPHI_CONST System::Word COMPLIANT_HEIGHT = System::Word(0x2000);
static _DELPHI_CONST System::Word EANUPC_GUARD_WHITESPACE = System::Word(0x4000);
static _DELPHI_CONST System::Word EMBED_VECTOR_FONT = System::Word(0x8000);
static _DELPHI_CONST int BARCODE_MEMORY_FILE = int(0x10000);
static _DELPHI_CONST int BARCODE_RAW_TEXT = int(0x20000);
static _DELPHI_CONST System::Int8 DATA_MODE = System::Int8(0x0);
static _DELPHI_CONST System::Int8 UNICODE_MODE = System::Int8(0x1);
static _DELPHI_CONST System::Int8 GS1_MODE = System::Int8(0x2);
static _DELPHI_CONST System::Int8 ESCAPE_MODE = System::Int8(0x8);
static _DELPHI_CONST System::Int8 GS1PARENS_MODE = System::Int8(0x10);
static _DELPHI_CONST System::Int8 GS1NOCHECK_MODE = System::Int8(0x20);
static _DELPHI_CONST System::Int8 HEIGHTPERROW_MODE = System::Int8(0x40);
static _DELPHI_CONST System::Byte FAST_MODE = System::Byte(0x80);
static _DELPHI_CONST System::Word EXTRA_ESCAPE_MODE = System::Word(0x100);
static _DELPHI_CONST System::Int8 DM_SQUARE = System::Int8(0x64);
static _DELPHI_CONST System::Int8 DM_DMRE = System::Int8(0x65);
static _DELPHI_CONST System::Byte DM_ISO_144 = System::Byte(0x80);
static _DELPHI_CONST System::Byte ZINT_FULL_MULTIBYTE = System::Byte(0xc8);
static _DELPHI_CONST System::Byte ULTRA_COMPRESSION = System::Byte(0x80);
static _DELPHI_CONST System::Int8 ZINT_WARN_HRT_TRUNCATED = System::Int8(0x1);
static _DELPHI_CONST System::Int8 ZINT_WARN_INVALID_OPTION = System::Int8(0x2);
static _DELPHI_CONST System::Int8 ZINT_WARN_USES_ECI = System::Int8(0x3);
static _DELPHI_CONST System::Int8 ZINT_WARN_NONCOMPLIANT = System::Int8(0x4);
static _DELPHI_CONST System::Int8 ZINT_ERROR = System::Int8(0x5);
static _DELPHI_CONST System::Int8 ZINT_ERROR_TOO_LONG = System::Int8(0x5);
static _DELPHI_CONST System::Int8 ZINT_ERROR_INVALID_DATA = System::Int8(0x6);
static _DELPHI_CONST System::Int8 ZINT_ERROR_INVALID_CHECK = System::Int8(0x7);
static _DELPHI_CONST System::Int8 ZINT_ERROR_INVALID_OPTION = System::Int8(0x8);
static _DELPHI_CONST System::Int8 ZINT_ERROR_ENCODING_PROBLEM = System::Int8(0x9);
static _DELPHI_CONST System::Int8 ZINT_ERROR_FILE_ACCESS = System::Int8(0xa);
static _DELPHI_CONST System::Int8 ZINT_ERROR_MEMORY = System::Int8(0xb);
static _DELPHI_CONST System::Int8 ZINT_ERROR_FILE_WRITE = System::Int8(0xc);
static _DELPHI_CONST System::Int8 ZINT_ERROR_USES_ECI = System::Int8(0xd);
static _DELPHI_CONST System::Int8 ZINT_ERROR_NONCOMPLIANT = System::Int8(0xe);
static _DELPHI_CONST System::Int8 ZINT_ERROR_HRT_TRUNCATED = System::Int8(0xf);
static _DELPHI_CONST System::Int8 WARN_DEFAULT = System::Int8(0x0);
static _DELPHI_CONST System::Int8 WARN_FAIL_ALL = System::Int8(0x2);
static _DELPHI_CONST System::Int8 ZINT_CAP_HRT = System::Int8(0x1);
static _DELPHI_CONST System::Int8 ZINT_CAP_STACKABLE = System::Int8(0x2);
static _DELPHI_CONST System::Int8 ZINT_CAP_EANUPC = System::Int8(0x4);
static _DELPHI_CONST System::Int8 ZINT_CAP_EXTENDABLE = System::Int8(0x4);
static _DELPHI_CONST System::Int8 ZINT_CAP_COMPOSITE = System::Int8(0x8);
static _DELPHI_CONST System::Int8 ZINT_CAP_ECI = System::Int8(0x10);
static _DELPHI_CONST System::Int8 ZINT_CAP_GS1 = System::Int8(0x20);
static _DELPHI_CONST System::Int8 ZINT_CAP_DOTTY = System::Int8(0x40);
static _DELPHI_CONST System::Byte ZINT_CAP_QUIET_ZONES = System::Byte(0x80);
static _DELPHI_CONST System::Word ZINT_CAP_FIXED_RATIO = System::Word(0x100);
static _DELPHI_CONST System::Word ZINT_CAP_READER_INIT = System::Word(0x200);
static _DELPHI_CONST System::Word ZINT_CAP_FULL_MULTIBYTE = System::Word(0x400);
static _DELPHI_CONST System::Word ZINT_CAP_MASK = System::Word(0x800);
static _DELPHI_CONST System::Word ZINT_CAP_STRUCTAPP = System::Word(0x1000);
static _DELPHI_CONST System::Word ZINT_CAP_COMPLIANT_HEIGHT = System::Word(0x2000);
static _DELPHI_CONST System::Word ZINT_CAP_BINDABLE = System::Word(0x4000);
static _DELPHI_CONST System::Word ZINT_MAX_DATA_LEN = System::Word(0x43f8);
static _DELPHI_CONST System::Word ZINT_MAX_SEG_COUNT = System::Word(0x100);
static _DELPHI_CONST System::Int8 ZINT_DEBUG_PRINT = System::Int8(0x1);
static _DELPHI_CONST System::Int8 ZINT_DEBUG_TEST = System::Int8(0x2);
}	/* namespace Zint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ZINT)
using namespace Zint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZintHPP
