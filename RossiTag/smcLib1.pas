
{$WARNINGS OFF}

{*********************************************************}
{*                  LBCIPHER.PAS 1.03                    *}
{*     Copyright (c) 1997-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{...$I LOCKBOX.INC} // invece includo esplicitamente !
{*********************************************************}
{*                  LOCKBOX.INC 1.03                     *}
{*      Copyright (c) 1997 TurboPower Software Co        *}
{*                 All rights reserved.                  *}
{*********************************************************}

{Conditional defines that affect compilation}

{General define indicating use under C++ Builder}
{$IFDEF VER93}
  {$DEFINE CBuilder}
{$ENDIF}

{$IFDEF CBuilder)
  {$A+} {Word Align Data}
{$ELSE}
  {$IFDEF Win32}
    {$A+} {Word Align Data}
  {$ELSE}
    {$A-} {Byte Align Data}
  {$ENDIF}
{$ENDIF}

{$Q-} {Overflow Checking}
{$R-} {Range-Checking}
{$S-} {Stack-Overflow Checking}
{$V-} {Var-String Checking}

{$IFNDEF Win32}
  {$F-} {Force Far Calls}
  {$K-} {Smart Callbacks}
{$ENDIF}

// fine mio include esplicito di TP .inc sopra
//********************************************

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit smcLib1;
  {-block and stream encryption/decryption routines}

interface

const
  {largest structure that can be created}
  {$IFDEF Win32}
  MaxStructSize = 1024 * 2000000; {2G}
  {$ELSE}
  MaxStructSize = 1024 * 64 - 1;  {64K}
  {$ENDIF}

type
  PByte         = ^Byte;
  PByteArray    = ^TByteArray;
  TByteArray    = array [0..MaxStructSize div SizeOf(Byte) - 1] of Byte;
  PLongInt      = ^LongInt;
  PLongIntArray = ^TLongIntArray;
  TLongIntArray = array [0..MaxStructSize div SizeOf(LongInt) - 1] of LongInt;

type
  TLongIntRec = packed record
    case Byte of
      1: (Lo: Word;
          Hi: Word);
      2: (LoLo: Byte;
          LoHi: Byte;
          HiLo: Byte;
          HiHi: Byte);
  end;

  TInt64 = packed record
    case Byte of
      0: (Lo: LongInt;
          Hi: LongInt);
      1: (LoLo: Word;
          LoHi: Word;
          HiLo: Word;
          HiHi: Word);
      2: (LoLoLo: Byte;
          LoLoHi: Byte;
          LoHiLo: Byte;
          LoHiHi: Byte;
          HiLoLo: Byte;
          HiLoHi: Byte;
          HiHiLo: Byte;
          HiHiHi: Byte);
  end;

const
  BFRounds = 16; {16 blowfish rounds}

type
  {encryption key types}
  TKey64        = array [0..7] of Byte;
  TKey128       = array [0..15] of Byte;

  {block cipher context types}
  TBFContext = packed record
    PBox    : array[0..(BFRounds+1)] of LongInt;
    SBox    : array[0..3, 0..255] of LongInt;
  end;

  TDESContext = packed record
    TransformedKey : array [0..31] of LongInt;
    Encrypt        : Boolean;
  end;

  TLBCContext = packed record
    Encrypt : Boolean;
    Dummy   : array[0..2] of Byte; {filler}
    Rounds  : LongInt;
    case Byte of
      0: (SubKeys64   : array [0..15] of TKey64);
      1: (SubKeysInts : array [0..3, 0..7] of LongInt);
  end;

  TTripleDESContext = array [0..1] of TDESContext;
  TLMDContext       = array [0..279] of Byte;
  TMD5Context       = array [0..87] of Byte;
  TMD5Digest        = array [0..15] of Byte;

  {stream cipher context types}
  TLSCContext = packed record
    Index       : LongInt;
    Accumulator : LongInt;
    SBox        : array [0..255] of Byte;
  end;

  TRNG32Context = array [0..3] of Byte;

  TRNG64Context = array [0..7] of Byte;

type
  {specific encryption block types}
  PLBCBlock  = ^TLBCBlock;                 {LockBox block cipher block pointer}
  TLBCBlock  = array[0..3] of LongInt;     {LockBox block cipher block type}
  TDESBlock  = array[0..7] of Byte;        {DES block type}
  TLQCBlock  = array[0..1] of LongInt;     {LockBox Quick Cipher block type}
  TBFBlock   = array[0..1] of LongInt;     {BlowFish block type}

{block and stream cipher routines}
procedure EncryptBF(const Context : TBFContext; var Block : TBFBlock; Encrypt : Boolean); export;
procedure EncryptBFCBC(const Context : TBFContext; const Prev : TBFBlock; var Block : TBFBlock; Encrypt : Boolean); export;
procedure EncryptDES(const Context : TDESContext;  var Block : TDESBlock); export;
procedure EncryptDESCBC(const Context : TDESContext;  const Prev : TDESBlock;  var Block : TDESBlock); export;
procedure EncryptLBC(const Context : TLBCContext; var Block : TLBCBlock); export;
procedure EncryptLBCCBC(const Context : TLBCContext; const Prev : TLBCBlock; var Block : TLBCBlock); export;
procedure EncryptLQC(const Key : TKey128; var Block : TLQCBlock; Encrypt : Boolean); export;
procedure EncryptLQCCBC(const Key : TKey128; const Prev : TLQCBlock; var Block : TLQCBlock; Encrypt : Boolean); export;
procedure EncryptLSC(var Context : TLSCContext; var Buf; BufSize : LongInt); export;
procedure EncryptRNG32(var Context : TRNG32Context; var Buf; BufSize : LongInt); export;
procedure EncryptRNG64(var Context : TRNG64Context; var Buf; BufSize : LongInt); export;
procedure EncryptTripleDES(const Context : TTripleDESContext;  var Block : TDESBlock); export;
procedure EncryptTripleDESCBC(const Context : TTripleDESContext;  const Prev : TDESBlock; var Block : TDESBlock); export;
procedure InitEncryptBF(Key : TKey128; var Context : TBFContext); export;
procedure InitEncryptDES(const Key : TKey64; var Context : TDESContext;  Encrypt : Boolean); export;
procedure InitEncryptLBC(const Key : TKey128; var Context : TLBCContext; Rounds : LongInt; Encrypt : Boolean); export;
procedure InitEncryptLSC(const Key; KeySize : Integer; var Context : TLSCContext); export;
procedure InitEncryptRNG32(Key : LongInt; var Context : TRNG32Context); export;
procedure InitEncryptRNG64(KeyHi, KeyLo : LongInt; var Context : TRNG64Context); export;
procedure InitEncryptTripleDES(const Key : TKey128;  var Context : TTripleDESContext; Encrypt : Boolean); export;

{message digest and hash routines}
procedure HashElf(var Digest : LongInt; const Buf;  BufSize : LongInt); export;
procedure HashLMD(var Digest; DigestSize : LongInt; const Buf; BufSize : LongInt); export;
procedure HashMD5(var Digest : TMD5Digest; const Buf;  BufSize : LongInt); export;
procedure HashMix128(var Digest : LongInt; const Buf;  BufSize : LongInt); export;
procedure FinalizeLMD(var Context : TLMDContext; var Digest; DigestSize : LongInt); export;
procedure FinalizeMD5(var Context : TMD5Context; var Digest : TMD5Digest); export;
procedure InitLMD(var Context : TLMDContext); export;
procedure InitMD5(var Context : TMD5Context); export;
procedure StringHashElf(var Digest : LongInt; const Str : string); export;
procedure StringHashLMD(var Digest; DigestSize : LongInt; const Str : string); export;
procedure StringHashMD5(var Digest : TMD5Digest; const Str : string); export;
procedure StringHashMix128(var Digest : LongInt; const Str : string); export;
procedure UpdateLMD(var Context : TLMDContext; const Buf; BufSize : LongInt); export;
procedure UpdateMD5(var Context : TMD5Context;  const Buf;  BufSize : LongInt); export;

{utility routines}
procedure GenerateLMDKey(var Key; KeySize : Integer; const Str : string); export;
  {-generate key from Str using LMD}
procedure GenerateMD5Key(var Key : TKey128; const Str : string); export;
  {-generate key from Str using MD5}
procedure GenerateRandomKey(var Key; KeySize : Integer); export;
  {-generate key from Str using Randomize and Random()}
function Min(A, B : LongInt) : LongInt; export;
  {-returns smaller of A or B}
function Max(A, B : LongInt) : LongInt; export;
  {-returns larger of A or B}
function Ran01(var Seed : LongInt) : LongInt; export;
  {-returns a random longint}
function Ran02(var Seed : LongInt) : LongInt; export;
  {-returns a random longint}
function Ran03(var Seed : LongInt) : LongInt; export;
  {-returns a random longint}
function Random32Byte(var Seed : LongInt) : Byte; export;
  {-returns a random byte}
function Random64Byte(var Seed : TInt64) : Byte; export;
  {-returns a random byte}
procedure ShrinkDESKey(var Key : TKey64); export;
  {-reduces the effective key size from 64 to 40 bits (usage: DES routines)}
procedure XorMem(var Mem1;  const Mem2;  Count : Cardinal); export;
  {-xor's Count bytes of Mem1 with Mem2}


implementation


{first 2048 bits of Pi in hexadecimal, low to high, without the leading "3"}
const
  Pi2048: array [0..255] of Byte = (
    $24, $3F, $6A, $88, $85, $A3, $08, $D3, $13, $19, $8A, $2E, $03, $70, $73, $44,
    $A4, $09, $38, $22, $29, $9F, $31, $D0, $08, $2E, $FA, $98, $EC, $4E, $6C, $89,
    $45, $28, $21, $E6, $38, $D0, $13, $77, $BE, $54, $66, $CF, $34, $E9, $0C, $6C,
    $C0, $AC, $29, $B7, $C9, $7C, $50, $DD, $3F, $84, $D5, $B5, $B5, $47, $09, $17,
    $92, $16, $D5, $D9, $89, $79, $FB, $1B, $D1, $31, $0B, $A6, $98, $DF, $B5, $AC,
    $2F, $FD, $72, $DB, $D0, $1A, $DF, $B7, $B8, $E1, $AF, $ED, $6A, $26, $7E, $96,
    $BA, $7C, $90, $45, $F1, $2C, $7F, $99, $24, $A1, $99, $47, $B3, $91, $6C, $F7,
    $08, $01, $F2, $E2, $85, $8E, $FC, $16, $63, $69, $20, $D8, $71, $57, $4E, $69,
    $A4, $58, $FE, $A3, $F4, $93, $3D, $7E, $0D, $95, $74, $8F, $72, $8E, $B6, $58,
    $71, $8B, $CD, $58, $82, $15, $4A, $EE, $7B, $54, $A4, $1D, $C2, $5A, $59, $B5,
    $9C, $30, $D5, $39, $2A, $F2, $60, $13, $C5, $D1, $B0, $23, $28, $60, $85, $F0,
    $CA, $41, $79, $18, $B8, $DB, $38, $EF, $8E, $79, $DC, $B0, $60, $3A, $18, $0E,
    $6C, $9E, $0E, $8B, $B0, $1E, $8A, $3E, $D7, $15, $77, $C1, $BD, $31, $4B, $27,
    $78, $AF, $2F, $DA, $55, $60, $5C, $60, $E6, $55, $25, $F3, $AA, $55, $AB, $94,
    $57, $48, $98, $62, $63, $E8, $14, $40, $55, $CA, $39, $6A, $2A, $AB, $10, $B6,
    $B4, $CC, $5C, $34, $11, $41, $E8, $CE, $A1, $54, $86, $AF, $7C, $72, $E9, $93);

type
  TMD5ContextEx = packed record
    Count : array [0..1] of LongInt;  {number of bits handled mod 2^64}
    State : array [0..3] of LongInt;  {scratch buffer}
    Buf   : array [0..63] of Byte;    {input buffer}
  end;

  TLMDContextEx = packed record
    DigestIndex : LongInt;
    Digest      : array [0..255] of Byte;
    KeyIndex    : LongInt;
    case Byte of
      0: (KeyInts : array [0..3] of LongInt);
      1: (Key     : TKey128);
  end;
  TBlock2048 = array [0..255] of Byte;

type
  {bit mixing types}
  T128Bit     = array [0..3] of LongInt;
  T256Bit     = array [0..7] of LongInt;

const
  BCSalts: array [0..3] of LongInt =
    ($55555555, $AAAAAAAA, $33333333, $CCCCCCCC);

type
  TBCHalfBlock = array [0..1] of LongInt;

  TBFBlockEx = packed record
    Xl : array[0..3] of Byte;
    Xr : array[0..3] of Byte;
  end;

const
 bf_P: array[0..(BFRounds + 1)] of LongInt = (
  $243F6A88, $85A308D3, $13198A2E, $03707344,
  $A4093822, $299F31D0, $082EFA98, $EC4E6C89,
  $452821E6, $38D01377, $BE5466CF, $34E90C6C,
  $C0AC29B7, $C97C50DD, $3F84D5B5, $B5470917,
  $9216D5D9, $8979FB1B);

{Initial Random SubKey boxes, set to Pi}
 bf_S: array[0..3, 0..255] of LongInt =
(
( $D1310BA6, $98DFB5AC, $2FFD72DB, $D01ADFB7,
  $B8E1AFED, $6A267E96, $BA7C9045, $F12C7F99,
  $24A19947, $B3916CF7, $0801F2E2, $858EFC16,
  $636920D8, $71574E69, $A458FEA3, $F4933D7E,

  $0D95748F, $728EB658, $718BCD58, $82154AEE,
  $7B54A41D, $C25A59B5, $9C30D539, $2AF26013,
  $C5D1B023, $286085F0, $CA417918, $B8DB38EF,
  $8E79DCB0, $603A180E, $6C9E0E8B, $B01E8A3E,

  $D71577C1, $BD314B27, $78AF2FDA, $55605C60,
  $E65525F3, $AA55AB94, $57489862, $63E81440,
  $55CA396A, $2AAB10B6, $B4CC5C34, $1141E8CE,
  $A15486AF, $7C72E993, $B3EE1411, $636FBC2A,

  $2BA9C55D, $741831F6, $CE5C3E16, $9B87931E,
  $AFD6BA33, $6C24CF5C, $7A325381, $28958677,
  $3B8F4898, $6B4BB9AF, $C4BFE81B, $66282193,
  $61D809CC, $FB21A991, $487CAC60, $5DEC8032,

  $EF845D5D, $E98575B1, $DC262302, $EB651B88,
  $23893E81, $D396ACC5, $0F6D6FF3, $83F44239,
  $2E0B4482, $A4842004, $69C8F04A, $9E1F9B5E,
  $21C66842, $F6E96C9A, $670C9C61, $ABD388F0,

  $6A51A0D2, $D8542F68, $960FA728, $AB5133A3,
  $6EEF0B6C, $137A3BE4, $BA3BF050, $7EFB2A98,
  $A1F1651D, $39AF0176, $66CA593E, $82430E88,
  $8CEE8619, $456F9FB4, $7D84A5C3, $3B8B5EBE,

  $E06F75D8, $85C12073, $401A449F, $56C16AA6,
  $4ED3AA62, $363F7706, $1BFEDF72, $429B023D,
  $37D0D724, $D00A1248, $DB0FEAD3, $49F1C09B,
  $075372C9, $80991B7B, $25D479D8, $F6E8DEF7,

  $E3FE501A, $B6794C3B, $976CE0BD, $04C006BA,
  $C1A94FB6, $409F60C4, $5E5C9EC2, $196A2463,
  $68FB6FAF, $3E6C53B5, $1339B2EB, $3B52EC6F,
  $6DFC511F, $9B30952C, $CC814544, $AF5EBD09,

  $BEE3D004, $DE334AFD, $660F2807, $192E4BB3,
  $C0CBA857, $45C8740F, $D20B5F39, $B9D3FBDB,
  $5579C0BD, $1A60320A, $D6A100C6, $402C7279,
  $679F25FE, $FB1FA3CC, $8EA5E9F8, $DB3222F8,

  $3C7516DF, $FD616B15, $2F501EC8, $AD0552AB,
  $323DB5FA, $FD238760, $53317B48, $3E00DF82,
  $9E5C57BB, $CA6F8CA0, $1A87562E, $DF1769DB,
  $D542A8F6, $287EFFC3, $AC6732C6, $8C4F5573,

  $695B27B0, $BBCA58C8, $E1FFA35D, $B8F011A0,
  $10FA3D98, $FD2183B8, $4AFCB56C, $2DD1D35B,
  $9A53E479, $B6F84565, $D28E49BC, $4BFB9790,
  $E1DDF2DA, $A4CB7E33, $62FB1341, $CEE4C6E8,

  $EF20CADA, $36774C01, $D07E9EFE, $2BF11FB4,
  $95DBDA4D, $AE909198, $EAAD8E71, $6B93D5A0,
  $D08ED1D0, $AFC725E0, $8E3C5B2F, $8E7594B7,
  $8FF6E2FB, $F2122B64, $8888B812, $900DF01C,

  $4FAD5EA0, $688FC31C, $D1CFF191, $B3A8C1AD,
  $2F2F2218, $BE0E1777, $EA752DFE, $8B021FA1,
  $E5A0CC0F, $B56F74E8, $18ACF3D6, $CE89E299,
  $B4A84FE0, $FD13E0B7, $7CC43B81, $D2ADA8D9,

  $165FA266, $80957705, $93CC7314, $211A1477,
  $E6AD2065, $77B5FA86, $C75442F5, $FB9D35CF,
  $EBCDAF0C, $7B3E89A0, $D6411BD3, $AE1E7E49,
  $00250E2D, $2071B35E, $226800BB, $57B8E0AF,

  $2464369B, $F009B91E, $5563911D, $59DFA6AA,
  $78C14389, $D95A537F, $207D5BA2, $02E5B9C5,
  $83260376, $6295CFA9, $11C81968, $4E734A41,
  $B3472DCA, $7B14A94A, $1B510052, $9A532915,

  $D60F573F, $BC9BC6E4, $2B60A476, $81E67400,
  $08BA6FB5, $571BE91F, $F296EC6B, $2A0DD915,
  $B6636521, $E7B9F9B6, $FF34052E, $C5855664,
  $53B02D5D, $A99F8FA1, $08BA4799, $6E85076A),
  {SECOND 256}
 ($4B7A70E9, $B5B32944, $DB75092E, $C4192623,
  $AD6EA6B0, $49A7DF7D, $9CEE60B8, $8FEDB266,
  $ECAA8C71, $699A17FF, $5664526C, $C2B19EE1,
  $193602A5, $75094C29, $A0591340, $E4183A3E,

  $3F54989A, $5B429D65, $6B8FE4D6, $99F73FD6,
  $A1D29C07, $EFE830F5, $4D2D38E6, $F0255DC1,
  $4CDD2086, $8470EB26, $6382E9C6, $021ECC5E,
  $09686B3F, $3EBAEFC9, $3C971814, $6B6A70A1,

  $687F3584, $52A0E286, $B79C5305, $AA500737,
  $3E07841C, $7FDEAE5C, $8E7D44EC, $5716F2B8,
  $B03ADA37, $F0500C0D, $F01C1F04, $0200B3FF,
  $AE0CF51A, $3CB574B2, $25837A58, $DC0921BD,

  $D19113F9, $7CA92FF6, $94324773, $22F54701,
  $3AE5E581, $37C2DADC, $C8B57634, $9AF3DDA7,
  $A9446146, $0FD0030E, $ECC8C73E, $A4751E41,
  $E238CD99, $3BEA0E2F, $3280BBA1, $183EB331,

  $4E548B38, $4F6DB908, $6F420D03, $F60A04BF,
  $2CB81290, $24977C79, $5679B072, $BCAF89AF,
  $DE9A771F, $D9930810, $B38BAE12, $DCCF3F2E,
  $5512721F, $2E6B7124, $501ADDE6, $9F84CD87,

  $7A584718, $7408DA17, $BC9F9ABC, $E94B7D8C,
  $EC7AEC3A, $DB851DFA, $63094366, $C464C3D2,
  $EF1C1847, $3215D908, $DD433B37, $24C2BA16,
  $12A14D43, $2A65C451, $50940002, $133AE4DD,

  $71DFF89E, $10314E55, $81AC77D6, $5F11199B,
  $043556F1, $D7A3C76B, $3C11183B, $5924A509,
  $F28FE6ED, $97F1FBFA, $9EBABF2C, $1E153C6E,
  $86E34570, $EAE96FB1, $860E5E0A, $5A3E2AB3,

  $771FE71C, $4E3D06FA, $2965DCB9, $99E71D0F,
  $803E89D6, $5266C825, $2E4CC978, $9C10B36A,
  $C6150EBA, $94E2EA78, $A5FC3C53, $1E0A2DF4,
  $F2F74EA7, $361D2B3D, $1939260F, $19C27960,

  $5223A708, $F71312B6, $EBADFE6E, $EAC31F66,
  $E3BC4595, $A67BC883, $B17F37D1, $018CFF28,
  $C332DDEF, $BE6C5AA5, $65582185, $68AB9802,
  $EECEA50F, $DB2F953B, $2AEF7DAD, $5B6E2F84,

  $1521B628, $29076170, $ECDD4775, $619F1510,
  $13CCA830, $EB61BD96, $0334FE1E, $AA0363CF,
  $B5735C90, $4C70A239, $D59E9E0B, $CBAADE14,
  $EECC86BC, $60622CA7, $9CAB5CAB, $B2F3846E,

  $648B1EAF, $19BDF0CA, $A02369B9, $655ABB50,
  $40685A32, $3C2AB4B3, $319EE9D5, $C021B8F7,
  $9B540B19, $875FA099, $95F7997E, $623D7DA8,
  $F837889A, $97E32D77, $11ED935F, $16681281,

  $0E358829, $C7E61FD6, $96DEDFA1, $7858BA99,
  $57F584A5, $1B227263, $9B83C3FF, $1AC24696,
  $CDB30AEB, $532E3054, $8FD948E4, $6DBC3128,
  $58EBF2EF, $34C6FFEA, $FE28ED61, $EE7C3C73,

  $5D4A14D9, $E864B7E3, $42105D14, $203E13E0,
  $45EEE2B6, $A3AAABEA, $DB6C4F15, $FACB4FD0,
  $C742F442, $EF6ABBB5, $654F3B1D, $41CD2105,
  $D81E799E, $86854DC7, $E44B476A, $3D816250,

  $CF62A1F2, $5B8D2646, $FC8883A0, $C1C7B6A3,
  $7F1524C3, $69CB7492, $47848A0B, $5692B285,
  $095BBF00, $AD19489D, $1462B174, $23820E00,
  $58428D2A, $0C55F5EA, $1DADF43E, $233F7061,

  $3372F092, $8D937E41, $D65FECF1, $6C223BDB,
  $7CDE3759, $CBEE7460, $4085F2A7, $CE77326E,
  $A6078084, $19F8509E, $E8EFD855, $61D99735,
  $A969A7AA, $C50C06C2, $5A04ABFC, $800BCADC,

  $9E447A2E, $C3453484, $FDD56705, $0E1E9EC9,
  $DB73DBD3, $105588CD, $675FDA79, $E3674340,
  $C5C43465, $713E38D8, $3D28F89E, $F16DFF20,
  $153E21E7, $8FB03D4A, $E6E39F2B, $DB83ADF7),
  {THIRD 256}
 ($E93D5A68, $948140F7, $F64C261C, $94692934,
  $411520F7, $7602D4F7, $BCF46B2E, $D4A20068,
  $D4082471, $3320F46A, $43B7D4B7, $500061AF,
  $1E39F62E, $97244546, $14214F74, $BF8B8840,

  $4D95FC1D, $96B591AF, $70F4DDD3, $66A02F45,
  $BFBC09EC, $03BD9785, $7FAC6DD0, $31CB8504,
  $96EB27B3, $55FD3941, $DA2547E6, $ABCA0A9A,
  $28507825, $530429F4, $0A2C86DA, $E9B66DFB,

  $68DC1462, $D7486900, $680EC0A4, $27A18DEE,
  $4F3FFEA2, $E887AD8C, $B58CE006, $7AF4D6B6,
  $AACE1E7C, $D3375FEC, $CE78A399, $406B2A42,
  $20FE9E35, $D9F385B9, $EE39D7AB, $3B124E8B,

  $1DC9FAF7, $4B6D1856, $26A36631, $EAE397B2,
  $3A6EFA74, $DD5B4332, $6841E7F7, $CA7820FB,
  $FB0AF54E, $D8FEB397, $454056AC, $BA489527,
  $55533A3A, $20838D87, $FE6BA9B7, $D096954B,

  $55A867BC, $A1159A58, $CCA92963, $99E1DB33,
  $A62A4A56, $3F3125F9, $5EF47E1C, $9029317C,
  $FDF8E802, $04272F70, $80BB155C, $05282CE3,
  $95C11548, $E4C66D22, $48C1133F, $C70F86DC,

  $07F9C9EE, $41041F0F, $404779A4, $5D886E17,
  $325F51EB, $D59BC0D1, $F2BCC18F, $41113564,
  $257B7834, $602A9C60, $DFF8E8A3, $1F636C1B,
  $0E12B4C2, $02E1329E, $AF664FD1, $CAD18115,

  $6B2395E0, $333E92E1, $3B240B62, $EEBEB922,
  $85B2A20E, $E6BA0D99, $DE720C8C, $2DA2F728,
  $D0127845, $95B794FD, $647D0862, $E7CCF5F0,
  $5449A36F, $877D48FA, $C39DFD27, $F33E8D1E,

  $0A476341, $992EFF74, $3A6F6EAB, $F4F8FD37,
  $A812DC60, $A1EBDDF8, $991BE14C, $DB6E6B0D,
  $C67B5510, $6D672C37, $2765D43B, $DCD0E804,
  $F1290DC7, $CC00FFA3, $B5390F92, $690FED0B,

  $667B9FFB, $CEDB7D9C, $A091CF0B, $D9155EA3,
  $BB132F88, $515BAD24, $7B9479BF, $763BD6EB,
  $37392EB3, $CC115979, $8026E297, $F42E312D,
  $6842ADA7, $C66A2B3B, $12754CCC, $782EF11C,

  $6A124237, $B79251E7, $06A1BBE6, $4BFB6350,
  $1A6B1018, $11CAEDFA, $3D25BDD8, $E2E1C3C9,
  $44421659, $0A121386, $D90CEC6E, $D5ABEA2A,
  $64AF674E, $DA86A85F, $BEBFE988, $64E4C3FE,

  $9DBC8057, $F0F7C086, $60787BF8, $6003604D,
  $D1FD8346, $F6381FB0, $7745AE04, $D736FCCC,
  $83426B33, $F01EAB71, $B0804187, $3C005E5F,
  $77A057BE, $BDE8AE24, $55464299, $BF582E61,

  $4E58F48F, $F2DDFDA2, $F474EF38, $8789BDC2,
  $5366F9C3, $C8B38E74, $B475F255, $46FCD9B9,
  $7AEB2661, $8B1DDF84, $846A0E79, $915F95E2,
  $466E598E, $20B45770, $8CD55591, $C902DE4C,

  $B90BACE1, $BB8205D0, $11A86248, $7574A99E,
  $B77F19B6, $E0A9DC09, $662D09A1, $C4324633,
  $E85A1F02, $09F0BE8C, $4A99A025, $1D6EFE10,
  $1AB93D1D, $0BA5A4DF, $A186F20F, $2868F169,

  $DCB7DA83, $573906FE, $A1E2CE9B, $4FCD7F52,
  $50115E01, $A70683FA, $A002B5C4, $0DE6D027,
  $9AF88C27, $773F8641, $C3604C06, $61A806B5,
  $F0177A28, $C0F586E0, $006058AA, $30DC7D62,

  $11E69ED7, $2338EA63, $53C2DD94, $C2C21634,
  $BBCBEE56, $90BCB6DE, $EBFC7DA1, $CE591D76,
  $6F05E409, $4B7C0188, $39720A3D, $7C927C24,
  $86E3725F, $724D9DB9, $1AC15BB4, $D39EB8FC,

  $ED545578, $08FCA5B5, $D83D7CD3, $4DAD0FC4,
  $1E50EF5E, $B161E6F8, $A28514D9, $6C51133C,
  $6FD5C7E7, $56E14EC4, $362ABFCE, $DDC6C837,
  $D79A3234, $92638212, $670EFA8E, $406000E0),
  {FOURTH 256}
 ($3A39CE37, $D3FAF5CF, $ABC27737, $5AC52D1B,
  $5CB0679E, $4FA33742, $D3822740, $99BC9BBE,
  $D5118E9D, $BF0F7315, $D62D1C7E, $C700C47B,
  $B78C1B6B, $21A19045, $B26EB1BE, $6A366EB4,

  $5748AB2F, $BC946E79, $C6A376D2, $6549C2C8,
  $530FF8EE, $468DDE7D, $D5730A1D, $4CD04DC6,
  $2939BBDB, $A9BA4650, $AC9526E8, $BE5EE304,
  $A1FAD5F0, $6A2D519A, $63EF8CE2, $9A86EE22,

  $C089C2B8, $43242EF6, $A51E03AA, $9CF2D0A4,
  $83C061BA, $9BE96A4D, $8FE51550, $BA645BD6,
  $2826A2F9, $A73A3AE1, $4BA99586, $EF5562E9,
  $C72FEFD3, $F752F7DA, $3F046F69, $77FA0A59,

  $80E4A915, $87B08601, $9B09E6AD, $3B3EE593,
  $E990FD5A, $9E34D797, $2CF0B7D9, $022B8B51,
  $96D5AC3A, $017DA67D, $D1CF3ED6, $7C7D2D28,
  $1F9F25CF, $ADF2B89B, $5AD6B472, $5A88F54C,

  $E029AC71, $E019A5E6, $47B0ACFD, $ED93FA9B,
  $E8D3C48D, $283B57CC, $F8D56629, $79132E28,
  $785F0191, $ED756055, $F7960E44, $E3D35E8C,
  $15056DD4, $88F46DBA, $03A16125, $0564F0BD,

  $C3EB9E15, $3C9057A2, $97271AEC, $A93A072A,
  $1B3F6D9B, $1E6321F5, $F59C66FB, $26DCF319,
  $7533D928, $B155FDF5, $03563482, $8ABA3CBB,
  $28517711, $C20AD9F8, $ABCC5167, $CCAD925F,

  $4DE81751, $3830DC8E, $379D5862, $9320F991,
  $EA7A90C2, $FB3E7BCE, $5121CE64, $774FBE32,
  $A8B6E37E, $C3293D46, $48DE5369, $6413E680,
  $A2AE0810, $DD6DB224, $69852DFD, $09072166,

  $B39A460A, $6445C0DD, $586CDECF, $1C20C8AE,
  $5BBEF7DD, $1B588D40, $CCD2017F, $6BB4E3BB,
  $DDA26A7E, $3A59FF45, $3E350A44, $BCB4CDD5,
  $72EACEA8, $FA6484BB, $8D6612AE, $BF3C6F47,

  $D29BE463, $542F5D9E, $AEC2771B, $F64E6370,
  $740E0D8D, $E75B1357, $F8721671, $AF537D5D,
  $4040CB08, $4EB4E2CC, $34D2466A, $0115AF84,
  $E1B00428, $95983A1D, $06B89FB4, $CE6EA048,

  $6F3F3B82, $3520AB82, $011A1D4B, $277227F8,
  $611560B1, $E7933FDC, $BB3A792B, $344525BD,
  $A08839E1, $51CE794B, $2F32C9B7, $A01FBAC9,
  $E01CC87E, $BCC7D1F6, $CF0111C3, $A1E8AAC7,

  $1A908749, $D44FBD9A, $D0DADECB, $D50ADA38,
  $0339C32A, $C6913667, $8DF9317C, $E0B12B4F,
  $F79E59B7, $43F5BB3A, $F2D519FF, $27D9459C,
  $BF97222C, $15E6FC2A, $0F91FC71, $9B941525,

  $FAE59361, $CEB69CEB, $C2A86459, $12BAA8D1,
  $B6C1075E, $E3056A0C, $10D25065, $CB03A442,
  $E0EC6E0E, $1698DB3B, $4C98A0BE, $3278E964,
  $9F1F9532, $E0D392DF, $D3A0342B, $8971F21E,

  $1B0A7441, $4BA3348C, $C5BE7120, $C37632D8,
  $DF359F8D, $9B992F2E, $E60B6F47, $0FE3F11D,
  $E54CDA54, $1EDAD891, $CE6279CF, $CD3E7E6F,
  $1618B166, $FD2C1D05, $848FD2C5, $F6FB2299,

  $F523F357, $A6327623, $93A83531, $56CCCD02,
  $ACF08162, $5A75EBB5, $6E163697, $88D273CC,
  $DE966292, $81B949D0, $4C50901B, $71C65614,
  $E6C6C7BD, $327A140A, $45E1D006, $C3F27B9A,

  $C9AA53FD, $62A80F00, $BB25BFE2, $35BDD2F6,
  $71126905, $B2040222, $B6CBCF7C, $CD769C2B,
  $53113EC0, $1640E3D3, $38ABBD60, $2547ADF0,
  $BA38209C, $F746CE76, $77AFA1C5, $20756060,

  $85CBFE4E, $8AE88DD8, $7AAAF9B0, $4CF9AA7E,
  $1948C25C, $02FB8A8C, $01C36AE4, $D6EBE1F9,
  $90D4F869, $A65CDEA0, $3F09252D, $C208E69F,
  $B74E6132, $CE77E25B, $578FDFE3, $3AC372E6)
);{bf_S}

procedure EncryptLBC(const Context : TLBCContext; var Block : TLBCBlock);
var
  Blocks    : array [0..1] of TBCHalfBlock absolute Block;
  Work      : TBCHalfBlock;
  Right     : TBCHalfBlock;
  Left      : TBCHalfBlock;
  AA, BB    : LongInt;
  CC, DD    : LongInt;
  R, T      : LongInt;
begin
  Right := Blocks[0];
  Left := Blocks[1];

  for R := 0 to Context.Rounds - 1 do begin
    {transform the right side}
    AA := Right[0];
    BB := TBCHalfBlock(Context.SubKeys64[R])[0];
    CC := Right[1];
    DD := TBCHalfBlock(Context.SubKeys64[R])[1];

    {mix it once...}
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 7);
    BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 13);
    CC := CC + BB; BB := BB + CC; CC := CC xor (CC shr 17);
    DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 9);
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 3);
    BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 7);
    CC := CC + BB; BB := BB + CC; CC := CC xor (DD shr 15);
    DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 11);

    {swap sets...}
    T := AA; AA := CC; CC := T;
    T := BB; BB := DD; DD := T;

    {mix it twice}
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 7);
    BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 13);
    CC := CC + BB; BB := BB + CC; CC := CC xor (CC shr 17);
    DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 9);
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 3);
    BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 7);
    CC := CC + BB; BB := BB + CC; CC := CC xor (DD shr 15);
    DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 11);

    Work[0] := Left[0] xor AA xor BB;
    Work[1] := Left[1] xor CC xor DD;

    Left := Right;
    Right := Work;
  end;

  Blocks[0] := Left;
  Blocks[1] := Right;
