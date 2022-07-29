unit uDMConnection;

interface

uses
  System.SysUtils,
  System.Classes,
  ZConnection,
  ZAbstractConnection,
  dbebr.factory.interfaces;

type
  TDMConnection = class(TDataModule)
    ZConnection: TZConnection;
    procedure ZConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dbDriver: TDriverName;
  end;

var
  DMConnection: TDMConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDMConnection.ZConnectionBeforeConnect(Sender: TObject);
begin
  ForceDirectories('.\database\tmp\');

  if dbDriver = dnFirebird then
  begin
    ZConnection.Protocol := 'firebird';
    ZConnection.ClientCodepage := 'UTF8';
    ZConnection.HostName := 'localhost';
    ZConnection.Port := 3050;
    ZConnection.User := 'sysdba';
    ZConnection.Password := 'masterkey';
    ZConnection.Database := 'D:\Development\rascunhos\delphi-projects-refactoring\src\server\database\tmp\delphi-factoring.fdb';
    ZConnection.LibraryLocation := 'D:\Development\firebird 3\WOW64\fbclient.dll';
    if not FileExists(ZConnection.Database) then
      ZConnection.Properties.Add('CreateNewDatabase=true');
  end;

  if dbDriver = dnSQLite then
  begin
    ZConnection.Protocol := 'sqlite';
    ZConnection.ClientCodepage := 'UTF-8';
    ZConnection.Database := '.\database\tmp\delphi-factoring.db3';
    if not FileExists(ZConnection.Database) then
      ZConnection.Properties.Add('CreateNewDatabase=true');
  end;

  if dbDriver = dnPostgreSQL then
  begin
    ZConnection.Protocol := 'postgresql';
    ZConnection.ClientCodepage := 'UTF8';
    ZConnection.HostName := 'localhost';
    ZConnection.Port := 5432;
    ZConnection.User := 'postgres';
    ZConnection.Password := 'masterkey';
    ZConnection.Database := 'delphi-factoring';
  end;
end;

end.

