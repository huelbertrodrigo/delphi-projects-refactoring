program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
//  Horse.Jhonson,
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
  Entity.Person in '..\entities\Entity.Person.pas',
  Controller.Person in 'controllers\Controller.Person.pas',
  Repository.Person in 'repositories\Repository.Person.pas';

procedure GetHome(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
begin
  Res.Send('Server is runing');
end;

procedure GetListen(Horse: THorse);
var
  FConnection: IDBConnection;
  FManager: IDatabaseCompare;
begin
  try
    DMConnection := TDMConnection.Create(nil);

    FConnection := TFactoryZeos.Create(DMConnection.ZConnection, DMConnection.dbDriver);

    FManager := TModelDbCompare.Create(FConnection);
    FManager.CommandsAutoExecute := True;
    FManager.BuildDatabase;
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
//    .Use(Jhonson)
    .Use(Compression());

  THorse.Get('/', GetHome);

  Controller.Person.Registry;

  THorse.Listen(5000, GetListen);
end.

