unit SearchUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids;

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
    resultGridCont: TButton;
    Edit1: TEdit;
    pnlSearch: TPanel;
    StringGrid1: TStringGrid;
  private

  public

  end;

var
  resultGridCont: TresultGridCont;

implementation

{$R *.lfm}

end.

