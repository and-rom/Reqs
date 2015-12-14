program Reqs;

uses
  Forms,
  fmReqs in 'fmReqs.pas' {Form1},
  VisCmp in 'VisCmp.pas',
  USubProgr in 'USubProgr.pas',
  Wcrypt2 in 'Wcrypt2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
