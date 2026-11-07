{*********************************************************}
{*                   LBCLASS.PAS 1.03                    *}
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

unit smcLib2;
  {-File and memory stream classes for the stream ciphers}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, SysUtils, smcLib1;

type
  {Memory Stream Cipher}
  TLbSCStream = class(TMemoryStream)
  protected {private}
    FContext : TLSCContext;
  protected
  public
    constructor Create(const Key; KeySize : Integer);
      {-create the stream and initialize context}
    procedure Reinitialize(const Key; KeySize : Integer);
      dynamic;
      {-reinitialize context and reposition to beginning of stream}
    procedure ChangeKey(const Key; KeySize : Integer);
      dynamic;
      {-reinitialize using a new key}
    function Read(var Buffer; Count : LongInt) : LongInt;
      override;
      {-read Count bytes into Buffer, return bytes read}
    function Write(const Buffer; Count : LongInt) : LongInt;
      override;
      {-write Count bytes to Buffer, return bytes written}
  end;

  {File Stream Cipher}
  TLbSCFileStream = class(TFileStream)
  protected {private}
    FContext : TLSCContext;
  protected
  public
    constructor Create(const FileName : string; Mode : Word; const Key; KeySize : Integer);
      {-create the stream and initialize context}
    procedure Reinitialize(const Key; KeySize : Integer);
      dynamic;
      {-reinitialize context and reposition to beginning of stream}
    procedure ChangeKey(const Key; KeySize : Integer);
      dynamic;
      {-reinitialize using a new key}
    function Read(var Buffer; Count : LongInt) : LongInt;
      override;
      {-read Count bytes into Buffer, return bytes read}
    function Write(const Buffer; Count : LongInt) : LongInt;
      override;
      {-write Count bytes to Buffer, return bytes written}
  end;

  {Random one-time pad using a 32-bit key (memory stream)}
  TLbRNG32Stream = class(TMemoryStream)
  protected {private}
    FContext : TRNG32Context;
  protected
  public
    constructor Create(const Key : LongInt);
      {-create the stream and initialize context}
    procedure Reinitialize(const Key : LongInt);
      dynamic;
      {-reinitialize context and reposition to beginning of stream}
    procedure ChangeKey(const Key : LongInt);
      dynamic;
      {-reinitialize using a new key}
    function Read(var Buffer; Count : LongInt) : LongInt;
      override;
      {-read Count bytes into Buffer, return bytes read}
    function Write(const Buffer; Count : LongInt) : LongInt;
      override;
      {-write Count bytes to Buffer, return bytes written}
  end;

  {Random one-time pad using a 32-bit key (file stream)}
  TLbRNG32FileStream = class(TFileStream)
  protected {private}
    FContext : TRNG32Context;
  protected
  public
    constructor Create(const FileName : string; Mode : Word; const Key : LongInt);
      {-create the stream and initialize context}
    procedure Reinitialize(const Key : LongInt);
      dynamic;
      {-reinitialize context and reposition to beginning of stream}
    procedure ChangeKey(const Key : LongInt);
      dynamic;
      {-reinitialize using a new key}
    function Read(var Buffer; Count : LongInt) : LongInt;
      override;
      {-read Count bytes into Buffer, return bytes read}
    function Write(const Buffer; Count : LongInt) : LongInt;
      override;
      {-write Count bytes to Buffer, return bytes written}
  end;

  {Random one-time pad using a 64-bit key (memory stream)}
  TLbRNG64Stream = class(TMemoryStream)
  protected {private}
    FContext : TRNG64Context;
  protected
  public
    constructor Create(const KeyHi, KeyLo : LongInt);
      {-create the stream and initialize context}
    procedure Reinitialize(const KeyHi, KeyLo : LongInt);
      dynamic;
      {-reinitialize context and reposition to beginning of stream}
    procedure ChangeKey(const KeyHi, KeyLo : LongInt);
      dynamic;
      {-reinitialize using a new key}
    function Read(var Buffer; Count : LongInt) : LongInt;
      override;
      {-read Count bytes into Buffer, return bytes read}
    function Write(const Buffer; Count : LongInt) : LongInt;
      override;
      {-write Count bytes to Buffer, return bytes written}
  end;

  {Random one-time pad using a 64-bit key (file stream)}
  TLbRNG64FileStream = class(TFileStream)
  protected {private}
    FContext : TRNG64Context;
  protected
  public
    constructor Create(const FileName : string; Mode : Word;
                       const KeyHi, KeyLo : LongInt);
      {-create the stream and initialize context}
    procedure Reinitialize(const KeyHi, KeyLo : LongInt);
      dynamic;
      {-reinitialize context and reposition to beginning of stream}
    procedure ChangeKey(const KeyHi, KeyLo : LongInt);
      dynamic;
      {-reinitialize using a new key}
    function Read(var Buffer; Count : LongInt) : LongInt;
      override;
      {-read Count bytes into Buffer, return bytes read}
    function Write(const Buffer; Count : LongInt) : LongInt;
      override;
      {-write Count bytes to Buffer, return bytes written}
  end;


