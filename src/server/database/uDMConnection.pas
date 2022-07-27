unit uDMConnection;

interface

uses
  System.SysUtils,
  System.Classes,
  ZConnection,
  ZAbstractConnection;

type
  TDMConnection = class(TDataModule)
    ZConnectionSQLite: TZConnection;
    ZConnectionPostgreSQL: TZConnection;
    ZConnectionFirebird: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConnection: TDMConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDMConnection.DataModuleCreate(Sender: TObject);
begin
  ForceDirectories('.\database\tmp\');

  // Firebird
  ZConnectionFirebird.Protocol := 'firebird';
  ZConnectionFirebird.ClientCodepage := 'UTF8';
  ZConnectionFirebird.HostName := 'localhost';
  ZConnectionFirebird.Port := 3050;
  ZConnectionFirebird.User := 'sysdba';
  ZConnectionFirebird.Password := 'masterkey';
  ZConnectionFirebird.Database := 'D:\Development\rascunhos\delphi-projects-refactoring\src\server\database\tmp\database.fdb';
  ZConnectionFirebird.LibraryLocation := 'D:\Development\firebird 3\WOW64\fbclient.dll';
  if not FileExists(ZConnectionFirebird.Database) then
    ZConnectionFirebird.Properties.Add('CreateNewDatabase=true');

  // SQLite
  ZConnectionSQLite.Protocol := 'sqlite';
  ZConnectionSQLite.ClientCodepage := 'UTF-8';
  ZConnectionSQLite.Database := '.\database\tmp\database.sqlite';
  if not FileExists(ZConnectionSQLite.Database) then
    ZConnectionSQLite.Properties.Add('CreateNewDatabase=true');

  // PostgreSQL
  ZConnectionPostgreSQL.Protocol := 'postgresql';
  ZConnectionPostgreSQL.ClientCodepage := 'UTF8';
  ZConnectionPostgreSQL.HostName := 'localhost';
  ZConnectionPostgreSQL.Port := 5432;
  ZConnectionPostgreSQL.User := 'postgres';
  ZConnectionPostgreSQL.Password := 'masterkey';
  ZConnectionPostgreSQL.Database := 'delphi-factoring';
//  ZConnectionFirebird.LibraryLocation := 'D:\Development\firebird 3\WOW64\fbclient.dll';
end;

end.

