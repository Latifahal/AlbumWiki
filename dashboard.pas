unit Dashboard;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids;

type

  { TfrmDashboard }

  TfrmDashboard = class(TForm)
    btnNavDashboard: TButton;
    btnNavAlbums: TButton;
    btnNavSettings: TButton;
    btnExit: TButton;
    btnSearch: TButton;
    ComboBox1: TComboBox;
    edtSearch: TEdit;
    imgProfile: TImage;
    lblMusicPlayer: TLabel;
    lblHeader: TLabel;
    lblAppInfo: TLabel;
    lblUserName: TLabel;
    pnlMusicPlayer: TPanel;
    pnlMain: TPanel;
    pnlSidebar: TPanel;
    grdResults: TStringGrid;
  private

  public

  end;

var
  frmDashboard: TfrmDashboard;

implementation

{$R *.lfm}

end.

