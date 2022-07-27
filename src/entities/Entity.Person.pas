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
  [PrimaryKey('person_id', AutoInc, SequenceInc, NoSort, True)]
  [Indexe('idx_name','name')]
  [OrderBy('person_id desc')]
  [Sequence('person')]
  TPerson = class
  private
    { Private declarations }
    FId: Integer;
    FName: String;
//    FBirthDate: TDate;
//    FPhoto: TBlob;
//    FActive: Boolean;
  public
    { Public declarations }
    [Restrictions([NoUpdate, NotNull])]
    [Column('person_id', ftInteger)]
    [Dictionary('Id','validation message','','','',taCenter)]
    property Id: Integer read FId write FId;

    [Column('name', ftString, 60)]
    [Dictionary('Name','validation message','','','',taLeftJustify)]
    property Name: String read FName write FName;

//    [Column('birth_date', ftDate)]
//    [Dictionary('Birth Date','validation message')]
//    property BirthDate: TDate read FBirthDate write FBirthDate;
//
//    [Column('photo', ftBlob)]
//    [Dictionary('Photo','validation message')]
//    property Photo: TBlob read FPhoto write FPhoto;
//
//    [Column('active', ftBoolean)]
//    [Dictionary('Active','validation message')]
//    property Active: Boolean read FActive write FActive;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TPerson);

end.
