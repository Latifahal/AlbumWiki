unit SignupUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfrmSignup }

  TfrmSignup = class(TForm)
    btnRegister: TBitBtn;
    btnCancel: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtConfirm: TEdit;
    edtEmail: TEdit;
    lblTitle: TLabel;
    lblUsername: TLabel;
    lblPassword: TLabel;
    lblConfirm: TLabel;
    lblEmail: TLabel;

  private

  public

  end;

var
  frmSignup: TfrmSignup;

implementation

{$R *.lfm}

end.

