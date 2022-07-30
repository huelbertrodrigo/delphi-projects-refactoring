unit Controller.Person;

interface

uses
  System.Generics.Collections,

  Horse,
  JSONBr,

  Entity.Person,
  Repository.Person;

procedure Registry;

implementation

procedure ListAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LPerson: TObjectList<TPerson>;
  LRepository: TRepositoryPerson;
begin
  try
    LRepository := TRepositoryPerson.Create;
    LPerson := LRepository.ListAll;
    Res.Send(TJSONBr.ObjectListToJsonString<TPerson>(LPerson)).ContentType('application/json').Status(200);
  finally
    LPerson.Free;
    LRepository.Free;
  end;
end;

procedure FindOne(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LId: Integer;
  LPerson: TPerson;
  LRepository: TRepositoryPerson;
begin
  try
    LId := Req.Params.Field('ID').AsInteger;
    LRepository := TRepositoryPerson.Create;
    LPerson := LRepository.FindOne(LId);
    Res.Send(TJSONBr.ObjectToJsonString(LPerson)).ContentType('application/json').Status(200);
  finally
    LPerson.Free;
    LRepository.Free;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LPerson: TPerson;
  LRepository: TRepositoryPerson;
begin
  try
    LRepository := TRepositoryPerson.Create;
    LPerson := TJSONBr.JsonToObject<TPerson>(Req.Body);
    LRepository.Insert(LPerson);
    Res.Send(Req.Body).ContentType('application/json').Status(200);
  finally
    LPerson.Free;
    LRepository.Free;
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LPerson: TPerson;
  LRepository: TRepositoryPerson;
begin
  try
    LRepository := TRepositoryPerson.Create;
    LPerson := TJSONBr.JsonToObject<TPerson>(Req.Body);
    LPerson.id := Req.Params.Field('ID').AsInteger;
    LRepository.Update(LPerson);
    Res.Send(TJSONBr.ObjectToJsonString(LPerson)).ContentType('application/json').Status(200);
  finally
    LPerson.Free;
    LRepository.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LId: Integer;
  LPerson: TPerson;
  LRepository: TRepositoryPerson;
begin
  try
    LId := Req.Params.Field('ID').AsInteger;
    LRepository := TRepositoryPerson.Create;
    LPerson := LRepository.FindOne(LId);
    LRepository.Delete(LPerson);
    Res.Send(TJSONBr.ObjectToJsonString(LPerson)).ContentType('application/json').Status(200);
  finally
    LPerson.Free;
    LRepository.Free;
  end;
end;

procedure Registry;
begin
  THorse
    .Get('person', ListAll)
    .Get('person/:id', FindOne)
    .Post('person', Insert)
    .Put('person/:id', Update)
    .Delete('person/:id', Delete)
end;



end.