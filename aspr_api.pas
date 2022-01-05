unit aspr_api;

interface

uses
  Windows;


type

  //' Mode status

  TModeStatus = packed record
    ModeID           : Byte;
    IsRegistered,
    IsKeyPresent,
    IsWrongHardwareID,
    IsKeyExpired,
    IsModeExpired,
    IsBlackListedKey,
    IsModeActivated  : Boolean;
  end;
  PModeStatus = ^TModeStatus;


function  GetRegistrationKeys: PChar; stdcall;

function  GetRegistrationInformation   ( ModeID : Byte; var Key : PChar; var Name : PChar ): Boolean; stdcall;

function  CheckKey                ( Key, Name : PChar; ModeStatus : PModeStatus ): Boolean; stdcall;

function  CheckKeyAndDecrypt      ( Key, Name : PChar; SaveKey: Boolean ): Boolean; stdcall;

function  GetKeyDate              (     ModeID : Byte;
                                    var Day    : WORD;
                                    var Month  : WORD;
                                    var Year   : WORD ): Boolean; stdcall;

function  GetKeyExpirationDate    (     ModeID : Byte;
                                    var Day    : WORD;
                                    var Month  : WORD;
                                    var Year   : WORD ): Boolean; stdcall;

function  GetTrialDays            (     ModeID : Byte;
                                    var Total  : DWORD;
                                    var Left   : DWORD ): Boolean; stdcall;

function  GetTrialExecs           (     ModeID : Byte;
                                    var Total  : DWORD;
                                    var Left   : DWORD ): Boolean; stdcall;

function  GetExpirationDate       (     ModeID : Byte;
                                    var Day    : WORD;
                                    var Month  : WORD;
                                    var Year   : WORD ): Boolean; stdcall;

function  GetModeInformation      (     ModeID     : Byte;
                                    var ModeName   : PChar;
                                    var ModeStatus : TModeStatus ): Boolean; stdcall;

function  GetHardwareID : PChar; stdcall;

function  SetUserKey              ( Key     : Pointer;
                                    KeySize : DWORD ): Boolean; stdcall;


implementation


const
  aspr_ide  = 'qtftpd.dll';


//------------------------------------------------------------------------------

function  GetRegistrationKeys: PChar; external aspr_ide name 'GetRegistrationKeys';

function  GetRegistrationInformation   ( ModeID : Byte; var Key : PChar; var Name : PChar ): Boolean; external aspr_ide name 'GetRegistrationInformation';

function  CheckKey                ( Key, Name : PChar; ModeStatus : PModeStatus ): Boolean; external aspr_ide name 'CheckKey';

function  CheckKeyAndDecrypt      ( Key, Name : PChar; SaveKey: Boolean ): Boolean; external aspr_ide name 'CheckKeyAndDecrypt';

function  GetKeyDate              (     ModeID : Byte;
                                    var Day    : WORD;
                                    var Month  : WORD;
                                    var Year   : WORD ): Boolean; external aspr_ide name 'GetKeyDate';

function  GetKeyExpirationDate    (     ModeID : Byte;
                                    var Day    : WORD;
                                    var Month  : WORD;
                                    var Year   : WORD ): Boolean; external aspr_ide name 'GetKeyExpirationDate';

function  GetTrialDays            (     ModeID : Byte;
                                    var Total  : DWORD;
                                    var Left   : DWORD ): Boolean; external aspr_ide name 'GetTrialDays';

function  GetTrialExecs           (     ModeID : Byte;
                                    var Total  : DWORD;
                                    var Left   : DWORD ): Boolean; external aspr_ide name 'GetTrialExecs';

function  GetExpirationDate       (     ModeID : Byte;
                                    var Day    : WORD;
                                    var Month  : WORD;
                                    var Year   : WORD ): Boolean; external aspr_ide name 'GetExpirationDate';

function  GetModeInformation      (     ModeID     : Byte;
                                    var ModeName   : PChar;
                                    var ModeStatus : TModeStatus ): Boolean; external aspr_ide name 'GetModeInformation';

function  GetHardwareID : PChar; external aspr_ide name 'GetHardwareID';

function  SetUserKey              ( Key     : Pointer;
                                    KeySize : DWORD ): Boolean; external aspr_ide name 'SetUserKey';

//------------------------------------------------------------------------------

end.