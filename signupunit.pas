unit SignupUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DBModuleUnit;

type

  { TfrmSignup }

  TfrmSignup = class(TForm)
    btnCreateAccount: TButton;
    btnCancel: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblTitle: TLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    procedure btnCreateAccountClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    function UserExists(const AUser: string): Boolean;
  public

  end;

var
  frmSignup: TfrmSignup;

implementation

{$R *.lfm}

uses
  LoginUnit;

{ TfrmSignup }

procedure TfrmSignup.btnCreateAccountClick(Sender: TObject);
var
  Query: TSQLQuery;
begin
  ShowMessage('clicked!');
  if Trim(edtUsername.Text) = '' then
  begin
    ShowMessage('Username cannot be empty.');
    Exit;
  end;

  if Trim(edtPassword.Text) = '' then
  begin
    ShowMessage('Password cannot be empty.');
    Exit;
  end;

  if UserExists(edtUsername.Text) then
  begin
    ShowMessage('Username already exists. Please choose another.');
    Exit;
  end;

  Query := TSQLQuery.Create(nil);
  try
    Query.DataBase := IBConn;
    Query.Transaction := SQLTrans;

    Query.SQL.Text :=
      'INSERT INTO USERS (USERNAME, PASSWORD) VALUES (:U, :P)';
    Query.Params.ParamByName('U').AsString := edtUsername.Text;
    Query.Params.ParamByName('P').AsString := edtPassword.Text;

    Query.ExecSQL;
    SQLTrans.Commit; // save changes

    ShowMessage('Account created successfully! You can now log in.');
    frmLogin.Show;
    Self.Hide;
  finally
    Query.Free;
  end;
end;

procedure TfrmSignup.btnCancelClick(Sender: TObject);
begin
  ShowMessage('clicked!');
  frmLogin.Show;
  Self.Hide;
end;

function TfrmSignup.UserExists(const AUser: string): Boolean;
var
  Query: TSQLQuery;
begin
  Result := False;
  Query := TSQLQuery.Create(nil);
  try
    Query.DataBase := IBConn;
    Query.Transaction := SQLTrans;

    Query.SQL.Text := 'SELECT COUNT(*) AS CNT FROM USERS WHERE USERNAME = :U';
    Query.Params.ParamByName('U').AsString := AUser;
    Query.Open;

    Result := Query.FieldByName('CNT').AsInteger > 0;

    Query.Close;
  finally
    Query.Free;
  end;
end;

end.
