unit Entity.Person;

interface

uses
  Classes,
  DB,
  /// orm
  dbcbr.mapping.attributes,
  dbcbr.mapping.register,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  ormbr.types.blob;

type
  [Entity]
  [Table('person','')]
  [PrimaryKey('id', NotInc, NoneInc, NoSort, True)]
  [Indexe('idx_id','id')]
  [OrderBy('name desc')]
  TPerson = class
  private
    { Private declarations }
    FId: String;
    FName: String;
  public
    { Public declarations }
    [Restrictions([NoUpdate, NotNull])]
    [Column('id', ftString, 36)]
    [Dictionary('Id','validation message','','','',taCenter)]
    property id: String read FId write FId;

    [Column('name', ftString, 60)]
    [Dictionary('Name','validation message','','','',taLeftJustify)]
    property name: String read FName write FName;

  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TPerson);

end.
