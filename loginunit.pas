unit LoginUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, TASources;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    btnLogin: TButton;
    btnSignup: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    IBConnection1: TIBConnection;
    lblTitle: TLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    SQLTransaction1: TSQLTransaction;
  private

  public

  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.lfm}

end.

