unit Service.Person;

interface

uses
  System.Generics.Collections,

  JSONBr,

  Entity.Person,
  Repository.Person;

function listAll: String;
function findOne(id: String): String;
function insert(data: String): String;
function update(id, data: String): String;
function delete(id: String): String;

implementation

function listAll: String;
var
  people: TObjectList<TPerson>;
  repository: TRepositoryPerson;
begin
  try
    repository := TRepositoryPerson.Create;
    people := Repository.listAll;
    result := TJSONBr.ObjectListToJsonString<TPerson>(people);
  finally
    people.Free;
    repository.Free;
  end;
end;

function findOne(id: String): String;
var
  person: TPerson;
  repository: TRepositoryPerson;
begin
  try
    repository := TRepositoryPerson.Create;
    person := Repository.findOne(id);
    result := TJSONBr.ObjectToJsonString(person);
  finally
    person.Free;
    repository.Free;
  end;
end;

function insert(data: String): String;
var
  person: TPerson;
  repository: TRepositoryPerson;
begin
  try
    repository := TRepositoryPerson.Create;
    person := TJSONBr.JsonToObject<TPerson>(data);
    repository.insert(person);
    result := 'Sucesso insert id = '+person.id;
  finally
    person.Free;
    repository.Free;
  end;
end;

function update(id, data: String): String;
var
  person: TPerson;
  repository: TRepositoryPerson;
begin
  try
    repository := TRepositoryPerson.Create;
    person := TJSONBr.JsonToObject<TPerson>(data);
    repository.update(id, person);
    result := 'Sucesso update id = '+id;
  finally
    person.Free;
    repository.Free;
  end;
end;

function delete(id: String): String;
var
  person: TPerson;
  repository: TRepositoryPerson;
begin
  try
    repository := TRepositoryPerson.Create;
    person := Repository.FindOne(id);
    repository.delete(person);
    result := 'Sucesso delete id = '+id;
  finally
    person.Free;
    repository.Free;
  end;
end;

end.
