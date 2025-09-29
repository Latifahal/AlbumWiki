unit LoginUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBModuleUnit;

type
  { TfrmLogin }
  TfrmLogin = class(TForm)
    btnLogin: TButton;
    btnSignup: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblTitle: TLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frmSignup(Sender: TObject);
  private
    function TryLogin(const AUser, APass: string): Boolean;
  public
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.lfm}

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  // Initialize DB connection safely
  InitDatabase;

  if not Assigned(IBConn) then
    ShowMessage('Database object not created!')
  else if not IBConn.Connected then
    ShowMessage('Database not connected!');
end;

procedure TfrmLogin.frmSignup(Sender: TObject);
begin
  ShowMessage('Signup button clicked!');
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  if TryLogin(Trim(edtUsername.Text), Trim(edtPassword.Text)) then
    ShowMessage('Login successful!')
  else
    ShowMessage('Invalid username or password.');
end;

function TfrmLogin.TryLogin(const AUser, APass: string): Boolean;
var
  Query: TSQLQuery;
begin
  Result := False;

  // Check database connection
  if not Assigned(IBConn) then
  begin
    ShowMessage('Database connection object is missing!');
    Exit;
  end;

  if not IBConn.Connected then
  begin
    ShowMessage('Database is not connected!');
    Exit;
  end;

  Query := TSQLQuery.Create(nil);
  try
    Query.DataBase := IBConn;
    Query.Transaction := SQLTrans;
    Query.SQL.Text := 'SELECT COUNT(*) AS CNT FROM USERS WHERE USERNAME = :U AND PASSWORD = :P';
    Query.Params.ParamByName('U').AsString := AUser;
    Query.Params.ParamByName('P').AsString := APass;

    try
      Query.Open;
      Result := Query.FieldByName('CNT').AsInteger > 0;
    except
      on E: Exception do
        ShowMessage('Database query error: ' + E.Message);
    end;

    Query.Close;
  finally
    Query.Free;
  end;
end;

end.