end;

procedure EncryptLBCCBC(const Context : TLBCContext; const Prev : TLBCBlock; var Block : TLBCBlock);
begin
  if Context.Encrypt then begin
    XorMem(Block, Prev, SizeOf(Block));
    EncryptLBC(Context, Block);
  end else begin
    EncryptLBC(Context, Block);
    XorMem(Block, Prev, SizeOf(Block));
  end;
end;

procedure InitEncryptDES(const Key : TKey64; var Context : TDESContext;  Encrypt : Boolean);
const
  PC1        : array [0..55] of Byte =
    (56, 48, 40, 32, 24, 16, 8, 0, 57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26,
     18, 10, 2, 59, 51, 43, 35, 62, 54, 46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21,
     13, 5, 60, 52, 44, 36, 28, 20, 12, 4, 27, 19, 11, 3);
  PC2        : array [0..47] of Byte =
    (13, 16, 10, 23, 0, 4, 2, 27, 14, 5, 20, 9, 22, 18, 11, 3, 25, 7,
     15, 6, 26, 19, 12, 1, 40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47,
     43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31);
  CTotRot    : array [0..15] of Byte = (1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28);
  CBitMask   : array [0..7] of Byte = (128, 64, 32, 16, 8, 4, 2, 1);
var
  PC1M       : array [0..55] of Byte;
  PC1R       : array [0..55] of Byte;
  KS         : array [0..7] of Byte;
  I, J, L, M : LongInt;