implementation


{*** TLbSCStream ***}

constructor TLbSCStream.Create(const Key; KeySize : Integer);
begin
  inherited Create;

  Reinitialize(Key, KeySize);
end;

procedure TLbSCStream.Reinitialize(const Key; KeySize : Integer);
begin
  ChangeKey(Key, KeySize);
  Position := 0;
end;

procedure TLbSCStream.ChangeKey(const Key; KeySize : Integer);
begin
  InitEncryptLSC(Key, KeySize, FContext);
end;

function TLbSCStream.Read(var Buffer; Count : LongInt) : LongInt;
begin
  Result := inherited Read(Buffer, Count);
  EncryptLSC(FContext, Buffer, Count);
end;

function TLbSCStream.Write(const Buffer; Count : LongInt) : LongInt;
var
  Buf : Pointer;
begin
  GetMem(Buf, Count);
  try
    Move(Buffer, Buf^, Count);
    EncryptLSC(FContext, Buf^, Count);
    Result := inherited Write(Buf^, Count);
  finally
    FreeMem(Buf, Count);
  end;
end;


{*** TLbSCFileStream ***}

constructor TLbSCFileStream.Create(const FileName : string; Mode : Word;
                                 const Key; KeySize : Integer);
begin
  inherited Create(FileName, Mode);

  Reinitialize(Key, KeySize);
end;

procedure TLbSCFileStream.Reinitialize(const Key; KeySize : Integer);
begin
  ChangeKey(Key, KeySize);
  Position := 0;
end;

procedure TLbSCFileStream.ChangeKey(const Key; KeySize : Integer);
begin
  InitEncryptLSC(Key, KeySize, FContext);
end;

function TLbSCFileStream.Read(var Buffer; Count : LongInt) : LongInt;
begin
  Result := inherited Read(Buffer, Count);
  EncryptLSC(FContext, Buffer, Count);
end;

function TLbSCFileStream.Write(const Buffer; Count : LongInt) : LongInt;
var
  Buf : Pointer;
begin
  GetMem(Buf, Count);
  try
    Move(Buffer, Buf^, Count);
    EncryptLSC(FContext, Buf^, Count);
    Result := inherited Write(Buf^, Count);
  finally
    FreeMem(Buf, Count);
  end;
end;


{*** TLbRNG32Stream ***}

constructor TLbRNG32Stream.Create(const Key : LongInt);
begin
  inherited Create;

  Reinitialize(Key);
end;

procedure TLbRNG32Stream.Reinitialize(const Key : LongInt);
begin
  ChangeKey(Key);
  Position := 0;
end;

procedure TLbRNG32Stream.ChangeKey(const Key : LongInt);
begin
  InitEncryptRNG32(Key, FContext);
end;

function TLbRNG32Stream.Read(var Buffer; Count : LongInt) : LongInt;
begin
  Result := inherited Read(Buffer, Count);
  EncryptRNG32(FContext, Buffer, Count);
end;

