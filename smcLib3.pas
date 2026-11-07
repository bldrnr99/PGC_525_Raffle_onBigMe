{*********************************************************}
{*                   LBPROC.PAS 1.03                     *}
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

unit smcLib3;
  {-stream and file routines for block and stream ciphers}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, MMSystem, SysUtils, smcLib1;

type
  ECipherException = class(Exception);

procedure BFEncryptFile(const InFile, OutFile : string; Key : TKey128; Encrypt : Boolean); export;
procedure BFEncryptFileCBC(const InFile, OutFile : string; Key : TKey128; Encrypt : Boolean); export;
procedure BFEncryptStream(InStream, OutStream : TStream; Key : TKey128; Encrypt : Boolean); export;
procedure BFEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128; Encrypt : Boolean); export;
procedure DESEncryptFile(const InFile, OutFile : string; Key : TKey64; Encrypt : Boolean); export;
procedure DESEncryptFileCBC(const InFile, OutFile : string; Key : TKey64; Encrypt : Boolean); export;
procedure DESEncryptStream(InStream, OutStream : TStream; Key : TKey64; Encrypt : Boolean); export;
procedure DESEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey64; Encrypt : Boolean); export;
procedure LBCEncryptFile(const InFile, OutFile : string; Key : TKey128; Rounds : LongInt; Encrypt : Boolean); export;
procedure LBCEncryptFileCBC(const InFile, OutFile : string; Key : TKey128; Rounds : LongInt; Encrypt : Boolean); export;
procedure LBCEncryptStream(InStream, OutStream : TStream; Key : TKey128; Rounds : LongInt; Encrypt : Boolean); export;
procedure LBCEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128; Rounds : LongInt; Encrypt : Boolean); export;
procedure LQCEncryptFile(const InFile, OutFile : string; Key : TKey128; Encrypt : Boolean); export;
procedure LQCEncryptFileCBC(const InFile, OutFile : string; Key : TKey128; Encrypt : Boolean); export;
procedure LQCEncryptStream(InStream, OutStream : TStream; Key : TKey128; Encrypt : Boolean); export;
procedure LQCEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128; Encrypt : Boolean); export;
procedure LSCEncryptFile(const InFile, OutFile : string; const Key; KeySize : Integer); export;
procedure RNG32EncryptFile(const InFile, OutFile : string; Key : LongInt); export;
procedure RNG64EncryptFile(const InFile, OutFile : string; KeyHi, KeyLo : LongInt); export;
procedure TripleDESEncryptFile(const InFile, OutFile : string; Key : TKey128; Encrypt : Boolean); export;
procedure TripleDESEncryptFileCBC(const InFile, OutFile : string; Key : TKey128; Encrypt : Boolean); export;
procedure TripleDESEncryptStream(InStream, OutStream : TStream; Key : TKey128; Encrypt : Boolean); export;
procedure TripleDESEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128; Encrypt : Boolean); export;


implementation

const
  SInvalidFileFormat = 'Invalid file format';