begin
  {convert PC1 to bits of key}
  for J := 0 to 55 do begin
    L := PC1[J];
    M := L mod 8;
    PC1M[J] := Ord((Key[L div 8] and CBitMask[M]) <> 0);
  end;

  {key chunk for each iteration}
  for I := 0 to 15 do begin
    {rotate PC1 the right amount}
    for J := 0 to 27 do begin
      L := J + CTotRot[I];
      if (L < 28) then begin
        PC1R[J] := PC1M[L];
        PC1R[J + 28] := PC1M[L + 28];
      end else begin
        PC1R[J] := PC1M[L - 28];
        PC1R[J + 28] := PC1M[L];
      end;
    end;

    {select bits individually}
    FillChar(KS, SizeOf(KS), 0);
    for J := 0 to 47 do
      if Boolean(PC1R[PC2[J]]) then begin
        L := J div 6;
        KS[L] := KS[L] or CBitMask[J mod 6] shr 2;
      end;

    {now convert to odd/even interleaved form for use in F}
    if Encrypt then begin
      Context.TransformedKey[I * 2] := (LongInt(KS[0]) shl 24) or (LongInt(KS[2]) shl 16) or
        (LongInt(KS[4]) shl 8) or (LongInt(KS[6]));
      Context.TransformedKey[I * 2 + 1] := (LongInt(KS[1]) shl 24) or (LongInt(KS[3]) shl 16) or
        (LongInt(KS[5]) shl 8) or (LongInt(KS[7]));
    end else begin
      Context.TransformedKey[31 - (I * 2 + 1)] := (LongInt(KS[0]) shl 24) or (LongInt(KS[2]) shl 16) or
        (LongInt(KS[4]) shl 8) or (LongInt(KS[6]));
      Context.TransformedKey[31 - (I * 2)] := (LongInt(KS[1]) shl 24) or (LongInt(KS[3]) shl 16) or
        (LongInt(KS[5]) shl 8) or (LongInt(KS[7]));
    end;
  end;

  Context.Encrypt := Encrypt;
