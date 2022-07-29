program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,

  dbebr.factory.interfaces,
  dbebr.factory.zeos,

  dbcbr.database.interfaces,
  ormbr.modeldb.compare,

  dbcbr.ddl.generator.firebird,
  dbcbr.metadata.firebird,
  ormbr.dml.generator.firebird,

  dbcbr.ddl.generator.sqlite,
  dbcbr.metadata.sqlite,
  ormbr.dml.generator.sqlite,

  dbcbr.ddl.generator.postgresql,
  dbcbr.metadata.postgresql,
  ormbr.dml.generator.postgresql,

  ormbr.form.monitor,
  ormbr.server.horse,

  uDMConnection in 'database\uDMConnection.pas' {DMConnection: TDataModule},
  Entity.Person in '..\entities\Entity.Person.pas';

procedure GetHome(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
begin
  Res.Send('Server is runing');
end;

procedure GetListen(Horse: THorse);
var
  oConnection: IDBConnection;
  oManager: IDatabaseCompare;

  dbDriver: TDriverName;

  FRESTServerHorse: TRESTServerHorse;
begin
  dbDriver := dnFirebird;

  DMConnection := TDMConnection.Create(nil);
  DMConnection.dbDriver := dbDriver;

  oConnection := TFactoryZeos.Create(DMConnection.ZConnection, dbDriver);
  oManager := TModelDbCompare.Create(oConnection);
  oManager.CommandsAutoExecute := True;
  oManager.BuildDatabase;

  FRESTServerHorse := TRESTServerHorse.Create(oConnection, 'api/v1');

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

