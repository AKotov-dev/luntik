unit PingTRD;

{$mode objfpc}{$H+}

interface

uses
  Classes, Forms, Controls, SysUtils, Process, StdCtrls, Graphics;

type
  CheckPing = class(TThread)
  private

    { Private declarations }
  protected
  var
    PingStr: TStringList;

    procedure Execute; override;
    procedure ShowStatus;

  end;

implementation

uses unit1;

{ TRD }

procedure CheckPing.Execute;
var
  PingProcess: TProcess;
begin
  try
    FreeOnTerminate := True; //Уничтожать по завершении
    PingStr := TStringList.Create;

    PingProcess := TProcess.Create(nil);
    PingProcess.Executable := 'bash';
    PingProcess.Parameters.Add('-c');
    PingProcess.Parameters.Add(
      '[[ $(fping google.com) && $(ip -br a | grep tun[[:digit:]]) ]] && echo "yes" || echo "no"');

    PingProcess.Options := [poUsePipes, poWaitOnExit];

    while not Terminated do
    begin
      PingProcess.Execute;
      PingStr.LoadFromStream(PingProcess.Output);
      Synchronize(@ShowStatus);
      Sleep(800);
    end;
  finally
    PingStr.Free;
    PingProcess.Free;
    Terminate;
  end;
end;

//Индикатора vpn-соединения
procedure CheckPing.ShowStatus;
begin
  if Trim(PingStr[0]) = 'yes' then
    MainForm.Shape1.Brush.Color := clLime
  else
    MainForm.Shape1.Brush.Color := clYellow;
  MainForm.Shape1.Repaint;
end;

end.