end;

procedure InitEncryptLBC(const Key : TKey128; var Context : TLBCContext; Rounds: LongInt; Encrypt : Boolean);
type
  TSubKeys = packed record
    case Byte of
      0: (SubKeys64 : array [0..15] of TKey64);
      1: (SubKeysInts : array [0..3, 0..7] of LongInt);
  end;
var
  KeyArray  : TLongIntArray absolute Key;
  AA, BB    : LongInt;
  CC, DD    : LongInt;
  EE, FF    : LongInt;
  GG, HH    : LongInt;
  I, R      : LongInt;
  Temp      : TSubKeys;
begin
  Context.Encrypt := Encrypt;
  Context.Rounds := Max(4, Min(16, Rounds));

  {fill subkeys by propagating seed}
  for I := 0 to 3 do begin
    {interleave the key with the salt}
    AA := KeyArray[0]; BB := BCSalts[I];
    CC := KeyArray[1]; DD := BCSalts[I];
    EE := KeyArray[2]; FF := BCSalts[I];
    GG := KeyArray[3]; HH := BCSalts[I];

    {mix all the bits around for 8 rounds}
    {achieves avalanche and eliminates funnels}
    for R := 0 to 7 do begin
      AA := AA xor (BB shl 11); DD := DD + AA; BB := BB + CC;
      BB := BB xor (CC shr 2);  EE := EE + BB; CC := CC + DD;
      CC := CC xor (DD shl 8);  FF := FF + CC; DD := DD + EE;
      DD := DD xor (EE shr 16); GG := GG + DD; EE := EE + FF;
      EE := EE xor (FF shl 10); HH := HH + EE; FF := FF + GG;
      FF := FF xor (GG shr 4);  AA := AA + FF; GG := GG + HH;
      GG := GG xor (HH shl 8);  BB := BB + GG; HH := HH + AA;
      HH := HH xor (AA shr 9);  CC := CC + HH; AA := AA + BB;
    end;

    {assign value to subkey}
    Context.SubKeysInts[I, 0] := AA;
    Context.SubKeysInts[I, 1] := BB;
    Context.SubKeysInts[I, 2] := CC;
    Context.SubKeysInts[I, 3] := DD;
    Context.SubKeysInts[I, 4] := EE;
    Context.SubKeysInts[I, 5] := FF;
    Context.SubKeysInts[I, 6] := GG;
    Context.SubKeysInts[I, 7] := HH;
  end;

  {reverse subkeys if decrypting - easier for EncryptLBC routine}
  if not Encrypt then begin
    for I := 0 to Context.Rounds - 1 do
        Temp.SubKeys64[(Context.Rounds - 1) - I] := Context.SubKeys64[I];
    for I := 0 to Context.Rounds - 1 do
        Context.SubKeys64[I] := Temp.SubKeys64[I];
  end;
end;

procedure EncryptDES(const Context : TDESContext;  var Block : TDESBlock);
const
  SPBox : array [0..7, 0..63] of LongInt =
    (($01010400, $00000000, $00010000, $01010404, $01010004, $00010404, $00000004, $00010000,
      $00000400, $01010400, $01010404, $00000400, $01000404, $01010004, $01000000, $00000004,
      $00000404, $01000400, $01000400, $00010400, $00010400, $01010000, $01010000, $01000404,
      $00010004, $01000004, $01000004, $00010004, $00000000, $00000404, $00010404, $01000000,
      $00010000, $01010404, $00000004, $01010000, $01010400, $01000000, $01000000, $00000400,
      $01010004, $00010000, $00010400, $01000004, $00000400, $00000004, $01000404, $00010404,
      $01010404, $00010004, $01010000, $01000404, $01000004, $00000404, $00010404, $01010400,
      $00000404, $01000400, $01000400, $00000000, $00010004, $00010400, $00000000, $01010004),
     ($80108020, $80008000, $00008000, $00108020, $00100000, $00000020, $80100020, $80008020,
      $80000020, $80108020, $80108000, $80000000, $80008000, $00100000, $00000020, $80100020,
      $00108000, $00100020, $80008020, $00000000, $80000000, $00008000, $00108020, $80100000,
      $00100020, $80000020, $00000000, $00108000, $00008020, $80108000, $80100000, $00008020,
      $00000000, $00108020, $80100020, $00100000, $80008020, $80100000, $80108000, $00008000,
      $80100000, $80008000, $00000020, $80108020, $00108020, $00000020, $00008000, $80000000,
      $00008020, $80108000, $00100000, $80000020, $00100020, $80008020, $80000020, $00100020,
      $00108000, $00000000, $80008000, $00008020, $80000000, $80100020, $80108020, $00108000),
     ($00000208, $08020200, $00000000, $08020008, $08000200, $00000000, $00020208, $08000200,
      $00020008, $08000008, $08000008, $00020000, $08020208, $00020008, $08020000, $00000208,
      $08000000, $00000008, $08020200, $00000200, $00020200, $08020000, $08020008, $00020208,
      $08000208, $00020200, $00020000, $08000208, $00000008, $08020208, $00000200, $08000000,
      $08020200, $08000000, $00020008, $00000208, $00020000, $08020200, $08000200, $00000000,
      $00000200, $00020008, $08020208, $08000200, $08000008, $00000200, $00000000, $08020008,
      $08000208, $00020000, $08000000, $08020208, $00000008, $00020208, $00020200, $08000008,
      $08020000, $08000208, $00000208, $08020000, $00020208, $00000008, $08020008, $00020200),
     ($00802001, $00002081, $00002081, $00000080, $00802080, $00800081, $00800001, $00002001,
      $00000000, $00802000, $00802000, $00802081, $00000081, $00000000, $00800080, $00800001,
      $00000001, $00002000, $00800000, $00802001, $00000080, $00800000, $00002001, $00002080,
      $00800081, $00000001, $00002080, $00800080, $00002000, $00802080, $00802081, $00000081,
      $00800080, $00800001, $00802000, $00802081, $00000081, $00000000, $00000000, $00802000,
      $00002080, $00800080, $00800081, $00000001, $00802001, $00002081, $00002081, $00000080,
      $00802081, $00000081, $00000001, $00002000, $00800001, $00002001, $00802080, $00800081,
      $00002001, $00002080, $00800000, $00802001, $00000080, $00800000, $00002000, $00802080),
     ($00000100, $02080100, $02080000, $42000100, $00080000, $00000100, $40000000, $02080000,
      $40080100, $00080000, $02000100, $40080100, $42000100, $42080000, $00080100, $40000000,
      $02000000, $40080000, $40080000, $00000000, $40000100, $42080100, $42080100, $02000100,
      $42080000, $40000100, $00000000, $42000000, $02080100, $02000000, $42000000, $00080100,
      $00080000, $42000100, $00000100, $02000000, $40000000, $02080000, $42000100, $40080100,
      $02000100, $40000000, $42080000, $02080100, $40080100, $00000100, $02000000, $42080000,
      $42080100, $00080100, $42000000, $42080100, $02080000, $00000000, $40080000, $42000000,
      $00080100, $02000100, $40000100, $00080000, $00000000, $40080000, $02080100, $40000100),
     ($20000010, $20400000, $00004000, $20404010, $20400000, $00000010, $20404010, $00400000,
      $20004000, $00404010, $00400000, $20000010, $00400010, $20004000, $20000000, $00004010,
      $00000000, $00400010, $20004010, $00004000, $00404000, $20004010, $00000010, $20400010,
      $20400010, $00000000, $00404010, $20404000, $00004010, $00404000, $20404000, $20000000,
      $20004000, $00000010, $20400010, $00404000, $20404010, $00400000, $00004010, $20000010,
      $00400000, $20004000, $20000000, $00004010, $20000010, $20404010, $00404000, $20400000,
      $00404010, $20404000, $00000000, $20400010, $00000010, $00004000, $20400000, $00404010,
      $00004000, $00400010, $20004010, $00000000, $20404000, $20000000, $00400010, $20004010),
     ($00200000, $04200002, $04000802, $00000000, $00000800, $04000802, $00200802, $04200800,
      $04200802, $00200000, $00000000, $04000002, $00000002, $04000000, $04200002, $00000802,
      $04000800, $00200802, $00200002, $04000800, $04000002, $04200000, $04200800, $00200002,
      $04200000, $00000800, $00000802, $04200802, $00200800, $00000002, $04000000, $00200800,
      $04000000, $00200800, $00200000, $04000802, $04000802, $04200002, $04200002, $00000002,
      $00200002, $04000000, $04000800, $00200000, $04200800, $00000802, $00200802, $04200800,
      $00000802, $04000002, $04200802, $04200000, $00200800, $00000000, $00000002, $04200802,
      $00000000, $00200802, $04200000, $00000800, $04000002, $04000800, $00000800, $00200002),
     ($10001040, $00001000, $00040000, $10041040, $10000000, $10001040, $00000040, $10000000,
      $00040040, $10040000, $10041040, $00041000, $10041000, $00041040, $00001000, $00000040,
      $10040000, $10000040, $10001000, $00001040, $00041000, $00040040, $10040040, $10041000,
      $00001040, $00000000, $00000000, $10040040, $10000040, $10001000, $00041040, $00040000,
      $00041040, $00040000, $10041000, $00001000, $00000040, $10040040, $00001000, $00041040,
      $10001000, $00000040, $10000040, $10040000, $10040040, $10000000, $00040000, $10001040,
      $00000000, $10041040, $00040040, $10000040, $10040000, $10001000, $10001040, $00000000,
      $10041040, $00041000, $00041000, $00001040, $00001040, $00040040, $10000000, $10041000));
