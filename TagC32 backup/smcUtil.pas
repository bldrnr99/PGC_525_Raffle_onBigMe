unit smcUtil;
{$H+}  // serve per dire di usare LongStrings. ( è già di default ! )

// Contiene Routines di uso comune per SmartIdea !

// Unit di Utility e Criptazione Dati con routine LockBox.
// uso ShortString per le password perchè non saranno mai più lunghe
// di 256 char e così possono contenere anche $00, ovvero possono
// anche essere generate random e da AVR !
//

interface

uses
  SysUtils, Classes, Messages, Windows, Dialogs, TypInfo,
  smcLib1,      // Lbcipher,
  smcLib2,      // Lbclass,
  smcLib3,      // Lbproc,
                // STSTRL,  routine prese e inglobate in questa unit.
  smcType;      // ConstMsgType;

{.Z+}
type
  LStrRec = record
    AllocSize : Longint;
    RefCount  : Longint;
    Length    : Longint;
  end;

const
  StrOffset = SizeOf(LStrRec);
  DosDelimSet : set of Char = ['\', ':', #0];
  MaxFileLen  = 260;
{.Z-}

// utilità varie.
function  DriveReady(Drv: string) : Boolean;
function  ServiceRunning: boolean; // verifica solo SmartideaSrv.
function  OtherRunning(prog:string): boolean;    // Verifico se altre Smartidea utility running !
function  FirstSession(prog:string): boolean;    // Verifico sia una sola Sessione del programma !
procedure ErrorStdDialog(eMsg:string; eNum:integer);      // pop-up comune dei messaggi errore.
procedure PopupErrorMsg(errNum, errMsg: string);          //
procedure PopupDlgMsg(text: string; dlgType:TMsgDlgType); //
function  WindowsDirectory :string;        // usually  C:\Windows\
function  WinSystemDirectory :string;      // usually  C:\Windows\System
function  GetOperatingSystem : TOsVersion;    // costanti da 1 a 6 in smcType.
function  GetWindowsVersion : string;         // come sopra ma ritorna stringa.
function  IsStrANumber(const S: String): Boolean; // dice se stringa è un numerica
procedure GetEnumNameList(Pti: PTypeInfo; AList: TStrings; X: Integer); // Ricava Stringhe da Enum !
function  DecryptLine(DrvData:Shortstring):shortstring; // decripta le stringhe lette dal file .DRV che in realtà è un .HEX !



// criptazioni per Array.
function Crypt(dataLen: integer; NormalArr:TDataArr; Pwd: shortstring): TDataArr;
function Decrypt(dataLen: integer; CryptedArr:TDataArr; Pwd: shortstring): TDataArr;

// criptazioni per Stringhe short.
function CryptS(Data,Pwd: shortstring): shortstring;
function DecryptS(Data,Pwd: shortstring): shortstring;

// criptazioni per Stringhe lunghe come da SvCom con metodo/chiave fissa.
function DescrambleString(Value: string): string;
function ScrambleString(Value: string): string;

// criptazioni per Stringhe lunghe HexText per backup-restore EEprom AVR.
function CryptLString(str:string): string;
function DecryptLString(str:string): string;

// routine per conversioni, con scelta formato da usare per la stringa:
// ovvero str Normale o str Hexadecimal.
function String2Array(dataLen: integer; Str: Ansistring; HexStr: boolean):TDataArr;
function Array2String(dataLen: integer; Arr: TDataArr; HexStr: boolean): string;
function CastStrLen(Str: string; dataLen: integer): string;
function String2HexString(Str: shortstring; HexStr: boolean): string;
function Str2HexStr(Str: shortstring): string;
function HexString2String(StrHex: string; HexStr: boolean): shortstring;
function HexStr2Str(StrHex: string): shortstring;
function StrhexToShortStr(strhex: shortstring): shortstring;
// per fase criptazione decriptazione file DRV
function CharsToStrhex(dump: shortstring): shortstring;
function Hex2Bin(data: shortString):integer;

//  routines di supporto.
function HexToStr( H:byte ): shortstring;
function HexToStrL( H:string ): string;
function StrhexToInt( S:shortstring ): longint;
function StrLhexToInt( S:string ): longint;
function invert(orig:shortstring):shortstring;

// routines terze parti.
function CharStrL(C : AnsiChar; Len : Cardinal) : AnsiString;
  {-Return a string filled with the specified character.}
function PadChL(const S : AnsiString; C : AnsiChar; Len : Cardinal) : AnsiString;
  {-Pad a string on the right with a specified character.}
function PadL(const S : AnsiString; Len : Cardinal) : AnsiString;
  {-Pad a string on the right with spaces.}
function LeftPadChL(const S : AnsiString; C : AnsiChar; Len : Cardinal) : AnsiString;
  {-Pad a string on the left with a specified character.}
function StrChPosL(const P : AnsiString; C : AnsiChar; var Pos : Cardinal) : Boolean;
  {-Return the position of a specified character within a string.}
function StrStInsertL(const S1, S2 : AnsiString; Pos : Cardinal) : AnsiString;
  {-Insert a string into another string at a specified position.}
function StrStDeleteL(const S : AnsiString; Pos, Count : Cardinal) : AnsiString;
  {-Delete characters at a specified position in a string.}
function TrimTrailL(const S : AnsiString) : AnsiString;
  {-Return a string with trailing white space removed.}
function JustFilenameL(const PathName : AnsiString) : AnsiString;
  {-Return just the filename and extension of a pathname.}
function JustNameL(const PathName : AnsiString) : AnsiString;
  {-Return just the filename (no extension, path, or drive) of a pathname.}
function JustExtensionL(const Name : AnsiString) : AnsiString;
  {-Return just the extension of a pathname.}
function JustPathnameL(const PathName : AnsiString) : AnsiString;
  {-Return just the drive and directory portion of a pathname.}
function HasExtensionL(const Name : AnsiString; var DotPos : Cardinal) : Boolean;
  {-Determine if a pathname contains an extension and, if so, return the
    position of the dot in front of the extension.}

  {--------------- Word / Char manipulation -------------------------}

function CharExistsL(const S : AnsiString; C : AnsiChar) : Boolean;
  {-Determine whether a given character exists in a string. }

  {-------- General purpose string manipulation --------}

function CharStrS(C : AnsiChar; Len : Cardinal) : ShortString;
  {-Return a string filled with the specified character.}
function PadChS(const S : ShortString; C : AnsiChar; Len : Cardinal) : ShortString;
  {-Pad a string on the right with a specified character.}
function PadS(const S : ShortString; Len : Cardinal) : ShortString;
  {-Pad a string on the right with spaces.}
function LeftPadChS(const S : ShortString; C : AnsiChar; Len : Cardinal) : ShortString;
  {-Pad a string on the left with a specified character.}
function LeftPadS(const S : ShortString; Len : Cardinal) : ShortString;
  {-Pad a string on the left with spaces.}
function TrimLeadS(const S : ShortString) : ShortString;
  {-Return a string with leading white space removed.}
function TrimTrailS(const S : ShortString) : ShortString;
  {-Return a string with trailing white space removed.}
function TrimS(const S : ShortString) : ShortString;
  {-Return a string with leading and trailing white space removed.}
function TrimSpacesS(const S : ShortString) : ShortString;
  {-Return a string with leading and trailing spaces removed.}

var
    MCardIn, MCardOut   : TMetodo;  // usate per lanciare CardIO events in SmartC32 da HAL !

implementation

var
    Key             : TKey128;
    LSC1            : TLbSCStream;
    LSC2            : TLbSCStream;
    DataArr         : TDataArr; //  = array[1..maxArray] of char;
    SSK             : array[0..32-1] of Byte;
    hMutex          : THandle;  // per check single session.
    
//
//  *************   Cryptazione di SHORTSTRING    ****************
//
function CryptS(Data,Pwd: shortstring): shortstring;
var
    NormalArr,
    CryptedArr      : array[0..maxSArray] of Byte;
    CryptedStr      : shortstring;
    StringLength,I  : Integer;
begin
  { Uso solo array per evitare confusione con cryptazioni anche del
    byte di lunghezza quando si cryptano stringhe !}
  GenerateLMDKey(Key, SizeOf(Key), Pwd);
  { leggo la stringa originale: PlainText}
  StringLength := Length(Data);
  { metto in array solo parte utile di stringa, ovvero
    scarto il 1°byte che dà la lunghezza stringa !}
  for I := 0 to StringLength-1 do
    NormalArr[I] := byte(Data[I+1]);
  { Sia in WRITE che in READBUFFER uso Array. Verrà
    così semplicemente cryptato il numero di bytes
    caricati nell'array. }
  LSC1 := TLbSCStream.Create(Key, SizeOf(Key));
  LSC1.Write(NormalArr, StringLength);
  LSC1.Position := 0;
  LSC1.ReadBuffer(CryptedArr, StringLength);
  LSC1.Free;
  { ora travaso l'array cryptato in stringa: CipherText !}
  CryptedStr := '';
  for I := 0 to StringLength-1 do
    CryptedStr := CryptedStr + Chr(CryptedArr[I]);
  result := CryptedStr; { stringa valida per passaggio dati. Infatti solo
    il contenuto della stringa è cryptato, e non il byte di lunghezza !}
  { il travaso da array a stringa è corretto, ma non viene visualizzata
    tutta quando ci sono certi caratteri tipo $09, $00, ecc. A causa delle
    proprietà dei TEdit invece, se travaso l'array in quest'ultimi la
    visualizzazione è corretta e completa.
    Quindi per visualizzare è meglio TEdit, ma per passaggi da routine all'altra
    devo usare stringhe !  }
end {CryptS};

function DecryptS(Data,Pwd: shortstring): shortstring;
var
    CryptedArr,
    DecryptedArr    : array[0..maxSArray] of Byte;
    DecryptedStr    : shortstring;
    StringLength,I  : Integer;
begin
  GenerateLMDKey(Key, SizeOf(Key), Pwd);
  { premessa: ora ho la stringa il cui solo contenuto è cryptato.}
  StringLength := Length(Data);
  { quindi preparo l'array travasandovi solo il contenuto della stringa... }
  for I := 1 to StringLength do { ...evitando il 1°byte di lunghezza !     }
      CryptedArr[I-1] := byte(Data[I]);
  { ora che ho array posso WRITEBUFFER, del solo numero di bytes in array !}
  LSC2 := TLbSCStream.Create(Key, SizeOf(Key));
  LSC2.WriteBuffer(CryptedArr, StringLength);
  LSC2.Position := 0;
  LSC2.Read(DecryptedArr, StringLength);
  LSC2.Free;
  { ora ho l'array Decryptato, e lo travaso in
    una STRINGA che sarà proprio come quella Originale: PlainText !!! }
  DecryptedStr := '';
  for I := 0 to StringLength-1 do
    DecryptedStr := DecryptedStr + Chr(DecryptedArr[I]);
  { ora ho la STRINGA Originale: PlainText !!! }
  result := DecryptedStr; { stringa valida per passaggio dati. Infatti solo
    il contenuto della stringa è Decryptato, e non il byte di lunghezza !}
  { La visualizzazione in TEdit dovrebbe esser corretta in quanto la stringa
    è tornata ad essere quella originale. }
end {DecryptS};

//
//  *************   Cryptazione di ARRAY    ****************
//

function Crypt(dataLen: integer; NormalArr:TDataArr; Pwd: shortstring): TDataArr;
begin
  { Uso solo array per evitare confusione con cryptazioni anche del
    byte di lunghezza quando si cryptano Short-String o stringhe normali
    che vengono troncate se trovano 00h ! }
  GenerateLMDKey(Key, SizeOf(Key), Pwd);
  { Sia in WRITE che in READBUFFER uso Array. Verrà
    così semplicemente cryptato il numero di bytes
    caricati nell'array. }
  LSC1 := TLbSCStream.Create(Key, SizeOf(Key));
  LSC1.Write(NormalArr, dataLen);
  LSC1.Position := 0;
  LSC1.ReadBuffer(result, dataLen);
  LSC1.Free;
  { ora l'array è cryptato in result ! }
end {Crypt};

function Decrypt(dataLen: integer; CryptedArr:TDataArr; Pwd: shortstring): TDataArr;
begin
  GenerateLMDKey(Key, SizeOf(Key), Pwd);
  LSC2 := TLbSCStream.Create(Key, SizeOf(Key));
  LSC2.WriteBuffer(CryptedArr, dataLen);
  LSC2.Position := 0;
  LSC2.Read(result, dataLen);
  LSC2.Free;
  { ora l'array è Decryptato in result }
end {Decrypt};


// decrypta string S con chiave fissa.
function DescrambleString(Value: string): string;
var
    S         :   String;
    Bytes     :   PByteArray;
    i,j,b,e,n :   Integer;
begin
    result := '';
    if Value= '' then
        exit;
    S := Value;
    n:=Length(S) div 2;
    GetMem(Bytes,n);
    try
        for i:=0 to n-1 do
        begin
            Bytes[i]:=StrToInt('$'+S[2*i+2])*16+StrToInt('$'+S[2*i+1]);
            if i mod 2 = 0 then
                Bytes[i]:=Bytes[i] xor SSK[(i+21) mod 31];
            if i mod 3 = 2 then begin
                j:=Bytes[i] + SSK[(i*3+16) mod 31];
                if j > 255 then j:=j-256;
                Bytes[i]:=j;
            end;
        end;
        for i:=0 to n-1  do
            Bytes[i]:=Bytes[i] xor SSK[i mod 31];
        b:=((bytes[0]*256+bytes[2])*256+bytes[7])*256+bytes[6];
        e:=((bytes[5]*256+bytes[1])*256+bytes[3])*256+bytes[4];
        S:='';
        for i:=b to e do
            S:=S+Char(Bytes[i]);
        Result := S;
    finally
        FreeMem(Bytes);
    end;
end;

// Crypta string S con chiave fissa.
function ScrambleString(Value: string): string;
var
    S         :   String;
    Bytes     :   PByteArray;
    i,j,b,e,n :   Integer;
begin
    if Value= '' then begin
        result := '';
        exit;
    end;
    b:=Round(Random(12))+9;
    e:=b+Length(Value)-1;
    n:=Round(Random(12))+2+e;
    GetMem(Bytes,n);
    try
        for i:=0 to n-1 do
            Bytes[i]:=Round(Random(255));
        bytes[0]:=(b shr 24)  and $FF;
        bytes[4]:=e           and $FF;
        bytes[1]:=(e shr 16)  and $FF;
        bytes[7]:=(b shr 8)   and $FF;
        bytes[5]:=(e shr 24)  and $FF;
        bytes[2]:=(b shr 16)  and $FF;
        bytes[6]:=b           and $FF;
        bytes[3]:=(e shr 8)   and $FF;
        S := Value;
        for i:=b to e do
            Bytes[i]:=Ord(S[i-b+1]);
        for i:=0 to n-1 do
            Bytes[i]:=Bytes[i] xor SSK[i mod 31];
        SetLength(S,n*2);
        for i:=0 to n-1 do
        begin
            if i mod 3 = 2 then
            begin
                j:=Bytes[i] - SSK[(i*3+16) mod 31];
                if j < 0 then j:=j+256;
                Bytes[i]:=j;
            end;
            if i mod 2 = 0 then
                Bytes[i]:=Bytes[i] xor SSK[(i+21) mod 31];
            S[2*i+2]:=IntToHex((Bytes[i] shr 4) and $F,1)[1];
            S[2*i+1]:=IntToHex((Bytes[i]      ) and $F,1)[1];
        end;
    finally
        FreeMem(Bytes);
    end;
    Result := S;
end;

function CryptLString(str:string): string;
var
    l: integer;
begin
    // La stringa in input è stata letta da EEprom AVR con formato DataAs=HexString
    // perchè la SystemArea contiene sicuramente bytes a $00 !
    l := length(str);
    //             string -> Array-> |Crypta| -> Array -> DoubleString  !
    DataArr := String2Array(l, str, false);
    DataArr  :=  Crypt(l, DataArr, kDrvPassword2+kDrvPassword+kDrvPassword3);
    // ora però come risultato della criptazione l'array cryptato contiene
    // anche $0D, $00, ecc.  quindi, siccome deve essere salvato su file (come stringa !)
    // và convertito ancora in stringa Hex !
    result := Array2String(l, DataArr, true); // true=tratta come hex string.(doppia lun.)
end;

function DecryptLString(str:string): string;
var
    l: integer;
begin
    // Routine per decriptare stringa salvata su file, relativa al backup di EEprom.
    // la stringa in input (da decryptare) è di tipo HexStr quindi lunga il doppio
    // della originale.
    // Infatti, potendo essere composta anche da $00, la si è dovuta convertire
    // in HexString. Quindi ora processo inverso.
    // 	             String -> Array/2 -> |Decrypta| -> Array -> String  !
    l := length(str) div 2;
    DataArr := String2Array(l, str, true); // true=tratta come hex string.(doppia lun.)
    DataArr := Decrypt(l, DataArr, kDrvPassword2+kDrvPassword+kDrvPassword3);
    // L'array decriptato NON contiene sicuramente $00 perchè in origine
    // era stato letto da EEprom con DataAs=HexString quindi...
    result := Array2String(l, DataArr, false); //... travaso con false !
    // il risultato verrà scritto direttamente in EEprom AVR con DataAs=HexString !
end;


//**********************  Converte una STRINGA in un ARRAY  *******************************
// gli array sono dichiarati a base 1 in ConstMsgType.pas
// L'array passato come argomento è del tipo comune a tutti i moduli SmartIdea
// dichiarato in ConstMsgType con base 1,
// Quindi gli indici per manipolarlo devono sempre essere nel range 1..N  !!!
// Anche per le long stringhe l'indice è sempre 1..N !
function String2Array(dataLen:integer; Str:Ansistring; HexStr:boolean):TDataArr;
var
    j: integer;
begin
  // Carica la Stringa in DataArr[], e a seconda di HexStr la converte anche.
  // Mi faccio passare datalen, anziche calcolarmi length(str), perchè mi serve
  // per sapere a che lunghezza Castare la stringa in arrivo; infatti l'utente può
  // anche aver passato una stringa più lunga o corta del previsto.
  if HexStr then begin
      // passaggio da stringa doppia ad array con lunghezza normale, 2 a 1.
      // NB: in questo caso datalen è già la metà di Str ! quindi ok per for-next.
      CastStrLen(Str, dataLen*2);
      for j := 1 to dataLen do
          result[j] := Ansichar(StrhexToInt(copy(Str, j*2-1, 2)));
      end
  else begin
      // passaggio diretto da stringa ad array, 1 a 1.
      CastStrLen(Str, dataLen);
      for j := 1 to datalen do
          result[j] := Str[j];
  end;
end;
//////  Converte un ARRAY  in  Stringa  ///////
function Array2String(dataLen: integer; Arr:TDataArr; HexStr:boolean): string;
var
    j: word;
begin
    // carica DataArr[] in Stringa, e a seconda di HexStr, la converte anche;
    // quindi la stringa risultante nasce già con lunghezza corretta.
    result := '';
    if HexStr then
        // passaggio da array a stringa, con lunghezza doppia; visto che l'array
        // viene convertito in stringa esadecimale !
        for j := 1 to dataLen do
            result := result + HexToStr(byte(Arr[j]))
    else
        // passaggio diretto da array a stringa.
        for j := 1 to dataLen do
            result := result + Arr[j];
end;
// routine di supporto: setta la lunghezza stringa, troncandola o padding con blank.
function CastStrLen(Str: string; dataLen: integer): string;
begin
    if length(Str) > dataLen then
        result := copy(Str, 1, dataLen)  // se maggiore la tronca.
    else
        result := PadChL(Str, ' ', dataLen); // altrimenti invariata o pad con blanks a dx.
end;

///////  travasa  Shortstring[8] in String secondo DataAs.  ////////////
function String2HexString(Str: shortstring; HexStr: boolean): string;
var  // si presume che le stringhe siano sempre di 8/16 bytes !!!!!
   j: integer;        // restituisco sempre String perchè così serve al chiamante !
begin
    result := '';
    if HexStr then    // conversione a stringa con lunghezza doppia perchè Hex.
        for j := 1 to 8 do                            // in 1:2 out !
            result := result + HexToStr(byte(Str[j])) // input(2) $C0+$B4 -> output(4) 'C0B4'
    else              // nessuna conversione;
        result := Str;// cambia solo il tipo di stringa.  // in 1:1 out !
end;
///////  travasa  Shortstring fino 255 char in String  ////////////
function Str2HexStr(Str: shortstring): string;
var  // come sopra ma senza dataAs e svincolo da lunghezza.
   j: integer;
begin                     // in 1:2 out !
    result := '';         // input(2) $C0+$B4 -> output(4) 'C0B4'
    for j := 1 to length(Str) do
        result := result + HexToStr(byte(Str[j]))
end;

///////  travasa String/Short in Shortstring[8] secondo DataAs.  ////////////
function HexString2String(StrHex: string; HexStr: boolean): shortstring;
var  // si presume che le stringhe siano sempre di 8/16 bytes !!!!!
  j: integer;               // StrHex è short così non perdo eventuali $00 in input !
begin                       // Result è short perchè potrebbe restare uguale a input !
    result := '';        // in 2:1 out !
    if HexStr then          // Passaggio da stringaHex con lunghezza N perchè Hex,
        for j := 0 to 7 do  // a stringa a lunghezza dimezzata N/2.
            result := result + char(StrhexToInt(copy(StrHex,j*2+1,2))) // input(4) 'C0B4' -> output(2) $C0+$B4
    else                 // in 1:1 out !
        result := shortstring(StrHex); // Nessuna conversione; la stringa resta così com'è.
end;
function HexStr2Str(StrHex: string): shortstring; // in 2:1 out !
var       // input(4) 'C0B4' -> output(2) $C0+$B4
  j: integer;        // Result è short così non perdo eventuali $00 in output !
begin                // qui senza dataAs e vincolo lunghezza.
    result := '';    // Passaggio da stringaHex con lunghezza N perchè Hex,
    for j := 0 to (length(StrHex) div 2)-1 do  // a lunghezza dimezzata N/2.
        result := result + char(StrhexToInt(copy(StrHex,j*2+1,2)))
end;

// serve per fase decriptazione file drv
function StrhexToShortStr(strhex: shortstring): shortstring;
var
   i,l: integer;
   t: shortstring;
begin
    t := '';
    l := length(strhex) div 2;
    for i := 1 to l do
       t := t + char(StrhexToInt(copy(strhex,i*2-1,2)));
    result := t;
end;

// per fase criptazione file DRV
function CharsToStrhex(dump: shortstring): shortstring;
var
   i,l: integer;
   t: shortstring;
begin
    t := '';
    l := length(dump);
    for i := 1 to l do
       t := t + HexToStr(byte(dump[i]));
    result := t;
end;
function Hex2Bin(data: shortString):integer;
var
   i:     byte;
   w:     longint;
begin
     W := 0;
     for i := 1 to Length( data ) do
         begin
         case data[i] of
	      '0'..'9':  w := w *16 +(Ord(data[i]) -48);
              'A'..'F':  w := w *16 +(Ord(data[i]) -55);
              'a'..'f':  w := w *16 +(Ord(data[i]) -87);
         end;
         end;
     Hex2Bin := w;
end;


////////////////////////////////////////////////////////////////////////////////////////////

////////////////  routines di supporto.
function HexToStr( H:byte ): shortstring;               //   $2B  ->  '2B'
const
     Hex: shortstring = '0123456789ABCDEF';
var
     t0, t1: byte;
begin
     t0 := H shr 4;
     t1 := H and $0F;
     HexToStr := Hex[t0+1] + Hex[t1+1];
end;
function  HexToStrL( H:string ): string;                //   idem su long string
const
     Hex: string = '0123456789ABCDEF';
var
     t0, t1, b: byte;
begin
     if H = '' then
         HexToStrL := '00'
     else begin
         b := byte(H[1]);
         t0 := b shr 4;
         t1 := b and $0F;
         HexToStrL := Hex[t0+1] + Hex[t1+1];
     end;
end;

function StrhexToInt( S:shortstring ): longint;         //  'FFFE'    ->   65534 = $FFFE
var
   i:     byte;
   w:     longint;
begin
     W := 0;
     for i := 1 to Length( S ) do begin
         case S[i] of
	      '0'..'9':  w := w *16 +(Ord(S[i]) -48);
          'A'..'F':  w := w *16 +(Ord(S[i]) -55);
          'a'..'f':  w := w *16 +(Ord(S[i]) -87);
         end;
     end;
     StrhexToInt := w;
end;
function  StrLhexToInt( S:string ): longint;            //  idem su long string
var
   i:     byte;
   w:     longint;
begin
     W := 0;
     for i := 1 to Length( S ) do
         begin
         case S[i] of
	      '0'..'9':  w := w *16 +(Ord(S[i]) -48);
              'A'..'F':  w := w *16 +(Ord(S[i]) -55);
              'a'..'f':  w := w *16 +(Ord(S[i]) -87);
         end;
         end;
     StrLhexToInt := w;
end;

function invert(orig:shortstring):shortstring;
  var len: Byte absolute orig;
begin
    result := '';
    while (len > 0) do begin
      result := result + orig[len];
      Dec(len);
    end;
end;


  {-------- General purpose string manipulation --------}

function CharStrL(C : AnsiChar; Len : Cardinal) : AnsiString;
  {-Return a string filled with the specified character.}
begin
  SetLength(Result, Len);
  if Len <> 0 then begin
    {SetLength(Result, Len);}
    FillChar(Result[1], Len, C);
  end;
end;

function PadChL(const S : AnsiString; C : AnsiChar; Len : Cardinal) : AnsiString;
  {-Pad a string on the right with a specified character.}
begin
  if Length(S) >= LongInt(Len) then                                    {!!.D4}
    Result := S
  else begin
    SetLength(Result, Len);
    Move(S[1], Result[1], Length(S));
    FillChar(Result[Succ(Length(S))], LongInt(Len)-Length(S), C);      {!!.D4}
  end;
end;

function PadL(const S : AnsiString; Len : Cardinal) : AnsiString;
  {-Pad a string on the right with spaces.}
begin
  Result := PadChL(S, ' ', Len);
end;

function LeftPadChL(const S : AnsiString; C : AnsiChar; Len : Cardinal) : AnsiString;
  {-Pad a string on the left with a specified character.}
begin
  if Length(S) >= LongInt(Len) then                                    {!!.D4}
    Result := S
  else if Length(S) < MaxLongInt then begin
    SetLength(Result, Len);
    Move(S[1], Result[Succ(Word(Len))-Length(S)], Length(S));
    FillChar(Result[1], LongInt(Len)-Length(S), C);                    {!!.D4}
  end;
end;

function StrChPosL(const P : AnsiString; C : AnsiChar; var Pos : Cardinal) : Boolean;
  {-Return the position of a specified character within a string.}
asm
  push  ebx             { Save registers }
  push  edi

  or    eax, eax        { Protect against null string }
  jz    @@NotFound

  xor   edi, edi        { Zero counter }
  mov   ebx, [eax-StrOffset].LStrRec.Length  { Get input length }

@@Loop:
  inc   edi             { Increment counter }
  cmp   [eax], dl       { Did we find it? }
  jz    @@Found
  inc   eax             { Increment pointer }

  cmp   edi, ebx        { End of string? }
  jnz   @@Loop          { If not, loop }

@@NotFound:
  xor   eax, eax        { Not found, zero EAX for False }
  mov   [ecx], eax
  jmp   @@Done

@@Found:
  mov   [ecx], edi      { Set Pos }
  mov   eax, 1          { Set EAX to True }

@@Done:
  pop   edi             { Restore registers }
  pop   ebx
end;

function StrStInsertL(const S1, S2 : AnsiString; Pos : Cardinal) : AnsiString;
  {-Insert a string into another string at a specified position.}
begin
  Result := S1;
  System.Insert(S2, Result, Pos);
end;

function StrStDeleteL(const S : AnsiString; Pos, Count : Cardinal) : AnsiString;
  {-Delete characters at a specified position in a string.}
begin
  Result := S;
  System.Delete(Result, Pos, Count);
end;

function TrimTrailL(const S : AnsiString) : AnsiString;
  {-Return a string with trailing white space removed.}
begin
  Result := S;
  while (Length(Result) > 0) and (Result[Length(Result)] <= ' ') do
    SetLength(Result, Pred(Length(Result)));
end;

function JustFilenameL(const PathName : AnsiString) : AnsiString;
  {-Return just the filename and extension of a pathname.}
var
  I : Cardinal;
begin
  Result := '';
  if PathName = '' then Exit;
  I := Succ(Word(Length(PathName)));
  repeat
    Dec(I);
  until (PathName[I] in DosDelimSet) or (I = 0);
  Result := System.Copy(PathName, Succ(I), MaxFileLen);
end;

function JustNameL(const PathName : AnsiString) : AnsiString;
  {-Return just the filename (no extension, path, or drive) of a pathname.}
var
  DotPos : Cardinal;
  S      : AnsiString;
begin
  S := JustFileNameL(PathName);
  if HasExtensionL(S, DotPos) then
    S := System.Copy(S, 1, DotPos-1);
  Result := S;
end;

function JustExtensionL(const Name : AnsiString) : AnsiString;
  {-Return just the extension of a pathname.}
var
  DotPos : Cardinal;
begin
  if HasExtensionL(Name, DotPos) then
    Result := System.Copy(Name, Succ(DotPos), MaxFileLen)
  else
    Result := '';
end;

function JustPathnameL(const PathName : AnsiString) : AnsiString;
  {-Return just the drive and directory portion of a pathname.}
var
  I : Cardinal;
begin
  if PathName = '' then Exit;

  I := Succ(Word(Length(PathName)));
  repeat
    Dec(I);
  until (PathName[I] in DosDelimSet) or (I = 0);

  if I = 0 then
    {Had no drive or directory name}
    SetLength(Result, 0)
  else if I = 1 then
    {Either the root directory of default drive or invalid pathname}
    Result := PathName[1]
  else if (PathName[I] = '\') then begin
    if PathName[Pred(I)] = ':' then
      {Root directory of a drive, leave trailing backslash}
      Result := System.Copy(PathName, 1, I)
    else
      {Subdirectory, remove the trailing backslash}
      Result := System.Copy(PathName, 1, Pred(I));
  end else
    {Either the default directory of a drive or invalid pathname}
    Result := System.Copy(PathName, 1, I);
end;

function HasExtensionL(const Name : AnsiString; var DotPos : Cardinal) : Boolean;
  {-Determine if a pathname contains an extension and, if so, return the
    position of the dot in front of the extension.}
var
  I : Cardinal;
begin
  DotPos := 0;
  for I := Length(Name) downto 1 do
    if (Name[I] = '.') and (DotPos = 0) then
      DotPos := I;
  Result := (DotPos > 0)
    and not CharExistsL(System.Copy(Name, Succ(DotPos), MaxFileLen), '\');
end;

  {--------------- Word / Char manipulation -------------------------}

function CharExistsL(const S : AnsiString; C : AnsiChar) : Boolean; register;
  {-Count the number of a given character in a string. }
asm
  push  ebx
  xor   ecx, ecx
  or    eax, eax
  jz    @@Done
  mov   ebx, [eax-StrOffset].LStrRec.Length
  or    ebx, ebx
  jz    @@Done
  jmp   @@5

@@Loop:
  cmp   dl, [eax+3]
  jne   @@1
  inc   ecx
  jmp   @@Done

@@1:
  cmp   dl, [eax+2]
  jne   @@2
  inc   ecx
  jmp   @@Done

@@2:
  cmp   dl, [eax+1]
  jne   @@3
  inc   ecx
  jmp   @@Done

@@3:
  cmp   dl, [eax+0]
  jne   @@4
  inc   ecx
  jmp   @@Done

@@4:
  add   eax, 4
  sub   ebx, 4

@@5:
  cmp   ebx, 4
  jge   @@Loop

  cmp   ebx, 3
  je    @@1

  cmp   ebx, 2
  je    @@2

  cmp   ebx, 1
  je    @@3

@@Done:
  mov   eax, ecx
  pop   ebx
end;


  {-------- General purpose string manipulation --------}

function CharStrS(C : AnsiChar; Len : Cardinal) : ShortString;
  {-Return a string filled with the specified character.}
begin
  if Len = 0 then
    Result[0] := #0
  else begin
    Result[0] := AnsiChar(Len);
    FillChar(Result[1], Len, C);
  end;
end;

function PadChS(const S : ShortString; C : AnsiChar; Len : Cardinal) : ShortString;
  {-Pad a string on the right with a specified character.}
var
  SLen : Byte absolute S;
begin
  if Length(S) >= Len then
    Result := S
  else begin
    if Len > 255 then Len := 255;
    Result[0] := AnsiChar(Len);
    Move(S[1], Result[1], SLen);
    if SLen < 255 then
      FillChar(Result[Succ(SLen)], Len-SLen, C);
  end;
end;

function PadS(const S : ShortString; Len : Cardinal) : ShortString;
  {-Pad a string on the right with spaces.}
begin
  Result := PadChS(S, ' ', Len);
end;

function LeftPadChS(const S : ShortString; C : AnsiChar; Len : Cardinal) : ShortString;
  {-Pad a string on the left with a specified character.}
begin
  if Length(S) >= Len then
    Result := S
  else if Length(S) < 255 then begin
    if Len > 255 then Len := 255;
    Result[0] := AnsiChar(Len);
    Move(S[1], Result[Succ(Word(Len))-Length(S)], Length(S));
    FillChar(Result[1], Len-Length(S), C);
  end;
end;

function LeftPadS(const S : ShortString; Len : Cardinal) : ShortString;
  {-Pad a string on the left with spaces.}
begin
  Result := LeftPadChS(S, ' ', Len);
end;

function TrimLeadS(const S : ShortString) : ShortString;
  {-Return a string with leading white space removed}
var
  I : Cardinal;
begin
  I := 1;
  while (I <= Length(S)) and (S[I] <= ' ') do
    Inc(I);
  Move(S[I], Result[1], Length(S)-I+1);
  Result[0] := AnsiChar(Length(S)-I+1);
end;

function TrimTrailS(const S : ShortString) : ShortString;
  {-Return a string with trailing white space removed.}
begin
  Result := S;
  while (Length(Result) > 0) and (Result[Length(Result)] <= ' ') do
    Dec(Result[0]);
end;

function TrimS(const S : ShortString) : ShortString;
  {-Return a string with leading and trailing white space removed.}
var
  I    : Cardinal;
  SLen : Byte absolute Result;
begin
  Result := S;
  while (SLen > 0) and (Result[SLen] <= ' ') do
    Dec(SLen);

  I := 1;
  while (I <= SLen) and (Result[I] <= ' ') do
    Inc(I);
  Dec(I);
  if I > 0 then
    Delete(Result, 1, I);
end;

function TrimSpacesS(const S : ShortString) : ShortString;
  {-Return a string with leading and trailing spaces removed.}
var
  I    : Word;
begin
  Result := S;
  while (Length(Result) > 0) and (Result[Length(Result)] = ' ') do
    Dec(Result[0]);
  I := 1;
  while (I <= Length(Result)) and (S[I] = ' ') do
    Inc(I);
  Dec(I);
  if I > 0 then
    Delete(Result, 1, I);
end;

function WindowsDirectory :string;
var
  WinDir : PChar;
begin
  WinDir := StrAlloc(Max_Path);
  GetWindowsDirectory(WinDir,Max_Path);
  Result := String(WinDir);
  if Result[length(Result)]<>'\' then
    Result := Result+'\';
  StrDispose(WinDir);
end;
function WinSystemDirectory :string;
var
  WinSysDir : PChar;
begin
  WinSysDir := StrAlloc(Max_Path);
  GetSystemDirectory(WinSysDir,Max_Path);
  Result := String(WinSysDir);
  if Result[length(Result)]<>'\' then
    Result := Result+'\';
  StrDispose(WinSysDir);
end;

function GetWindowsVersion : string; // get the windows version...
var
  OsVinfo   : TOSVERSIONINFO;
  ver       : array[0..50] of char;
begin
  ZeroMemory(@OsVinfo,sizeOf(OsVinfo));
  OsVinfo.dwOSVersionInfoSize := sizeof(TOSVERSIONINFO);
  if GetVersionEx(OsVinfo) then begin
      if OsVinfo.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
          StrCopy(ver, '9598');
      if OsVinfo.dwPlatformId = VER_PLATFORM_WIN32_NT then
          StrCopy(ver, 'NT2K');
  end else
      StrCopy(ver, 'Error');
  Result := string(ver);
end;

function GetOperatingSystem : TOsVersion;
var
  osVerInfo    : TOSVersionInfo;
  majorVer, minorVer : Integer;
begin
  { set operating system type flag }
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(osVerInfo) then begin
   majorVer := osVerInfo.dwMajorVersion;
   minorVer := osVerInfo.dwMinorVersion;
    case osVerInfo.dwPlatformId of
      VER_PLATFORM_WIN32_NT : { Windows NT/2000 }
        begin
          if majorVer <= 4 then
            result := OsWinNT
          else if (majorVer = 5) AND (minorVer= 0) then
            result := OsWin2000
          else if (majorVer = 5) AND (minorVer = 1) then
            result := OsWinXP
          else
            result := OsUnknown;
        end;
      VER_PLATFORM_WIN32_WINDOWS :  { Windows 9x/ME }
        begin
          if (majorVer = 4) AND (minorVer = 0) then
            result := OsWin95
          else if (majorVer = 4) AND (minorVer = 10) then begin
            if osVerInfo.szCSDVersion[1] = 'A' then
              result := OsWin98SE
            else
              result := OsWin98;
          end
          else if (majorVer = 4) AND (minorVer = 90) then
            result := OsWinME
          else
            result := OsUnknown;
        end;
    else
      result := OsUnknown;
    end;
  end
  else
    result := OsUnknown;
end;
(*        valori originali:
     OsUnknown  = -1;
     OsWin95    =  0;
     OsWin98    =  1;
     OsWin98SE  =  2;
     OsWinME    =  3;
     OsWinNT    =  4;
     OsWin2000  =  5;
     OsWinXP    =  6;
*)

function IsStrANumber(const S: String): Boolean; 
var 
  P:PChar; 
begin 
  P:=PChar(S); 
  result:=False; 
  while P^ <> #0 do 
  begin 
    if not (P^ in ['0'..'9']) then exit; 
    inc(P); 
  end; 
  result:=True; 
end;

procedure GetEnumNameList(Pti: PTypeInfo; AList: TStrings; X: Integer);
(**********************************************************
 Will return in AList string version of an 
enumerated type less the first X characters . eg X = 4

          type
            eXORBuySell = (XOR_BUY, XOR_SELL);

 GetEnumNameList(TypeInfo(eXORBuySell), ComboBox1.Items, 4);

 Now  ComboBox1.Items[0] = 'BUY'
 and  ComboBox1.Items[1] = 'SELL'
************************************************************)
var
  I: Integer;
begin
  AList.Clear;
  with GetTypeData(pti)^ do
  for I := MinValue to MaxValue do
    AList.Add(Copy(GetEnumName(pti, I), X + 1, 255));
end;

procedure ErrorStdDialog(eMsg:string; eNum:integer);
begin // pop-up comune dei messaggi errore.
    MessageDlg(eMsg +#10#13+#10+#13+'* Sys-Error '+IfType+':'+inttostr(eNum)+' *', mtError, [mbOK], 0);
end;

procedure PopupErrorMsg(errNum, errMsg: string);
begin
    // pop-up centralizzato dei messaggi errore.
    MessageDlg(errMsg +#10#13+#10+#13+'* App-Error: '+errNum+' *', mtError, [mbOK], 0);
end;
procedure PopupDlgMsg(text: string; dlgType:TMsgDlgType);
begin
    // pop-up centralizzato di messaggi vari. Text deve contenere già le formattazioni.
    MessageDlg(text, dlgType, [mbOK], 0);
end;

function FirstSession(prog:string): boolean; // Verifico Solo single Session del programma !
begin
     result := true;
     hMutex := CreateMutex(nil,false, pchar(prog));
     if (hMutex<>0) and (GetLastError=ERROR_ALREADY_EXISTS) then begin
         CloseHandle(hMutex);
         MessageDlg('Program already running !', mtError, [mbOk],0);
         result := false;  //Application.terminate;
         exit;
     end;
     // Ora è attivato il mutex per utility chiamante !
     // Ultimo Mutex ad essere creato resta attivo (release in unit Finalization) !
end;

function OtherRunning(prog:string): boolean;// Verifico se altre Smartidea utility running
  // questa è una nested routine.           // E anche single Session !
  procedure DisplayMessage(S: string);
  begin
    if S = prog then
      MessageDlg('Program already running !', mtError, [mbOk],0)
    else
      MessageDlg(S+'  is running !'+#10#13+'please close it before using'+#10#13+
                 'this program !', mtError, [mbOk],0);
  end;
begin
     result := false;
     // verifiche altri programmi...  necessito situazione pulita !
     if ServiceRunning then begin
        DisplayMessage(kSmartService);
        result := true;  //application.terminate;
        exit;
     end;
     CloseHandle(hMutex);
     hMutex:=CreateMutex(nil, false, kSmcTests);
     if (hMutex<>0) and (GetLastError=ERROR_ALREADY_EXISTS) then begin
        CloseHandle(hMutex);
        DisplayMessage(kSmcTests);
        result := true;  //application.terminate;
        exit;      // non dovrebbe essere necessario, ma così è meglio !!!
     end;
     CloseHandle(hMutex);
     hMutex:=CreateMutex(nil,false, kInitHwAndCard);
     if (hMutex<>0) and (GetLastError=ERROR_ALREADY_EXISTS) then begin
        CloseHandle(hMutex);
        DisplayMessage(kInitHwAndCard);
        result := true;  //application.terminate;
        exit;
     end;
     CloseHandle(hMutex);
     hMutex:=CreateMutex(nil,false, kSmartSet);
     if (hMutex<>0) and (GetLastError=ERROR_ALREADY_EXISTS) then begin
        CloseHandle(hMutex);
        DisplayMessage(kSmartSet);
        result := true;  //application.terminate;
        exit;
     end;
     CloseHandle(hMutex);
     hMutex:=CreateMutex(nil,false, kCardBuilder);
     if (hMutex<>0) and (GetLastError=ERROR_ALREADY_EXISTS) then begin
        CloseHandle(hMutex);
        DisplayMessage(kCardBuilder);
        result := true;  //application.terminate;
        exit;
     end;
     CloseHandle(hMutex);
     hMutex:=CreateMutex(nil,false, kLoader);
     if (hMutex<>0) and (GetLastError=ERROR_ALREADY_EXISTS) then begin
        CloseHandle(hMutex);
        DisplayMessage(kLoader);
        result := true;  //application.terminate;
        exit;
     end;
     CloseHandle(hMutex);
     hMutex := CreateMutex(nil,false, pchar(prog));
     // Ora è attivato il mutex per utility chiamante !
end;

function ServiceRunning: boolean; // verifica se Smartidea Service in esecuzione.
var
    sMutex: THandle;
begin
    //  uso mutex, ma qui NON devo acquisirne l'Ownership , come in SmartC32 fra VCL concorrenti !
    //  Devo solo vedere se esiste già con una Open, senza bisogno di acquisirlo.
    if GetWindowsVersion = '9598' then begin  //  95 - 98 - ME
        sMutex := OpenMutex(MUTEX_ALL_ACCESS, false, kSmartService);//non voglio OwnerShip, quindi basterebbe Open anzichè Create !
        end
    else begin                               // NT - 2000 - XP
        sMutex := OpenMutex(Windows.SYNCHRONIZE, false, kSmartService);//non voglio OwnerShip, quindi basterebbe Open anzichè Create !
    end;
    if sMutex = 0 then
        // Service Stoppato
        result := false
    else// Mutex <> 0 ovvero Srv attivo !
        // Service Running
        result := true;
    CloseHandle(sMutex);
end;

function DriveReady(Drv: string) : Boolean;
var
  Oem : cardinal;
  Dw1,Dw2 : dword;
begin
  Oem := SetErrorMode(SEM_FAILCRITICALERRORS);
  if LENGTH(Drv) = 1 then Drv := Drv + ':\';
  Result := GetVolumeInformation(PCHAR(Drv), NIL,0,NIL, Dw1,Dw2, NIL,0);
  SetErrorMode(Oem);
end;

function DecryptLine(DrvData:Shortstring):shortstring;
var
  i,l: integer;
begin    // decripta le stringhe lette dal file .DRV che in realtà è un .HEX !
    DrvData := StrhexToShortStr(DrvData);
    // dopo riconversione in bytes, decrypto.
    l := length(DrvData);
    { call decryption function }
    for i := 1 to l do
        DataArr[i] := DrvData[i];
    DataArr := Decrypt(l, DataArr, kDrvPassword); // pwd è definita in ConstMsgType !
    result := '';
    for i := 1 to l do
        result  :=  result + DataArr[i];
end;



initialization

finalization
      ReleaseMutex(hMutex);  // release non necessario se ho usato False in CreateMutex().
      CloseHandle(hMutex);   // usati per unique session.

end.
