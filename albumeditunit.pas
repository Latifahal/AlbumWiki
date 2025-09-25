unit AlbumEditUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TfrmAlbumEdit }

  TfrmAlbumEdit = class(TForm)
    btnCancel: TButton;
    btnSave: TButton;
    edtArtist: TEdit;
    edtTitle: TEdit;
    edtYear: TEdit;
    imgCover: TImage;
    lstTracks: TListBox;
  private
  public
  end;

var
  frmAlbumEdit: TfrmAlbumEdit;

implementation

{$R *.lfm}

end.