procedure BFEncryptFile(const InFile, OutFile : string; Key : TKey128;
                        Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      BFEncryptStream(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure BFEncryptFileCBC(const InFile, OutFile : string; Key : TKey128;
                           Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      BFEncryptStreamCBC(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure BFEncryptStream(InStream, OutStream : TStream; Key : TKey128;
                          Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TBFBlock;
  Context    : TBFContext;
  BlockCount : LongInt;
begin
  InitEncryptBF(Key, Context);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptBF(Context, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptBF(Context, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptBF(Context, Block, Encrypt);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure BFEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128;
                             Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TBFBlock;
  IV         : TBFBlock;
  Work       : TBFBlock;
  Context    : TBFContext;
  BlockCount : LongInt;
begin
  InitEncryptBF(Key, Context);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  if Encrypt then begin
    {set up an initialization vector (IV)}
    Block[0] := timeGetTime;
    Block[1] := timeGetTime;
    EncryptBF(Context, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
    IV := Block;
  end else begin
    {read the frist block to prime the IV}
    InStream.Read(Block, SizeOf(Block));
    Dec(BlockCount);
    IV := Block;
  end;

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);

    if Encrypt then begin
      EncryptBFCBC(Context, IV, Block, Encrypt);
      IV := Block;
    end else begin
      Work := Block;
      EncryptBFCBC(Context, IV, Block, Encrypt);
      IV := Work;
    end;

    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptBFCBC(Context, IV, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptBFCBC(Context, IV, Block, Encrypt);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure DESEncryptFile(const InFile, OutFile : string; Key : TKey64;
                         Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      DESEncryptStream(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure DESEncryptFileCBC(const InFile, OutFile : string; Key : TKey64;
                            Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      DESEncryptStreamCBC(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure DESEncryptStream(InStream, OutStream : TStream; Key : TKey64;
                           Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TDESBlock;
  Context    : TDESContext;
  BlockCount : LongInt;
begin
  InitEncryptDES(Key, Context, Encrypt);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptDES(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptDES(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptDES(Context, Block);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure DESEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey64;
                              Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TDESBlock;
  IV         : TDESBlock;
  Work       : TDESBlock;
  Context    : TDESContext;
  BlockCount : LongInt;
begin
  InitEncryptDES(Key, Context, Encrypt);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  if Encrypt then begin
    {set up an initialization vector (IV)}
    Block[0] := timeGetTime;
    Block[1] := timeGetTime;
    Block[2] := timeGetTime;
    Block[3] := timeGetTime;
    EncryptDES(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
    IV := Block;
  end else begin
    {read the frist block to prime the IV}
    InStream.Read(Block, SizeOf(Block));
    Dec(BlockCount);
    IV := Block;
  end;

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);

    if Encrypt then begin
      EncryptDESCBC(Context, IV, Block);
      IV := Block;
    end else begin
      Work := Block;
      EncryptDESCBC(Context, IV, Block);
      IV := Work;
    end;

    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptDESCBC(Context, IV, Block);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptDESCBC(Context, IV, Block);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure LBCEncryptFile(const InFile, OutFile : string; Key : TKey128;
                        Rounds : LongInt; Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      LBCEncryptStream(InStream, OutStream, Key, Rounds, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure LBCEncryptFileCBC(const InFile, OutFile : string; Key : TKey128;
                            Rounds : LongInt; Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      LBCEncryptStreamCBC(InStream, OutStream, Key, Rounds, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure LBCEncryptStream(InStream, OutStream : TStream; Key : TKey128;
                          Rounds : LongInt; Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TLBCBlock;
  Context    : TLBCContext;
  BlockCount : LongInt;
begin
  InitEncryptLBC(Key, Context, Rounds, Encrypt);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptLBC(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptLBC(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptLBC(Context, Block);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure LBCEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128;
                             Rounds : LongInt; Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TLBCBlock;
  IV         : TLBCBlock;
  Work       : TLBCBlock;
  Context    : TLBCContext;
  BlockCount : LongInt;
begin
  InitEncryptLBC(Key, Context, Rounds, Encrypt);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  if Encrypt then begin
    {set up an initialization vector (IV)}
    Block[0] := timeGetTime;
    Block[1] := timeGetTime;
    Block[2] := timeGetTime;
    Block[3] := timeGetTime;
    EncryptLBC(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
    IV := Block;
  end else begin
    {read the frist block to prime the IV}
    InStream.Read(Block, SizeOf(Block));
    Dec(BlockCount);
    IV := Block;
  end;

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);

    if Encrypt then begin
      EncryptLBCCBC(Context, IV, Block);
      IV := Block;
    end else begin
      Work := Block;
      EncryptLBCCBC(Context, IV, Block);
      IV := Work;
    end;

    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptLBCCBC(Context, IV, Block);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptLBCCBC(Context, IV, Block);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure LQCEncryptFile(const InFile, OutFile : string; Key : TKey128;
                         Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      LQCEncryptStream(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure LQCEncryptFileCBC(const InFile, OutFile : string; Key : TKey128;
                            Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      LQCEncryptStreamCBC(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure LQCEncryptStream(InStream, OutStream : TStream; Key : TKey128;
                           Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TLQCBlock;
  BlockCount : LongInt;
begin
  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptLQC(Key, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptLQC(Key, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptLQC(Key, Block, Encrypt);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure LQCEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128;
                              Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TLQCBlock;
  IV         : TLQCBlock;
  Work       : TLQCBlock;
  BlockCount : LongInt;
begin
  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  if Encrypt then begin
    {set up an initialization vector (IV)}
    Block[0] := timeGetTime;
    Block[1] := timeGetTime;
    EncryptLQC(Key, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
    IV := Block;
  end else begin
    {read the frist block to prime the IV}
    InStream.Read(Block, SizeOf(Block));
    Dec(BlockCount);
    IV := Block;
  end;

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);

    if Encrypt then begin
      EncryptLQCCBC(Key, IV, Block, Encrypt);
      IV := Block;
    end else begin
      Work := Block;
      EncryptLQCCBC(Key, IV, Block, Encrypt);
      IV := Work;
    end;

    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptLQCCBC(Key, IV, Block, Encrypt);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptLQCCBC(Key, IV, Block, Encrypt);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure LSCEncryptFile(const InFile, OutFile : string; const Key; KeySize : Integer);
var
  Context   : TLSCContext;
  InStream  : TStream;
  OutStream : TStream;
  BytesRead : LongInt;
  Buf       : array[1..2048] of Byte;
begin
  InitEncryptLSC(Key, KeySize, Context);
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      repeat
        BytesRead := InStream.Read(Buf, SizeOf(Buf));
        if BytesRead > 0 then begin
          EncryptLSC(Context, Buf, BytesRead);
          OutStream.WriteBuffer(Buf, BytesRead);
        end;
      until BytesRead < SizeOf(Buf);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure RNG32EncryptFile(const InFile, OutFile : string; Key : LongInt);
var
  Context   : TRNG32Context;
  InStream  : TStream;
  OutStream : TStream;
  BytesRead : LongInt;
  Buf       : array[1..2048] of Byte;
begin
  InitEncryptRNG32(Key, Context);
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      repeat
        BytesRead := InStream.Read(Buf, SizeOf(Buf));
        if BytesRead > 0 then begin
          EncryptRNG32(Context, Buf, BytesRead);
          OutStream.WriteBuffer(Buf, BytesRead);
        end;
      until BytesRead < SizeOf(Buf);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure RNG64EncryptFile(const InFile, OutFile : string; KeyHi, KeyLo : LongInt);
var
  Context   : TRNG64Context;
  InStream  : TStream;
  OutStream : TStream;
  BytesRead : LongInt;
  Buf       : array[1..2048] of Byte;
begin
  InitEncryptRNG64(KeyHi, KeyLo, Context);
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      repeat
        BytesRead := InStream.Read(Buf, SizeOf(Buf));
        if BytesRead > 0 then begin
          EncryptRNG64(Context, Buf, BytesRead);
          OutStream.WriteBuffer(Buf, BytesRead);
        end;
      until BytesRead < SizeOf(Buf);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure TripleDESEncryptFile(const InFile, OutFile : string; Key : TKey128;
                                Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      TripleDESEncryptStream(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure TripleDESEncryptFileCBC(const InFile, OutFile : string; Key : TKey128;
                                   Encrypt : Boolean);
var
  InStream, OutStream : TStream;
begin
  InStream := TFileStream.Create(InFile, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(OutFile, fmCreate);
    try
      TripleDESEncryptStreamCBC(InStream, OutStream, Key, Encrypt);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure TripleDESEncryptStream(InStream, OutStream : TStream; Key : TKey128;
                                  Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TDESBlock;
  Context    : TTripleDESContext;
  BlockCount : LongInt;
begin
  InitEncryptTripleDES(Key, Context, Encrypt);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptTripleDES(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptTripleDES(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptTripleDES(Context, Block);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;

procedure TripleDESEncryptStreamCBC(InStream, OutStream : TStream; Key : TKey128;
                                    Encrypt : Boolean);
var
  I          : LongInt;
  Block      : TDESBlock;
  IV         : TDESBlock;
  Work       : TDESBlock;
  Context    : TTripleDESContext;
  BlockCount : LongInt;
begin
  InitEncryptTripleDES(Key, Context, Encrypt);

  {get the number of blocks in the file}
  BlockCount := (InStream.Size div SizeOf(Block));

  if Encrypt then begin
    {set up an initialization vector (IV)}
    Block[0] := timeGetTime;
    Block[1] := timeGetTime;
    Block[2] := timeGetTime;
    Block[3] := timeGetTime;
    EncryptTripleDES(Context, Block);
    OutStream.Write(Block, SizeOf(Block));
    IV := Block;
  end else begin
    {read the frist block to prime the IV}
    InStream.Read(Block, SizeOf(Block));
    Dec(BlockCount);
    IV := Block;
  end;

  {when encrypting, make sure we have a block with at least one free}
  {byte at the end. used to store the odd byte count value}
  if Encrypt then
    Inc(BlockCount);

  {process all except the last block}
  for I := 1 to BlockCount - 1 do begin
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);

    if Encrypt then begin
      EncryptTripleDESCBC(Context, IV, Block);
      IV := Block;
    end else begin
      Work := Block;
      EncryptTripleDESCBC(Context, IV, Block);
      IV := Work;
    end;

    OutStream.Write(Block, SizeOf(Block));
  end;

  if Encrypt then begin
    FillChar(Block, SizeOf(Block), #0);

    {set actual number of bytes to read}
    I := (InStream.Size mod SizeOf(Block));
    if InStream.Read(Block, I) <> I then
      raise ECipherException.Create(SInvalidFileFormat);

    {store number of bytes as last byte in last block}
    PByteArray(@Block)^[SizeOf(Block)-1] := I;

    {encrypt and save full block}
    EncryptTripleDESCBC(Context, IV, Block);
    OutStream.Write(Block, SizeOf(Block));
  end else begin
    {encrypted file is always a multiple of the block size}
    if InStream.Read(Block, SizeOf(Block)) <> SizeOf(Block) then
      raise ECipherException.Create(SInvalidFileFormat);
    EncryptTripleDESCBC(Context, IV, Block);

    {get actual number of bytes encoded}
    I := PByteArray(@Block)^[SizeOf(Block)-1];

    {save valid portion of block}
    OutStream.Write(Block, I);
  end;
end;


end.