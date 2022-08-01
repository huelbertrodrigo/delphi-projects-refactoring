program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.Compression,
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
  uDMConnection in 'database\uDMConnection.pas' {DMConnection: TDataModule},
  Controller.Person in 'controllers\Controller.Person.pas',
  Service.Person in 'services\Service.Person.pas',
  Repository.Person in 'repositories\Repository.Person.pas',
  Entity.Person in 'entities\Entity.Person.pas';

procedure GetListen(Horse: THorse);
var
  Connection: IDBConnection;
  Manager: IDatabaseCompare;
begin
  try
    DMConnection := TDMConnection.Create(nil);

    Connection := TFactoryZeos.Create(DMConnection.ZConnection, DMConnection.dbDriver);

    Manager := TModelDbCompare.Create(Connection);
    Manager.CommandsAutoExecute := True;
    Manager.BuildDatabase;
  finally
    DMConnection.Free;
  end;

  Writeln(Format('Server is runing on %s:%d', [Horse.Host, Horse.Port]));
  Readln;
end;

begin
  {$IFDEF MSWINDOWS}
    IsConsole := False;
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse
    .Use(Jhonson)
    .Use(Compression());

  THorse.Get('/',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('Server is runing');
    end);

  Controller.Person.Registry;

  THorse.Listen(5000, GetListen);
end.

