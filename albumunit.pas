unit AlbumUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TfrmAlbum }

  TfrmAlbum = class(TForm)
    btnBack:         TBitBtn;
    btnEdit:         TButton;
    btnDelete:       TButton;
    imgCover:        TImage;
    lblAlbumInfo:    TLabel;
    lstTracks:       TListBox;
    lstCategories:   TListBox;
    Panel1:          TPanel;
    pnlAlbumDetails: TPanel;
  private

  public

  end;

var
  frmAlbum: TfrmAlbum;

implementation

{$R *.lfm}

end.

