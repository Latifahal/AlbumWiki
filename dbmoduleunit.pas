unit DBModuleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, SQLDB, Dialogs;

var
  IBConn: TIBConnection;
  SQLTrans: TSQLTransaction;

procedure InitDatabase;

implementation

procedure InitDatabase;
begin
  if not Assigned(IBConn) then
    IBConn := TIBConnection.Create(nil);

  if not Assigned(SQLTrans) then
    SQLTrans := TSQLTransaction.Create(nil);

  IBConn.LoginPrompt  := False;
  IBConn.DatabaseName := 'C:\Users\latif\Documents\AlbumWiki\wikiAlbum.fdb';
  IBConn.HostName     := 'localhost';
  IBConn.UserName     := 'SYSDBA';
  IBConn.Password     := 'slu01';
  IBConn.Transaction  := SQLTrans;

  SQLTrans.DataBase := IBConn;

  try
    IBConn.Connected := True;
    if not SQLTrans.Active then
      SQLTrans.StartTransaction;
  except
    on E: Exception do
      ShowMessage('Database connection failed: ' + E.Message);
  end;
end;

end.

