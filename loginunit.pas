unit LoginUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBModuleUnit;

type
  { TfrmLogin }
  TfrmLogin = class(TForm)
    btnLogin:    TButton;
    btnSignup:   TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblTitle:    TLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender:    TObject);
    procedure frmSignup(Sender:     TObject);
  private
    function TryLogin(const AUser, APass: string): Boolean;
  public
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.lfm}

procedure TfrmLogin.FormCreate(Sender:    TObject);
begin
  InitDatabase; // DBModuleUnit takes care of IBConn + SQLTrans
end;

procedure TfrmLogin.frmSignup(Sender:     TObject);
begin
  ShowMessage('clicked!');
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  ShowMessage('clicked!');
  if TryLogin(edtUsername.Text, edtPassword.Text) then
    ShowMessage('Login successful!')
  else
    ShowMessage('Invalid username or password.');
end;

function TfrmLogin.TryLogin(const AUser, APass: string): Boolean;
var
  Query: TSQLQuery;
begin
  Result := False;
  Query := TSQLQuery.Create(nil);
  try
    Query.DataBase := IBConn;
    Query.Transaction := SQLTrans;
    Query.SQL.Text :=
      'SELECT COUNT(*) AS CNT FROM USERS WHERE USERNAME = :U AND PASSWORD = :P';
    Query.Params.ParamByName('U').AsString := AUser;
    Query.Params.ParamByName('P').AsString := APass;
    Query.Open;

    Result := Query.FieldByName('CNT').AsInteger > 0;

    Query.Close;
  finally
    Query.Free;
  end;
end;

end.

