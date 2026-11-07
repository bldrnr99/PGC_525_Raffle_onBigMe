UNIT cUSBInterface;

INTERFACE

USES
  Windows, Messages;

CONST
  // the plugin manager DLL name...
  DLL_NAME = 'mcHID.dll';

  // DLL interface functions...
FUNCTION Connect(pHostWin: HWND): BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'Connect';
FUNCTION Disconnect: BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'Disconnect';
FUNCTION GetItem(pIndex: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetItem';
FUNCTION GetItemCount: UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetItemCount';
FUNCTION Read(pHandle: UINT; pData: pointer): BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'Read';
FUNCTION Write(pHandle: UINT; pData: pointer): BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'Write';
FUNCTION ReadEx(pVendorID, pProductID: UINT; pData: pointer): BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'ReadEx';
FUNCTION WriteEx(pVendorID, pProductID: UINT; pData: pointer): BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'WriteEx';

FUNCTION GetHandle(pVendorID, pProductID: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetHandle';
FUNCTION GetVendorID(pHandle: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetVendorID';
FUNCTION GetProductID(pHandle: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetProductID';
FUNCTION GetVersion(pHandle: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetVersion';
FUNCTION GetVendorName(pHandle: UINT; pText: LPSTR; pLen: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetVendorName';
FUNCTION GetProductName(pHandle: UINT; pText: LPSTR; pLen: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetProductName';
FUNCTION GetSerialNumber(pHandle: UINT; pText: LPSTR; pLen: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetSerialNumber';
FUNCTION GetInputReportLength(pHandle: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetInputReportLength';
FUNCTION GetOutputReportLength(pHandle: UINT): UINT; STDCALL; EXTERNAL DLL_NAME NAME 'GetOutputReportLength';

PROCEDURE SetReadNotify(pHandle: UINT; pValue: BOOL); STDCALL; EXTERNAL DLL_NAME NAME 'SetReadNotify';
FUNCTION IsReadNotifyEnabled(pHandle: UINT): BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'IsReadNotifyEnabled';

FUNCTION IsAvailable(pVendorID, pProductID: UINT): BOOL; STDCALL; EXTERNAL DLL_NAME NAME 'IsAvailable';

IMPLEMENTATION

END.
