unit uDMConnection;

interface

uses
  System.SysUtils,
  System.Classes,
  ZConnection,
  ZAbstractConnection;

type
  TDMConnection = class(TDataModule)
    ZConnection: TZConnection;
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
  ZConnection.Protocol := 'sqlite';
  ZConnection.Database := '.\database\tmp\database.sqlite';
  if not FileExists(ZConnection.Database) then
  begin
    ForceDirectories(ExtractFilePath(ZConnection.Database));
    ZConnection.Properties.Add('CreateNewDatabase=true');
  end;

  ZConnection.Connected := True;
end;

end.

