unit Controller.Person;

interface

uses
  Horse,

  Service.Person;

procedure Registry;

implementation

procedure listAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  result: String;
begin
  try
    result := Service.Person.listAll;
    Res.Send(result)
      .ContentType('application/json')
      .Status(200);
  except

  end;
end;

procedure findOne(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  result: String;
begin
  try
    result := Service.Person.findOne(Req.Params.Field('id').AsInteger);
    Res.Send(result)
      .ContentType('application/json')
      .Status(200);
  except

  end;
end;

procedure insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  result: String;
begin
  try
    result := Service.Person.insert(Req.Body);
    Res.Send(result)
      .ContentType('application/json')
      .Status(201);
  except

  end;
end;

procedure update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  result: String;
begin
  try
    result := Service.Person.update(Req.Params.Field('id').AsInteger, Req.Body);
    Res.Send(result)
      .ContentType('application/json')
      .Status(200);
  except

  end;
end;

procedure delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  result: String;
begin
  try
    result := Service.Person.delete(Req.Params.Field('id').AsInteger);
    Res.Send(result)
      .ContentType('application/json')
      .Status(200);
  except

  end;
end;

procedure Registry;
begin
  THorse
    .Get('person', listAll)
    .Get('person/:id', findOne)
    .Post('person', insert)
    .Put('person/:id', update)
    .Delete('person/:id', delete)
end;



end.