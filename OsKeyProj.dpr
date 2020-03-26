program OsKeyProj;

uses
  Forms,
  OsKey in 'OsKey.pas' {FormOsKey},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.Title:='Oskey';
  Application.ShowMainForm:=false;
  Application.CreateForm(TFormOsKey, FormOsKey);
  Application.Run;
end.