function TLbRNG32Stream.Write(const Buffer; Count : LongInt) : LongInt;
var
  Buf : Pointer;
begin
  GetMem(Buf, Count);
  try
    Move(Buffer, Buf^, Count);
    EncryptRNG32(FContext, Buf^, Count);
    Result := inherited Write(Buf^, Count);
  finally
    FreeMem(Buf, Count);
  end;
end;


{*** TLbRNG32FileStream ***}

constructor TLbRNG32FileStream.Create(const FileName : string; Mode : Word;
                                       const Key : LongInt);
begin
  inherited Create(FileName, Mode);

  Reinitialize(Key);
end;

procedure TLbRNG32FileStream.Reinitialize(const Key : LongInt);
begin
  ChangeKey(Key);
  Position := 0;
end;

procedure TLbRNG32FileStream.ChangeKey(const Key : LongInt);
begin
  InitEncryptRNG32(Key, FContext);
end;

function TLbRNG32FileStream.Read(var Buffer; Count : LongInt) : LongInt;
begin
  Result := inherited Read(Buffer, Count);
  EncryptRNG32(FContext, Buffer, Count);
end;

function TLbRNG32FileStream.Write(const Buffer; Count : LongInt) : LongInt;
var
  Buf : Pointer;
begin
  GetMem(Buf, Count);
  try
    Move(Buffer, Buf^, Count);
    EncryptRNG32(FContext, Buf^, Count);
    Result := inherited Write(Buf^, Count);
  finally
    FreeMem(Buf, Count);
  end;
end;


{*** TLbRNG64Stream ***}

constructor TLbRNG64Stream.Create(const KeyHi, KeyLo : LongInt);
begin
  inherited Create;

  Reinitialize(KeyHi, KeyLo);
end;

procedure TLbRNG64Stream.Reinitialize(const KeyHi, KeyLo : LongInt);
begin
  ChangeKey(KeyHi, KeyLo);
  Position := 0;
end;

procedure TLbRNG64Stream.ChangeKey(const KeyHi, KeyLo : LongInt);
begin
  InitEncryptRNG64(KeyHi, KeyLo, FContext);
end;

function TLbRNG64Stream.Read(var Buffer; Count : LongInt) : LongInt;
begin
  Result := inherited Read(Buffer, Count);
  EncryptRNG64(FContext, Buffer, Count);
end;

function TLbRNG64Stream.Write(const Buffer; Count : LongInt) : LongInt;
var
  Buf : Pointer;
begin
  GetMem(Buf, Count);
  try
    Move(Buffer, Buf^, Count);
    EncryptRNG64(FContext, Buf^, Count);
    Result := inherited Write(Buf^, Count);
  finally
    FreeMem(Buf, Count);
  end;
end;


{*** TLbRNG64FileStream ***}

constructor TLbRNG64FileStream.Create(const FileName : string; Mode : Word;
                                       const KeyHi, KeyLo : LongInt);
begin
  inherited Create(FileName, Mode);

  Reinitialize(KeyHi, KeyLo);
end;

procedure TLbRNG64FileStream.Reinitialize(const KeyHi, KeyLo : LongInt);
begin
  ChangeKey(KeyHi, KeyLo);
  Position := 0;
end;

procedure TLbRNG64FileStream.ChangeKey(const KeyHi, KeyLo : LongInt);
begin
  InitEncryptRNG64(KeyHi, KeyLo, FContext);
end;

function TLbRNG64FileStream.Read(var Buffer; Count : LongInt) : LongInt;
begin
  Result := inherited Read(Buffer, Count);
  EncryptRNG64(FContext, Buffer, Count);
end;

function TLbRNG64FileStream.Write(const Buffer; Count : LongInt) : LongInt;
var
  Buf : Pointer;
begin
  GetMem(Buf, Count);
  try
    Move(Buffer, Buf^, Count);
    EncryptRNG64(FContext, Buf^, Count);
    Result := inherited Write(Buf^, Count);
  finally
    FreeMem(Buf, Count);
  end;
end;


end.