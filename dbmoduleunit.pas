unit DBModuleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, SQLDB;

var
  IBConn: TIBConnection;
  SQLTrans: TSQLTransaction;

procedure InitDatabase;

implementation

procedure InitDatabase;
begin
  IBConn   := TIBConnection.Create(nil);
  SQLTrans := TSQLTransaction.Create(nil);

  IBConn.LoginPrompt  := False;          // disable popup login
  IBConn.DatabaseName := '/home/lalbrecht/Dokumente/First30Days/Album Wiki Project/AlbumWiki.fdb';
  // IBConn.HostName     := '192.168.178.114';
  IBConn.HostName     := 'localhost';
  IBConn.UserName     := 'SYSDBA';
  IBConn.Password     := 'slu01';
  IBConn.Transaction  := SQLTrans;

  SQLTrans.DataBase   := IBConn;

  try
    IBConn.Connected  := True;
    SQLTrans.StartTransaction;
    WriteLn('Database connected successfully!');
  except
    on E: Exception do
      WriteLn('Database connection failed: ', E.Message);
  end;
end;

end.