var
  I, L, R, Work : LongInt;
  CPtr          : PLongInt;

  {$IFDEF Win32}
  procedure SplitBlock(const Block : TDESBlock;  var L, R : LongInt); register;
  asm
    push ebx
    push eax
    mov  eax, [eax]
    mov  bh, al
    mov  bl, ah
    rol  ebx, 16
    shr  eax, 16
    mov  bh, al
    mov  bl, ah
    mov  [edx], ebx
    pop  eax
    mov  eax, [eax+4]
    mov  bh, al
    mov  bl, ah
    rol  ebx, 16
    shr  eax, 16
    mov  bh, al
    mov  bl, ah
    mov  [ecx], ebx
    pop  ebx
  end;
  {$ELSE}
  procedure SplitBlock(const Block : TDESBlock;  var L, R : LongInt);
  var
    BlockArray : array [0..1] of LongInt absolute Block;
  begin
    L := ((BlockArray[0] and $FF00FF00) shr 8) or ((BlockArray[0] and $00FF00FF) shl 8);
    L := (L shl 16) or (L shr 16);
    R := ((BlockArray[1] and $FF00FF00) shr 8) or ((BlockArray[1] and $00FF00FF) shl 8);
    R := (R shl 16) or (R shr 16);
  end;
  {$ENDIF}

  {$IFDEF Win32}
  procedure JoinBlock(const L, R : LongInt;  var Block : TDESBlock); register;
  asm
    push ebx
    mov  bh, al
    mov  bl, ah
    rol  ebx, 16
    shr  eax, 16
    mov  bh, al
    mov  bl, ah
    mov  [ecx+4], ebx
    mov  bh, dl
    mov  bl, dh
    rol  ebx, 16
    shr  edx, 16
    mov  bh, dl
    mov  bl, dh
    mov  [ecx], ebx
    pop  ebx
  end;
  {$ELSE}
  procedure JoinBlock(const L, R : LongInt;  var Block : TDESBlock);
  var
    BlockArray : array [0..1] of LongInt absolute Block;
  begin
    BlockArray[0] := ((R and $FF00FF00) shr 8) or ((R and $00FF00FF) shl 8);
    BlockArray[0] := (BlockArray[0] shl 16) or (BlockArray[0] shr 16);
    BlockArray[1] := ((L and $FF00FF00) shr 8) or ((L and $00FF00FF) shl 8);
    BlockArray[1] := (BlockArray[1] shl 16) or (BlockArray[1] shr 16);
  end;
  {$ENDIF}

  procedure IPerm(var L, R : LongInt);
  var
    Work : LongInt;
  begin
    Work := ((L shr 4) xor R) and $0F0F0F0F;
    R := R xor Work;
    L := L xor Work shl 4;

    Work := ((L shr 16) xor R) and $0000FFFF;
    R := R xor Work;
    L := L xor Work shl 16;

    Work := ((R shr 2) xor L) and $33333333;
    L := L xor Work;
    R := R xor Work shl 2;

    Work := ((R shr 8) xor L) and $00FF00FF;
    L := L xor Work;
    R := R xor Work shl 8;

    R := (R shl 1) or (R shr 31);
    Work := (L xor R) and $AAAAAAAA;
    L := L xor Work;
    R := R xor Work;
    L := (L shl 1) or (L shr 31);
  end;

  procedure FPerm(var L, R : LongInt);
  var
    Work : LongInt;
  begin
    L := L;

    R := (R shl 31) or (R shr 1);
    Work := (L xor R) and $AAAAAAAA;
    L := L xor Work;
    R := R xor Work;
    L := (L shr 1) or (L shl 31);

    Work := ((L shr 8) xor R) and $00FF00FF;
    R := R xor Work;
    L := L xor Work shl 8;

    Work := ((L shr 2) xor R) and $33333333;
    R := R xor Work;
    L := L xor Work shl 2;

    Work := ((R shr 16) xor L) and $0000FFFF;
    L := L xor Work;
    R := R xor Work shl 16;

    Work := ((R shr 4) xor L) and $0F0F0F0F;
    L := L xor Work;
    R := R xor Work shl 4;
  end;

begin
  SplitBlock(Block, L, R);
  IPerm(L, R);

  CPtr := @Context;
  for I := 0 to 7 do begin
    Work := (((R shr 4) or (R shl 28)) xor CPtr^);
    Inc(CPtr);
    L := L Xor SPBox[6, Work and $3F];
    L := L Xor SPBox[4, Work shr 8 and $3F];
    L := L Xor SPBox[2, Work shr 16 and $3F];
    L := L Xor SPBox[0, Work shr 24 and $3F];

    Work := (R xor CPtr^);
    Inc(CPtr);
    L := L Xor SPBox[7, Work and $3F];
    L := L Xor SPBox[5, Work shr 8 and $3F];
    L := L Xor SPBox[3, Work shr 16 and $3F];
    L := L Xor SPBox[1, Work shr 24 and $3F];

    Work := (((L shr 4) or (L shl 28)) xor CPtr^);
    Inc(CPtr);
    R := R Xor SPBox[6, Work and $3F];
    R := R Xor SPBox[4, Work shr 8 and $3F];
    R := R Xor SPBox[2, Work shr 16 and $3F];
    R := R Xor SPBox[0, Work shr 24 and $3F];

    Work := (L xor CPtr^);
    Inc(CPtr);
    R := R Xor SPBox[7, Work and $3F];
    R := R Xor SPBox[5, Work shr 8 and $3F];
    R := R Xor SPBox[3, Work shr 16 and $3F];
    R := R Xor SPBox[1, Work shr 24 and $3F];
  end;

  FPerm(L, R);
  JoinBlock(L, R, Block);
end;

procedure EncryptDESCBC(const Context : TDESContext;  const Prev : TDESBlock;  var Block : TDESBlock);
begin
  if Context.Encrypt then begin
    XorMem(Block, Prev, SizeOf(Block));
    EncryptDES(Context, Block);
  end else begin
    EncryptDES(Context, Block);
    XorMem(Block, Prev, SizeOf(Block));
  end;
end;

procedure InitEncryptTripleDES(const Key : TKey128;  var Context : TTripleDESContext; Encrypt : Boolean);
var
  KeyArray : array [0..1] of TKey64 absolute Key;
begin
  if Encrypt then begin
    InitEncryptDES(KeyArray[0], Context[0], True);
    InitEncryptDES(KeyArray[1], Context[1], False);
  end else begin
    InitEncryptDES(KeyArray[0], Context[0], False);
    InitEncryptDES(KeyArray[1], Context[1], True);
  end;
end;

procedure EncryptTripleDES(const Context : TTripleDESContext;  var Block : TDESBlock);
begin
  EncryptDES(Context[0], Block);
  EncryptDES(Context[1], Block);
  EncryptDES(Context[0], Block);
end;

procedure EncryptTripleDESCBC(const Context : TTripleDESContext;  const Prev : TDESBlock; var Block : TDESBlock);
begin
  if Context[0].Encrypt then begin
    XorMem(Block, Prev, SizeOf(Block));
    EncryptDES(Context[0], Block);
    EncryptDES(Context[1], Block);
    EncryptDES(Context[0], Block);
  end else begin
    EncryptDES(Context[0], Block);
    EncryptDES(Context[1], Block);
    EncryptDES(Context[0], Block);
    XorMem(Block, Prev, SizeOf(Block));
  end;
end;

procedure EncryptLQC(const Key : TKey128; var Block : TLQCBlock; Encrypt : Boolean);
const
  CKeyBox : array [False..True, 0..3, 0..2] of LongInt =
    (((0, 3, 1), (2, 1, 3), (1, 0, 2), (3, 2, 0)),
     ((3, 2, 0), (1, 0, 2), (2, 1, 3), (0, 3, 1)));
var
  KeyInts : array [0..3] of LongInt absolute Key;
  Blocks  : array [0..1] of LongInt absolute Block;
  Work    : LongInt;
  Right   : LongInt;
  Left    : LongInt;
  R       : LongInt;
  AA, BB  : LongInt;
  CC, DD  : LongInt;
begin
  Right := Blocks[0];
  Left := Blocks[1];

  for R := 0 to 3 do begin
    {transform the right side}
    AA := Right;
    BB := KeyInts[CKeyBox[Encrypt, R, 0]];
    CC := KeyInts[CKeyBox[Encrypt, R, 1]];
    DD := KeyInts[CKeyBox[Encrypt, R, 2]];

    {commented code does not affect results - removed for speed}
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 7);
    BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 13);
    CC := CC + BB; BB := BB + CC; CC := CC xor (CC shr 17);
    DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 9);
    AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 3);
    BB := BB + AA; {AA := AA + BB;}  BB := BB xor (BB shl 7);
    CC := CC + BB; {BB := BB + CC;}  CC := CC xor (DD shr 15);
    DD := DD + CC; {CC := CC + DD;}  DD := DD xor (DD shl 11);

    Work := Left xor DD;
    Left := Right;
    Right := Work;
  end;

  Blocks[0] := Left;
  Blocks[1] := Right;
end;

procedure EncryptLQCCBC(const Key : TKey128; const Prev : TLQCBlock; var Block : TLQCBlock; Encrypt : Boolean);
begin
  if Encrypt then begin
    XorMem(Block, Prev, SizeOf(Block));
    EncryptLQC(Key, Block, Encrypt);
  end else begin
    EncryptLQC(Key, Block, Encrypt);
    XorMem(Block, Prev, SizeOf(Block));
  end;
