program AlbumWiki;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, Forms, tachartlazaruspkg, LoginUnit, SignupUnit, Dashboard,
  SettingsUnit, AlbumUnit, AlbumEditUnit, SearchUnit;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmSignup, frmSignup);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TfrmDashboard, frmDashboard);
  Application.CreateForm(TfrmAlbum, frmAlbum);
  Application.CreateForm(TfrmAlbumEdit, frmAlbumEdit);
  Application.CreateForm(TresultGridCont, resultGridCont);
  Application.Run;
end.

