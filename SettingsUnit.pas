unit SettingsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type
  TfrmSettings = class(TForm)
    lblTitle: TLabel;
    PanelTitle: TPanel;
    btnDeleteAccount: TButton;
    btnChangePass: TButton;
    btnBack: TButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.lfm}

end.