end;

procedure InitEncryptBF(Key : TKey128; var Context : TBFContext);
var
  I     : Integer;
  J     : Integer;
  K     : Integer;
  Data  : LongInt;
  Block : TBFBlock;
begin
  {initialize PArray}
  Move(bf_P, Context.PBox, SizeOf(Context.PBox));
  {initialize SBox}
  Move(bf_S, Context.SBox, SizeOf(Context.SBox));

  {update PArray with the key bits}
  J := 0;
  for I := 0 to (BFRounds+1) do begin
    Data := 0;
    for K := 0 to 3 do begin
      Data := (Data shl 8) or Key[J];
      Inc(J);
      if J >= SizeOf(Key) then
        J := 0;
    end;
    Context.PBox[I] := Context.PBox[I] xor Data;
  end;

  {encrypt an all-zero string using the Blowfish algorithm and}
  {replace the elements of the P-array with the output of this process}

  Block[0] := 0;
  Block[1] := 0;
  I := 0;
  repeat
    EncryptBF(Context, Block, True);
    Context.PBox[I] := Block[0];
    Context.PBox[I+1] := Block[1];
    Inc(I, 2);
  until I > BFRounds+1;

  {continue the process, replacing the elements of the four S-boxes in}
  {order, with the output of the continuously changing Blowfish algorithm}

  for J := 0 to 3 do begin
    I := 0;
    repeat
      EncryptBF(Context, Block, True);
      Context.SBox[J, I] := Block[0];
      Context.SBox[J, I+1] := Block[1];
      Inc(I, 2);
    until I > 255;
  end;

  {in total, 521 iterations are required to generate all required subkeys. }
end;

procedure EncryptBF(const Context : TBFContext;
  var Block : TBFBlock; Encrypt : Boolean);
var
  I : Integer;
  B : TBFBlockEx Absolute Block;
begin
  if Encrypt then begin
    Block[0] := Block[0] xor Context.PBox[0];

    {16 Rounds to go (8 double rounds to avoid swaps)}
    I := 1;
    repeat
      {first half round }
      Block[1] := Block[1] xor Context.PBox[I] xor (((
                  Context.SBox[0, B.Xl[3]] + Context.SBox[1, B.Xl[2]])
                  xor Context.SBox[2, B.Xl[1]]) + Context.SBox[3, B.Xl[0]]);
      {second half round }
      Block[0] := Block[0] xor Context.PBox[I+1] xor (((
                  Context.SBox[0, B.Xr[3]] + Context.SBox[1, B.Xr[2]])
                  xor Context.SBox[2, B.Xr[1]]) + Context.SBox[3, B.Xr[0]]);
      Inc(I, 2);
    until I > BFRounds;
    Block[1] := Block[1] xor Context.PBox[(BFRounds+1)];
  end else begin
    Block[1] := Block[1] xor Context.PBox[(BFRounds+1)];

    {16 Rounds to go (8 double rounds to avoid swaps)}
    I := BFRounds;
    repeat
      {first half round }
      Block[0] := Block[0] xor Context.PBox[I] xor (((
                  Context.SBox[0, B.Xr[3]] + Context.SBox[1, B.Xr[2]])
                  xor Context.SBox[2, B.Xr[1]]) + Context.SBox[3, B.Xr[0]]);
      {second half round }
      Block[1] := Block[1] xor Context.PBox[i-1] xor (((
                  Context.SBox[0, B.Xl[3]] + Context.SBox[1, B.Xl[2]])
                  xor Context.SBox[2, B.Xl[1]]) + Context.SBox[3, B.Xl[0]]);
       Dec (I, 2);
     until I < 1;
     Block[0] := Block[0] xor Context.PBox[0];
  end;
end;

procedure EncryptBFCBC(const Context : TBFContext; const Prev : TBFBlock;
  var Block : TBFBlock; Encrypt : Boolean);
begin
  if Encrypt then begin
    XorMem(Block, Prev, SizeOf(Block));
    EncryptBF(Context, Block, Encrypt);
  end else begin
    EncryptBF(Context, Block, Encrypt);
    XorMem(Block, Prev, SizeOf(Block));
  end;
end;

procedure InitEncryptLSC(const Key; KeySize : Integer; var Context : TLSCContext);
var
  KeyBytes  : TByteArray absolute Key;
  R, I, A   : LongInt;
  X         : Byte;
begin
  {initialize SBox}
  for I := 0 to 255 do
    Context.SBox[I] := I;

  A := 0;
  for R := 0 to 2 do  {3 rounds - "A" accumulates}
    for I := 0 to 255 do begin
      A := A + Context.SBox[I] + KeyBytes[I mod KeySize];
      X := Context.SBox[I];
      Context.SBox[I] := Context.SBox[Byte(A)];
      Context.SBox[Byte(A)] := X;
    end;

  Context.Index := 0;
  Context.Accumulator := A;
end;

procedure EncryptLSC(var Context : TLSCContext; var Buf; BufSize : LongInt);
var
  Bytes     : TByteArray absolute Buf;
  L, Y, X   : LongInt;
  I, A      : LongInt;
begin
  I := Context.Index;
  A := Context.Accumulator;

  for L := 0 to BufSize - 1 do begin
    I := I + 1;

    X := Context.SBox[Byte(I)];
    Y := Context.SBox[Byte(X)] + X;
    Context.SBox[Byte(I)] := Context.SBox[Byte(Y)];
    Context.SBox[Byte(Y)] := X;

    A := A + Context.SBox[Byte(Byte(Y shr 8) + Byte(Y))];
    Bytes[L] := Bytes[L] xor Byte(A);
  end;

  Context.Index := I;
  Context.Accumulator := A;
end;

procedure InitEncryptRNG32(Key : LongInt; var Context : TRNG32Context);
begin
  LongInt(Context) := Key;
end;

procedure EncryptRNG32(var Context : TRNG32Context; var Buf; BufSize : LongInt);
var
  Bytes : TByteArray absolute Buf;
  I     : LongInt;
begin
  for I := 0 to BufSize - 1 do
    Bytes[I] := Bytes[I] xor Random32Byte(LongInt(Context));
end;

procedure InitEncryptRNG64(KeyHi, KeyLo : LongInt; var Context : TRNG64Context);
begin
  TInt64(Context).Lo := KeyLo;
  TInt64(Context).Hi := KeyHi;
end;

procedure EncryptRNG64(var Context : TRNG64Context; var Buf; BufSize : LongInt);
var
  Bytes : TByteArray absolute Buf;
  I     : Integer;
begin
  for I := 0 to BufSize - 1 do
    Bytes[I] := Bytes[I] xor Random64Byte(TInt64(Context));
end;

procedure GenerateRandomKey(var Key; KeySize : Integer);
var
  Bytes : TByteArray absolute Key;
  I     : Integer;
begin
  Randomize;
  for I := 0 to KeySize - 1 do
    Bytes[I] := System.Random(256);
end;

procedure GenerateLMDKey(var Key; KeySize : Integer; const Str : string);
begin
  HashLMD(Key, KeySize, Str[1], Length(Str));
end;

procedure GenerateMD5Key(var Key : TKey128; const Str : string);
var
  D : TMD5Digest;
begin
  HashMD5(D, Str[1], Length(Str));
  Key := TKey128(D);
end;

function Ran0Prim(var Seed : LongInt; IA, IQ, IR : LongInt) : LongInt;
const
  IM = 2147483647;
  MA = 123459876;
var
  I, K : LongInt;
begin
  {XORing with mask avoids seeds of zero}
  I := Seed xor MA;
  K := I div IQ;
  I := (IA * (I - (K * IQ))) - (IR * K);
  if I < 0 then
    I := I + IM;
  Result := I xor MA;
  Seed := Result;
end;

function Ran01(var Seed : LongInt) : LongInt;
begin
  Result := Ran0Prim(Seed, 16807, 127773, 2836);
end;

function Ran02(var Seed : LongInt) : LongInt;
begin
  Result := Ran0Prim(Seed, 48271, 44488, 3399);
end;

function Ran03(var Seed : LongInt) : LongInt;
begin
  Result := Ran0Prim(Seed, 69621, 30845, 23902);
end;

function Random32Byte(var Seed : LongInt) : Byte;
var
  L : LongInt;
  R : TLongIntRec;
begin
  L := Ran01(Seed);
  R := TLongIntRec(L);
  Result := R.LoLo xor R.LoHi xor R.HiLo xor R.HiHi;
end;

function Random64(var Seed : TInt64) : LongInt;
begin
  Ran01(Seed.Lo);
  Ran01(Seed.Hi);
  Result := Seed.Lo xor Seed.Hi;
end;

function Random64Byte(var Seed : TInt64) : Byte;
var
  L : LongInt;
  R : TLongIntRec;
begin
  L := Random64(Seed);
  R := TLongIntRec(L);
  Result := R.LoLo xor R.LoHi xor R.HiLo xor R.HiHi;
end;

procedure  ShrinkDESKey(var Key : TKey64);
const
  SK1 : TKey64 = ($C4,$08,$B0,$54,$0B,$A1,$E0,$AE);
  SK2 : TKey64 = ($EF,$2C,$04,$1C,$E6,$38,$2F,$E6);
var
  I       : Integer;
  Work1   : TKey64;
  Work2   : TKey64;
  Context : TDESContext;
