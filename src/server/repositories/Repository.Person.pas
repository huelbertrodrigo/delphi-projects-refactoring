unit Repository.Person;

interface

uses
  System.Generics.Collections,

  ZConnection,
  ZAbstractConnection,

  dbebr.factory.interfaces,
  dbebr.factory.zeos,

  ormbr.manager.objectset,

  uDMConnection,
  Entity.Person;

type TRepositoryPerson = class
  private
    FConnection : IDBConnection;
    FManager : TManagerObjectSet;
  public
    function ListAll: TObjectList<TPerson>;
    function FindOne(AId: Integer): TPerson;
    procedure Insert(APerson: TPerson);
    procedure Update(APerson: TPerson);
    procedure Delete(APerson: TPerson);

    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TRepositoryPerson.Create;
begin
  DMConnection := TDMConnection.Create(nil);
  FConnection := TFactoryZeos.Create(DMConnection.ZConnection, DMConnection.dbDriver);
  FManager := TManagerObjectSet.Create(FConnection);
end;

destructor TRepositoryPerson.Destroy;
begin
  FConnection.Disconnect;
  DMConnection.Free;
  inherited;
end;

function TRepositoryPerson.ListAll: TObjectList<TPerson>;
begin
  Result := FManager.AddAdapter<TPerson>.Find<TPerson>;
end;

function TRepositoryPerson.FindOne(AId: Integer): TPerson;
begin
  Result := FManager.AddAdapter<TPerson>.Find<TPerson>(AId);
end;

procedure TRepositoryPerson.Insert(APerson: TPerson);
begin
  FManager.AddAdapter<TPerson>.Insert<TPerson>(APerson);
end;

procedure TRepositoryPerson.Update(APerson: TPerson);
var
  MPerson: TPerson;
begin
  MPerson := FManager.AddAdapter<TPerson>.Find<TPerson>(APerson.id);
  FManager.AddAdapter<TPerson>.Modify<TPerson>(MPerson);
  FManager.AddAdapter<TPerson>.Update<TPerson>(APerson);
end;

procedure TRepositoryPerson.Delete(APerson: TPerson);
begin
  FManager.AddAdapter<TPerson>.Delete<TPerson>(APerson);
end;

end.
