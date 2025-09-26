unit SearchUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids, DBModuleUnit;

type

  { TresultGridCont }

  TresultGridCont = class(TForm)
    btnResetFilters1: TButton;
    btnBack: TButton;
    btnSearchAdvanced: TButton;
    btnApplyFilters: TButton;
    cmbTitle: TComboBox;
    cmbGenre: TComboBox;
    cmbYear: TComboBox;
    cmbArtist: TComboBox;
    lblFilter: TLabel;
    Panel1: TPanel;
    Edit1: TEdit;
    pnlSearch: TPanel;
    StringGrid1: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure btnApplyFiltersClick(Sender: TObject);
    procedure btnResetFilters1Click(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnSearchAdvancedClick(Sender: TObject);
  private
    procedure LoadResults;
  public

  end;

var
  resultGridCont: TresultGridCont;

implementation

{$R *.lfm}

uses
  Dashboard; // so Back button can return

{ TresultGridCont }

procedure TresultGridCont.FormShow(Sender: TObject);
begin
  // Setup StringGrid headers
  StringGrid1.RowCount := 1;
  StringGrid1.ColCount := 4;
  StringGrid1.Cells[0, 0] := 'ID';
  StringGrid1.Cells[1, 0] := 'Title';
  StringGrid1.Cells[2, 0] := 'Artist';
  StringGrid1.Cells[3, 0] := 'Year';

  LoadResults; // load all by default
end;

procedure TresultGridCont.btnApplyFiltersClick(Sender: TObject);
begin
  LoadResults;
end;

procedure TresultGridCont.btnResetFilters1Click(Sender: TObject);
begin
  cmbTitle.Text := '';
  cmbArtist.Text := '';
  cmbGenre.Text := '';
  cmbYear.Text := '';
  Edit1.Text := '';
  LoadResults; // reload everything
end;

procedure TresultGridCont.btnBackClick(Sender: TObject);
begin
  frmDashboard.Show;
  Self.Hide;
end;

procedure TresultGridCont.btnSearchAdvancedClick(Sender: TObject);
begin
  ShowMessage('Advanced search not yet implemented.');
end;

procedure TresultGridCont.LoadResults;
var
  Query: TSQLQuery;
  Row: Integer;
  WhereClause: TStringList;
begin
  Query := TSQLQuery.Create(nil);
  WhereClause := TStringList.Create;
  try
    Query.DataBase := IBConn;
    Query.Transaction := SQLTrans;

    Query.SQL.Text := 'SELECT ID, TITLE, ARTIST, YEAR FROM ALBUMS';

    // Collect filters
    if cmbTitle.Text <> '' then
      WhereClause.Add('TITLE LIKE :TITLE');
    if cmbArtist.Text <> '' then
      WhereClause.Add('ARTIST LIKE :ARTIST');
    if cmbGenre.Text <> '' then
      WhereClause.Add('GENRE LIKE :GENRE');
    if cmbYear.Text <> '' then
      WhereClause.Add('YEAR = :YEAR');
    if Edit1.Text <> '' then
      WhereClause.Add('(TITLE LIKE :SEARCH OR ARTIST LIKE :SEARCH)');

    if WhereClause.Count > 0 then
      Query.SQL.Add('WHERE ' + StringReplace(WhereClause.Text, LineEnding, ' AND ', [rfReplaceAll]));

    Query.SQL.Add('ORDER BY TITLE');

    // Bind params
    if cmbTitle.Text <> '' then
      Query.Params.ParamByName('TITLE').AsString := '%' + cmbTitle.Text + '%';
    if cmbArtist.Text <> '' then
      Query.Params.ParamByName('ARTIST').AsString := '%' + cmbArtist.Text + '%';
    if cmbGenre.Text <> '' then
      Query.Params.ParamByName('GENRE').AsString := '%' + cmbGenre.Text + '%';
    if cmbYear.Text <> '' then
      Query.Params.ParamByName('YEAR').AsString := cmbYear.Text;
    if Edit1.Text <> '' then
      Query.Params.ParamByName('SEARCH').AsString := '%' + Edit1.Text + '%';

    Query.Open;

    // Fill StringGrid
    StringGrid1.RowCount := Query.RecordCount + 1; // header row
    Row := 1;
    while not Query.EOF do
    begin
      StringGrid1.Cells[0, Row] := Query.FieldByName('ID').AsString;
      StringGrid1.Cells[1, Row] := Query.FieldByName('TITLE').AsString;
      StringGrid1.Cells[2, Row] := Query.FieldByName('ARTIST').AsString;
      StringGrid1.Cells[3, Row] := Query.FieldByName('YEAR').AsString;
      Inc(Row);
      Query.Next;
    end;

    Query.Close;
  finally
    Query.Free;
    WhereClause.Free;
  end;
end;

end.


