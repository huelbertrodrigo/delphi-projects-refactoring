unit Repository.Person;

interface

uses
  System.SysUtils,
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
    connection : IDBConnection;
    manager : TManagerObjectSet;
  public
    function listAll: TObjectList<TPerson>;
    function findOne(id: String): TPerson;
    procedure insert(person: TPerson);
    procedure update(id: String; person: TPerson);
    procedure delete(person: TPerson);

    constructor create;
    destructor destroy; override;
  end;

implementation

constructor TRepositoryPerson.create;
begin
  DMConnection := TDMConnection.Create(nil);
  Connection := TFactoryZeos.Create(DMConnection.ZConnection, DMConnection.dbDriver);
  Manager := TManagerObjectSet.Create(Connection);
end;

destructor TRepositoryPerson.destroy;
begin
  Connection.Disconnect;
  DMConnection.Free;
  inherited;
end;

function TRepositoryPerson.listAll: TObjectList<TPerson>;
begin
  result := Manager.AddAdapter<TPerson>.Find<TPerson>;
end;

function TRepositoryPerson.findOne(id: String): TPerson;
begin
  result := Manager.AddAdapter<TPerson>.Find<TPerson>(id);
end;

procedure TRepositoryPerson.insert(person: TPerson);
begin
  person.id := Copy(TGUID.NewGuid.ToString, 2, 36);
  Manager.AddAdapter<TPerson>.Insert<TPerson>(person);
end;

procedure TRepositoryPerson.update(id: String; person: TPerson);
var
  oldPerson: TPerson;
begin
  oldPerson := Manager.AddAdapter<TPerson>.Find<TPerson>(id);
  Manager.AddAdapter<TPerson>.Modify<TPerson>(oldPerson);
  Manager.AddAdapter<TPerson>.Update<TPerson>(person);
end;

procedure TRepositoryPerson.delete(person: TPerson);
begin
  Manager.AddAdapter<TPerson>.Delete<TPerson>(person);
end;

end.
