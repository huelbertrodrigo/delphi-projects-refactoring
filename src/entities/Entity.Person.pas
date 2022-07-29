unit Entity.Person;

interface

uses
  Classes, 
  DB, 
  SysUtils, 
  Generics.Collections, 
  /// orm 
  dbcbr.mapping.attributes,
  dbcbr.mapping.register,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  ormbr.types.blob;

type
  [Entity]
  [Table('person','')]
  [PrimaryKey('id', AutoInc, SequenceInc, NoSort, True)]
  [Indexe('idx_name','name')]
  [OrderBy('id desc')]
  [Sequence('person')]
  TPerson = class
  private
    { Private declarations }
    FId: Integer;
    FName: String;
  public
    { Public declarations }
    [Restrictions([NoUpdate, NotNull])]
    [Column('id', ftInteger)]
    [Dictionary('Id','validation message','','','',taCenter)]
    property id: Integer read FId write FId;

    [Column('name', ftString, 60)]
    [Dictionary('Name','validation message','','','',taLeftJustify)]
    property name: String read FName write FName;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TPerson);

end.
