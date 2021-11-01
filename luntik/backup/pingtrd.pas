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
      //'if [[ $(ip -br a | grep tun0) ]] && [[ ERR=$(ping google.com -c 1 2>&1 > /dev/null) ]]; then echo "yes"; else echo "no"; fi');
      'ping -c 1 google.com &> /dev/null && [[ $(ip -br a | grep tun0) ]] && echo "yes" || echo "no"');

    PingProcess.Options := [poUsePipes, poWaitOnExit];

    while not Terminated do
    begin
      PingProcess.Execute;
      PingStr.LoadFromStream(PingProcess.Output);
      Synchronize(@ShowStatus);
      Sleep(1000);
    end;
  finally
    PingStr.Free;
    PingProcess.Free;
    Terminate;
  end;
end;

procedure CheckPing.ShowStatus;
begin
  Application.ProcessMessages;
  if Trim(PingStr[0]) = 'yes' then
    MainForm.Shape1.Brush.Color := clLime
  else
    MainForm.Shape1.Brush.Color := clYellow;
  MainForm.Shape1.Repaint;
end;

end.
