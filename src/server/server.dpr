program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  uDMConnection in 'database\uDMConnection.pas' {DMConnection: TDataModule};

procedure GetHome(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
begin
  Res.Send('Server is runing');
end;

procedure GetListen(Horse: THorse);
begin
  DMConnection := TDMConnection.Create(nil);

  Writeln(Format('Server is runing on %s:%d', [Horse.Host, Horse.Port]));
  Readln;
end;

begin
  {$IFDEF MSWINDOWS}
    IsConsole := False;
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse.Get('/', GetHome);

  THorse.Listen(5000, GetListen);
end.

