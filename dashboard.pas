unit Dashboard;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids, ComCtrls, DBModuleUnit;

type

  { TfrmDashboard }

  TfrmDashboard = class(TForm)
    btnNavDashboard: TButton;
    btnNavAlbums:    TButton;
    btnNavSettings:  TButton;
    btnExit:         TButton;
    btnSearch:       TButton;
    btnPlay:         TButton;
    btnPause:        TButton;
    btnStop:         TButton;
    btnBack:         TButton;
    btnNext:         TButton;
    ComboBox1:       TComboBox;
    edtSearch:       TEdit;
    imgProfile:      TImage;
    lblElapsed:      TLabel;
    lblMusicPlayer:  TLabel;
    lblHeader:       TLabel;
    lblAppInfo:      TLabel;
    lblUserName:     TLabel;
    pnlMusicPlayer:  TPanel;
    pnlMain:         TPanel;
    pnlSidebar:      TPanel;
    grdResults:      TStringGrid;
    pbTrack:         TProgressBar;
    procedure FormShow(Sender:       TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnExitClick(Sender:   TObject);
  private
    procedure LoadAlbums(const Filter: string = '');
  public

  end;

var
  frmDashboard: TfrmDashboard;

implementation

{$R *.lfm}


{ TfrmDashboard }

procedure TfrmDashboard.FormShow(Sender: TObject);
begin
  // initialize grid headers
  grdResults.RowCount    := 1; // header row only
  grdResults.ColCount    := 3;
  grdResults.Cells[0, 0] := 'ID';
  grdResults.Cells[1, 0] := 'Title';
  grdResults.Cells[2, 0] := 'Artist';

  // load all albums
  LoadAlbums;
end;

procedure TfrmDashboard.btnSearchClick(Sender: TObject);
begin
  LoadAlbums(edtSearch.Text);
end;

procedure TfrmDashboard.btnExitClick(Sender: TObject);
begin
  Close; // closes dashboard
end;

procedure TfrmDashboard.LoadAlbums(const Filter: string);
var
  Query: TSQLQuery;
  Row: Integer;
begin
  Query := TSQLQuery.Create(nil);
  try
    Query.DataBase    := IBConn;
    Query.Transaction := SQLTrans;

    Query.SQL.Text    := 'SELECT ID, TITLE, ARTIST FROM ALBUMS';
    if Filter <> '' then
      Query.SQL.Add('WHERE TITLE LIKE :P OR ARTIST LIKE :P');
    Query.SQL.Add('ORDER BY TITLE');

    if Filter <> '' then
      Query.Params.ParamByName('P').AsString := '%' + Filter + '%';

    Query.Open;

    // fill grid
    grdResults.RowCount := Query.RecordCount + 1; // header + rows
    Row := 1;
    while not Query.EOF do
    begin
      grdResults.Cells[0, Row] := Query.FieldByName('ID').AsString;
      grdResults.Cells[1, Row] := Query.FieldByName('TITLE').AsString;
      grdResults.Cells[2, Row] := Query.FieldByName('ARTIST').AsString;
      Inc(Row);
      Query.Next;
    end;

    Query.Close;
  finally
    Query.Free;
  end;
end;

end.

