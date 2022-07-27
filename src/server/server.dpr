program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  dbebr.factory.interfaces,
  dbebr.factory.zeos,
  dbcbr.database.compare,
  dbcbr.database.interfaces,
  dbcbr.ddl.commands,
  ormbr.modeldb.compare,
  dbcbr.ddl.generator.firebird,
  dbcbr.metadata.firebird,
  dbcbr.ddl.generator.sqlite,
  dbcbr.metadata.sqlite,
  dbcbr.ddl.generator.postgresql,
  dbcbr.metadata.postgresql,
  ormbr.dml.generator.firebird,
  ormbr.dml.generator.sqlite,
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
  oConnectionFirebird, oConnectionSQLite, oConnectionPostgreSQL: IDBConnection;
  oManagerFirebird, oManagerSQLite, oManagerPostgreSQL: IDatabaseCompare;
  cDDL: TDDLCommand;

  FRESTServerHorse: TRESTServerHorse;
begin
  DMConnection := TDMConnection.Create(nil);

  // Firebird
//  oConnectionFirebird := TFactoryZeos.Create(DMConnection.ZConnectionFirebird, dnFirebird);
//  oConnectionFirebird.DBOptions.StoreGUIDAsOctet(True);
//  oManagerFirebird := TModelDbCompare.Create(oConnectionFirebird);
//  oManagerFirebird.ComparerFieldPosition := True;
//  oManagerFirebird.CommandsAutoExecute := True;
//  oManagerFirebird.BuildDatabase;

  // SQLite
  oConnectionSQLite := TFactoryZeos.Create(DMConnection.ZConnectionSQLite, dnSQLite);
  oManagerSQLite := TModelDbCompare.Create(oConnectionSQLite);
  oManagerSQLite.CommandsAutoExecute := True;
  oManagerSQLite.BuildDatabase;

  // PostgreSQL
//  oConnectionPostgreSQL := TFactoryZeos.Create(DMConnection.ZConnectionPostgreSQL, dnPostgreSQL);
//  oManagerPostgreSQL := TModelDbCompare.Create(oConnectionPostgreSQL);
//  oManagerPostgreSQL.CommandsAutoExecute := True;
//  oManagerPostgreSQL.BuildDatabase;

  // ORMBr - REST Server Horse
  FRESTServerHorse := TRESTServerHorse.Create(nil, oConnectionSQLite);

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