begin
  {step #1 zero the parity bits - 8, 16, 24, ..., 64}
  for I := 0 to 7 do
    Work1[I] := Key[I] and $FE;

  {step #2 encrypt output of #1 with SK1 and xor with output of #1}
  InitEncryptDES(SK1, Context, True);
  Work2 := Work1; {make copy}
  EncryptDES(Context, TDESBlock(Work2));
  for I := 0 to 7 do
    Work1[I] := Work1[I] xor Work2[I];

  {step #3 zero bits 1,2,3,4,8,16,17,18,19,20,24,32,33,34,35,36,40,48,49,50,51,52,56,64}
  TInt64(Work1).Lo := TInt64(Work1).Lo and $F101F101;
  TInt64(Work1).Hi := TInt64(Work1).Hi and $F101F101;

  {step #4 encrypt output of #3 with SK2}
  InitEncryptDES(SK2, Context, True);
  EncryptDES(Context, TDESBlock(Work1));

  Key := Work1;
end;

function Min(A, B : LongInt) : LongInt;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function Max(A, B : LongInt) : LongInt;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;


procedure Mix128(var X : T128Bit);
var
  AA, BB, CC, DD : LongInt;
begin
  AA := X[0];  BB := X[1];  CC := X[2];  DD := X[3];

  AA := AA + DD;  DD := DD + AA;  AA := AA xor (AA shr 7);
  BB := BB + AA;  AA := AA + BB;  BB := BB xor (BB shl 13);
  CC := CC + BB;  BB := BB + CC;  CC := CC xor (CC shr 17);
  DD := DD + CC;  CC := CC + DD;  DD := DD xor (DD shl 9);
  AA := AA + DD;  DD := DD + AA;  AA := AA xor (AA shr 3);
  BB := BB + AA;  AA := AA + BB;  BB := BB xor (BB shl 7);
  CC := CC + BB;  BB := BB + CC;  CC := CC xor (DD shr 15);
  DD := DD + CC;  CC := CC + DD;  DD := DD xor (DD shl 11);

  X[0] := AA;  X[1] := BB;  X[2] := CC;  X[3] := DD;
end;

procedure HashElf(var Digest : LongInt; const Buf;  BufSize : LongInt);
var
  Bytes : TByteArray absolute Buf;
  I, X  : LongInt;
begin
  Digest := 0;
  for I := 0 to BufSize - 1 do begin
    Digest := (Digest shl 4) + Bytes[I];
    X := Digest and $F0000000;
    if (X <> 0) then
      Digest := Digest xor (X shr 24);
    Digest := Digest and (not X);
  end;
end;

procedure StringHashElf(var Digest : LongInt; const Str : string);
begin
  HashElf(Digest, Str[1], Length(Str));
end;

{$IFDEF Win32}
function RolX(I, C : LongInt) : LongInt; register;
asm
  mov  ecx, edx         {get count to cl}
  rol  eax, cl          {rotate eax by cl}
end;
{$ELSE}
function RolX(I, C : LongInt) : LongInt; assembler;
asm
  db $66
  mov  ax,word ptr I    {eax = I}
  db $66
  mov  cx,word ptr C    {ecx = C}
  db $66
  rol  ax, cl           {rotate eax by cl}
  db $66
  push ax               {push eax}
  {set result}
  pop  ax               {low word to ax}
  pop  dx               {high word to dx}
end;
{$ENDIF}

procedure Transform(var Buffer : array of LongInt;  const InBuf : array of LongInt);
const
  S11 = 7;
  S12 = 12;
  S13 = 17;
  S14 = 22;
  S21 = 5;
  S22 = 9;
  S23 = 14;
  S24 = 20;
  S31 = 4;
  S32 = 11;
  S33 = 16;
  S34 = 23;
  S41 = 6;
  S42 = 10;
  S43 = 15;
  S44 = 21;
var
  Buf : array [0..3] of LongInt absolute Buffer;
  InA : array [0..15] of LongInt absolute InBuf;
  A   : Integer;
  B   : Integer;
  C   : Integer;
  D   : Integer;

  procedure FF(var A : Integer;  B, C, D, X, S, AC : LongInt);
  begin
    A := RolX(A + ((B and C) or (not B and D)) + X + AC, S) + B;
  end;

  procedure GG(var A : Integer;  B, C, D, X, S, AC : LongInt);
  begin
    A := RolX(A + ((B and D) or (C and not D)) + X + AC, S) + B;
  end;

  procedure HH(var A : Integer;  B, C, D, X, S, AC : LongInt);
  begin
    A := RolX(A + (B xor C xor D) + X + AC, S) + B;
  end;

  procedure II(var A : Integer;  B, C, D, X, S, AC : LongInt);
  begin
    A := RolX(A + (C xor (B or not D)) + X + AC, S) + B;
  end;

begin
  A := Buf [0];
  B := Buf [1];
  C := Buf [2];
  D := Buf [3];

  {round 1}
  FF(A, B, C, D, InA [ 0], S11, $D76AA478);  { 1 }
  FF(D, A, B, C, InA [ 1], S12, $E8C7B756);  { 2 }
  FF(C, D, A, B, InA [ 2], S13, $242070DB);  { 3 }
  FF(B, C, D, A, InA [ 3], S14, $C1BDCEEE);  { 4 }
  FF(A, B, C, D, InA [ 4], S11, $F57C0FAF);  { 5 }
  FF(D, A, B, C, InA [ 5], S12, $4787C62A);  { 6 }
  FF(C, D, A, B, InA [ 6], S13, $A8304613);  { 7 }
  FF(B, C, D, A, InA [ 7], S14, $FD469501);  { 8 }
  FF(A, B, C, D, InA [ 8], S11, $698098D8);  { 9 }
  FF(D, A, B, C, InA [ 9], S12, $8B44F7AF);  { 10 }
  FF(C, D, A, B, InA [10], S13, $FFFF5BB1);  { 11 }
  FF(B, C, D, A, InA [11], S14, $895CD7BE);  { 12 }
  FF(A, B, C, D, InA [12], S11, $6B901122);  { 13 }
  FF(D, A, B, C, InA [13], S12, $FD987193);  { 14 }
  FF(C, D, A, B, InA [14], S13, $A679438E);  { 15 }
  FF(B, C, D, A, InA [15], S14, $49B40821);  { 16 }

  {round 2}
  GG(A, B, C, D, InA [ 1], S21, $F61E2562);  { 17 }
  GG(D, A, B, C, InA [ 6], S22, $C040B340);  { 18 }
  GG(C, D, A, B, InA [11], S23, $265E5A51);  { 19 }
  GG(B, C, D, A, InA [ 0], S24, $E9B6C7AA);  { 20 }
  GG(A, B, C, D, InA [ 5], S21, $D62F105D);  { 21 }
  GG(D, A, B, C, InA [10], S22, $02441453);  { 22 }
  GG(C, D, A, B, InA [15], S23, $D8A1E681);  { 23 }
  GG(B, C, D, A, InA [ 4], S24, $E7D3FBC8);  { 24 }
  GG(A, B, C, D, InA [ 9], S21, $21E1CDE6);  { 25 }
  GG(D, A, B, C, InA [14], S22, $C33707D6);  { 26 }
  GG(C, D, A, B, InA [ 3], S23, $F4D50D87);  { 27 }
  GG(B, C, D, A, InA [ 8], S24, $455A14ED);  { 28 }
  GG(A, B, C, D, InA [13], S21, $A9E3E905);  { 29 }
  GG(D, A, B, C, InA [ 2], S22, $FCEFA3F8);  { 30 }
  GG(C, D, A, B, InA [ 7], S23, $676F02D9);  { 31 }
  GG(B, C, D, A, InA [12], S24, $8D2A4C8A);  { 32 }

  {round 3}
  HH(A, B, C, D, InA [ 5], S31, $FFFA3942);  { 33 }
  HH(D, A, B, C, InA [ 8], S32, $8771F681);  { 34 }
  HH(C, D, A, B, InA [11], S33, $6D9D6122);  { 35 }
  HH(B, C, D, A, InA [14], S34, $FDE5380C);  { 36 }
  HH(A, B, C, D, InA [ 1], S31, $A4BEEA44);  { 37 }
  HH(D, A, B, C, InA [ 4], S32, $4BDECFA9);  { 38 }
  HH(C, D, A, B, InA [ 7], S33, $F6BB4B60);  { 39 }
  HH(B, C, D, A, InA [10], S34, $BEBFBC70);  { 40 }
  HH(A, B, C, D, InA [13], S31, $289B7EC6);  { 41 }
  HH(D, A, B, C, InA [ 0], S32, $EAA127FA);  { 42 }
  HH(C, D, A, B, InA [ 3], S33, $D4EF3085);  { 43 }
  HH(B, C, D, A, InA [ 6], S34,  $4881D05);  { 44 }
  HH(A, B, C, D, InA [ 9], S31, $D9D4D039);  { 45 }
  HH(D, A, B, C, InA [12], S32, $E6DB99E5);  { 46 }
  HH(C, D, A, B, InA [15], S33, $1FA27CF8);  { 47 }
  HH(B, C, D, A, InA [ 2], S34, $C4AC5665);  { 48 }

  {round 4}
  II(A, B, C, D, InA [ 0], S41, $F4292244);  { 49 }
  II(D, A, B, C, InA [ 7], S42, $432AFF97);  { 50 }
  II(C, D, A, B, InA [14], S43, $AB9423A7);  { 51 }
  II(B, C, D, A, InA [ 5], S44, $FC93A039);  { 52 }
  II(A, B, C, D, InA [12], S41, $655B59C3);  { 53 }
  II(D, A, B, C, InA [ 3], S42, $8F0CCC92);  { 54 }
  II(C, D, A, B, InA [10], S43, $FFEFF47D);  { 55 }
  II(B, C, D, A, InA [ 1], S44, $85845DD1);  { 56 }
  II(A, B, C, D, InA [ 8], S41, $6FA87E4F);  { 57 }
  II(D, A, B, C, InA [15], S42, $FE2CE6E0);  { 58 }
  II(C, D, A, B, InA [ 6], S43, $A3014314);  { 59 }
  II(B, C, D, A, InA [13], S44, $4E0811A1);  { 60 }
  II(A, B, C, D, InA [ 4], S41, $F7537E82);  { 61 }
  II(D, A, B, C, InA [11], S42, $BD3AF235);  { 62 }
  II(C, D, A, B, InA [ 2], S43, $2AD7D2BB);  { 63 }
  II(B, C, D, A, InA [ 9], S44, $EB86D391);  { 64 }

  Inc(Buf [0], A);
  Inc(Buf [1], B);
  Inc(Buf [2], C);
  Inc(Buf [3], D);
end;

procedure InitMD5(var Context : TMD5Context);
var
  MD5 : TMD5ContextEx absolute Context;
begin
  MD5.Count[0] := 0;
  MD5.Count[1] := 0;

  {load magic initialization constants}
  MD5.State[0] := $67452301;
  MD5.State[1] := $EFCDAB89;
  MD5.State[2] := $98BADCFE;
  MD5.State[3] := $10325476;
end;

procedure UpdateMD5(var Context : TMD5Context;  const Buf;  BufSize : LongInt);
var
  MD5    : TMD5ContextEx absolute Context;
  Bytes  : TByteArray absolute Buf;
  InBuf  : array [0..15] of LongInt;
  BufOfs : LongInt;
  MDI    : Word;
  I      : Word;
  II     : Word;
begin
  {compute number of bytes mod 64}
  MDI := (MD5.Count[0] shr 3) and $3F;

  {update number of bits}
  if ((MD5.Count[0] + (BufSize shl 3)) < MD5.Count[0]) then
    Inc(MD5.Count[1]);
  Inc(MD5.Count[0], BufSize shl 3);
  Inc(MD5.Count[1], BufSize shr 29);

  {add new byte acters to buffer}
  BufOfs := 0;
  while (BufSize > 0) do begin
    Dec(BufSize);
    MD5.Buf[MDI] := Bytes[BufOfs];
    Inc(MDI);
    Inc(BufOfs);
    if (MDI = $40) then begin
      II := 0;
      for I := 0 to 15 do begin
        InBuf[I] := LongInt(MD5.Buf[II + 3]) shl 24 or
          LongInt(MD5.Buf[II + 2]) shl 16 or
          LongInt(MD5.Buf[II + 1]) shl 8 or
          LongInt(MD5.Buf[II]);
        Inc(II, 4);
      end;
      Transform(MD5.State, InBuf);
      MDI := 0;
    end;
  end;
end;

procedure FinalizeMD5(var Context : TMD5Context; var Digest : TMD5Digest);
const
  Padding: array [0..63] of Byte = (
    $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00);
var
  MD5    : TMD5ContextEx absolute Context;
  InBuf  : array [0..15] of LongInt;
  MDI    : LongInt;
  I      : Word;
  II     : Word;
  PadLen : Word;
begin
  {save number of bits}
  InBuf[14] := MD5.Count[0];
  InBuf[15] := MD5.Count[1];

  {compute number of bytes mod 64}
  MDI := (MD5.Count[0] shr 3) and $3F;

  {pad out to 56 mod 64}
  if (MDI < 56) then
    PadLen := 56 - MDI
  else
    PadLen := 120 - MDI;
  UpdateMD5(Context, Padding, PadLen);

  {append length in bits and transform}
  II := 0;
  for I := 0 to 13 do begin
    InBuf[I] := (LongInt(MD5.Buf[II + 3]) shl 24) or
      (LongInt(MD5.Buf[II + 2]) shl 16) or
      (LongInt(MD5.Buf[II + 1]) shl 8) or
      LongInt(MD5.Buf[II]);
    Inc(II, 4);
  end;
  Transform(MD5.State, InBuf);

  {store buffer in digest}
  II := 0;
  for I := 0 to 3 do begin
    Digest[II] := Byte(MD5.State[I] and $FF);
    Digest[II + 1] := Byte((MD5.State[I] shr 8) and $FF);
    Digest[II + 2] := Byte((MD5.State[I] shr 16) and $FF);
    Digest[II + 3] := Byte((MD5.State[I] shr 24) and $FF);
    Inc(II, 4);
  end;
end;


procedure HashMD5(var Digest : TMD5Digest; const Buf;  BufSize : LongInt);
var
  Context : TMD5Context;
begin
  InitMD5(Context);
  UpdateMD5(Context, Buf, BufSize);
  FinalizeMD5(Context, Digest);
end;

procedure InitLMD(var Context : TLMDContext);
var
  ContextEx : TLMDContextEx absolute Context;
begin
  ContextEx.DigestIndex := 0;
  TBlock2048(ContextEx.Digest) := TBlock2048(Pi2048);

  ContextEx.KeyIndex := 0;
  ContextEx.KeyInts[0] := $55555555;
  ContextEx.KeyInts[1] := $55555555;
  ContextEx.KeyInts[2] := $55555555;
  ContextEx.KeyInts[3] := $55555555;
end;

procedure UpdateLMD(var Context : TLMDContext; const Buf; BufSize : LongInt);
var
  ContextEx : TLMDContextEx absolute Context;
  BufBytes  : TByteArray absolute Buf;
  AA, BB    : LongInt;
  CC, DD    : LongInt;
  I, R      : LongInt;
begin
  for I := 0 to BufSize - 1 do
    with ContextEx do begin
      {update Digest}
      Digest[DigestIndex] := Digest[DigestIndex] xor BufBytes[I];
      DigestIndex := DigestIndex + 1;
      if (DigestIndex = SizeOf(Digest)) then
        DigestIndex := 0;

      {update BlockKey}
      Key[KeyIndex] := Key[KeyIndex] xor BufBytes[I];
      KeyIndex := KeyIndex + 1;
      if (KeyIndex = SizeOf(Key) div 2) then begin
        AA := KeyInts[3];
        BB := KeyInts[2];
        CC := KeyInts[1];
        DD := KeyInts[0];

        {mix all the bits around for 4 rounds}
        {achieves avalanche and eliminates funnels}
        for R := 0 to 3 do begin
          AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 7);
          BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 13);
          CC := CC + BB; BB := BB + CC; CC := CC xor (CC shr 17);
          DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 9);
          AA := AA + DD; DD := DD + AA; AA := AA xor (AA shr 3);
          BB := BB + AA; AA := AA + BB; BB := BB xor (BB shl 7);
          CC := CC + BB; BB := BB + CC; CC := CC xor (DD shr 15);
          DD := DD + CC; CC := CC + DD; DD := DD xor (DD shl 11);
        end;

        KeyInts[0] := AA;
        KeyInts[1] := BB;
        KeyInts[2] := CC;
        KeyInts[3] := DD;

        KeyIndex := 0;
      end;
    end;
end;

procedure FinalizeLMD(var Context : TLMDContext; var Digest; DigestSize : LongInt);
const
  Padding : array [0..7] of Byte = (1, 0, 0, 0, 0, 0, 0, 0);
var
  ContextEx : TLMDContextEx absolute Context;
  BCContext : TLBCContext;
  I         : Integer;
begin
  {pad with "1", followed by as many "0"s as needed to fill the block}
  UpdateLMD(Context, Padding, SizeOf(Padding) - ContextEx.KeyIndex);

  {mix context using block cipher}
  InitEncryptLBC(ContextEx.Key, BCContext, 8, True);
  for I := 0 to (SizeOf(ContextEx.Digest) div SizeOf(TLBCBlock)) - 1 do
    EncryptLBC(BCContext, PLBCBlock(@ContextEx.Digest[I * SizeOf(TLBCBlock)])^);

  {return Digest of requested DigestSize}
  {max digest is 2048-bit, although it could be greater if Pi2048 was larger}
  Move(ContextEx.Digest, Digest, Min(SizeOf(ContextEx.Digest), DigestSize));
end;

procedure HashLMD(var Digest; DigestSize : LongInt; const Buf; BufSize : LongInt);
var
  Context : TLMDContext;
begin
  InitLMD(Context);
  UpdateLMD(Context, Buf, BufSize);
  FinalizeLMD(Context, Digest, DigestSize);
end;

(*
procedure Mix128xR(R : LongInt;  var X : T128Bit);
var
  I,
  AA, BB, CC, DD : LongInt;
begin
  AA := X[0];  BB := X[1];  CC := X[2];  DD := X[3];

  for I := 0 to R - 1 do begin
    AA := AA + DD;  DD := DD + AA;  AA := AA xor (AA shr 7);
    BB := BB + AA;  AA := AA + BB;  BB := BB xor (BB shl 13);
    CC := CC + BB;  BB := BB + CC;  CC := CC xor (CC shr 17);
    DD := DD + CC;  CC := CC + DD;  DD := DD xor (DD shl 9);
    AA := AA + DD;  DD := DD + AA;  AA := AA xor (AA shr 3);
    BB := BB + AA;  AA := AA + BB;  BB := BB xor (BB shl 7);
    CC := CC + BB;  BB := BB + CC;  CC := CC xor (DD shr 15);
    DD := DD + CC;  CC := CC + DD;  DD := DD xor (DD shl 11);
  end;

  X[0] := AA;  X[1] := BB;  X[2] := CC;  X[3] := DD;
end;
*)

(*
procedure Mix256(var X : T256Bit);
var
  AA, BB, CC, DD : LongInt;
  EE, FF, GG, HH : LongInt;
begin
  AA := X[0];  BB := X[1];  CC := X[2];  DD := X[3];
  EE := X[4];  FF := X[5];  GG := X[6];  HH := X[7];

  AA := AA xor (BB shl 11);  DD := DD + AA;  BB := BB + CC;
  BB := BB xor (CC shr 2);   EE := EE + BB;  CC := CC + DD;
  CC := CC xor (DD shl 8);   FF := FF + CC;  DD := DD + EE;
  DD := DD xor (EE shr 16);  GG := GG + DD;  EE := EE + FF;
  EE := EE xor (FF shl 10);  HH := HH + EE;  FF := FF + GG;
  FF := FF xor (GG shr 4);   AA := AA + FF;  GG := GG + HH;
  GG := GG xor (HH shl 8);   BB := BB + GG;  HH := HH + AA;
  HH := HH xor (AA shr 9);   CC := CC + HH;  AA := AA + BB;

  X[0] := AA;  X[1] := BB;  X[2] := CC;  X[3] := DD;
  X[4] := EE;  X[5] := FF;  X[6] := GG;  X[7] := HH;
end;
*)

(*
procedure Mix256xR(R : LongInt;  var X : T256Bit);
var
  I              : LongInt;
  AA, BB, CC, DD : LongInt;
  EE, FF, GG, HH : LongInt;
begin
  AA := X[0];  BB := X[1];  CC := X[2];  DD := X[3];
  EE := X[4];  FF := X[5];  GG := X[6];  HH := X[7];

  for I := 0 to R - 1 do begin
    AA := AA xor (BB shl 11);  DD := DD + AA;  BB := BB + CC;
    BB := BB xor (CC shr 2);   EE := EE + BB;  CC := CC + DD;
    CC := CC xor (DD shl 8);   FF := FF + CC;  DD := DD + EE;
    DD := DD xor (EE shr 16);  GG := GG + DD;  EE := EE + FF;
    EE := EE xor (FF shl 10);  HH := HH + EE;  FF := FF + GG;
    FF := FF xor (GG shr 4);   AA := AA + FF;  GG := GG + HH;
    GG := GG xor (HH shl 8);   BB := BB + GG;  HH := HH + AA;
    HH := HH xor (AA shr 9);   CC := CC + HH;  AA := AA + BB;
  end;

  X[0] := AA;  X[1] := BB;  X[2] := CC;  X[3] := DD;
  X[4] := EE;  X[5] := FF;  X[6] := GG;  X[7] := HH;
end;
*)

procedure HashMix128(var Digest : LongInt; const Buf;  BufSize : LongInt);
type
  T128BitArray = array [0..0] of T128Bit;
var
  Buf128Bit : T128BitArray absolute Buf;
  BufBytes  : TByteArray absolute Buf;
  Temp      : T128Bit;
  TempBytes : TByteArray absolute Temp;
  I, L      : LongInt;
begin
  Temp[0] := $243F6A88;  {first 16 bytes of Pi in binary}
  Temp[1] := $93F40317;
  Temp[2] := $0C110496;
  Temp[3] := $C709C289;

  L := BufSize div SizeOf(T128Bit);
  for I := 0 to L - 1 do begin
    Temp[0] := Temp[0] + Buf128Bit[I, 0];
    Temp[1] := Temp[1] + Buf128Bit[I, 1];
    Temp[2] := Temp[2] + Buf128Bit[I, 2];
    Temp[3] := Temp[3] + Buf128Bit[I, 3];
    Mix128(Temp);
  end;

  if (BufSize > L * SizeOf(T128Bit)) then begin
    for I := 0 to (BufSize - L * SizeOf(T128Bit)) - 1 do
      TempBytes[I] := TempBytes[I] + BufBytes[(L * SizeOf(T128Bit)) + I];
    Mix128(Temp);
  end;

  Digest := Temp[3];
end;

procedure StringHashMix128(var Digest : LongInt; const Str : string);
begin
  HashMix128(Digest, Str[1], Length(Str));
end;

procedure StringHashMD5(var Digest : TMD5Digest; const Str : string);
begin
  HashMD5(Digest, Str[1], Length(Str));
end;

procedure StringHashLMD(var Digest; DigestSize : LongInt; const Str : string);
begin
  HashLMD(Digest, DigestSize, Str[1], Length(Str));
end;

{$IFDEF Win32}
procedure XorMem(var Mem1;  const Mem2;  Count : Cardinal); register;
asm
  push esi
  push edi

  mov  esi, eax         //esi = Mem1
  mov  edi, edx         //edi = Mem2

  push ecx              //save byte count
  shr  ecx, 2           //convert to dwords
  jz   @Continue

  cld
@Loop1:                 //xor dwords at a time
  mov  eax, [edi]
  xor  [esi], eax
  add  esi, 4
  add  edi, 4
  dec  ecx
  jnz  @Loop1

@Continue:              //handle remaining bytes (3 or less)
  pop  ecx
  and  ecx, 3
  jz   @Done

@Loop2:                 //xor remaining bytes
  mov  al, [edi]
  xor  [esi], al
  inc  esi
  inc  edi
  dec  ecx
  jnz  @Loop2

@Done:
  pop  edi
  pop  esi
end;
{$ELSE}
procedure XorMem(var Mem1;  const Mem2;  Count : Cardinal); assembler;
asm
  db   $66
  mov  si,word ptr Mem1      {esi = Mem1}
  db   $66
  mov  di,word ptr Mem2      {edi = Mem1}

  mov  cx,Count
  push cx
  shr  cx,2
  jz   @Continue

  cld
@Loop1:
  db   $66
  mov  ax, [di]
  db   $66
  xor  [si], ax
  db   $66
  add  si, 4
  db   $66
  add  di, 4
  dec  cx
  jnz  @Loop1

@Continue:
  pop  cx
  and  cx,3
  jz   @Done

@Loop2:
  mov  al, [di]
  xor  [si], al
  inc  si
  inc  di
  dec  cx
  jnz  @Loop2
@Done:
end;
{$ENDIF}

{$WARNINGS ON}

end.