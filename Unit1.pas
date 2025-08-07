unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ClipBrd, XPMan, Vcl.Menus, Vcl.ExtCtrls, WinSock,
  Vcl.ComCtrls, IniFiles;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    Copyall1: TMenuItem;
    Clear1: TMenuItem;
    N2: TMenuItem;
    Geolocation1: TMenuItem;
    Panel1: TPanel;
    Edit6: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    NetworkIP1: TMenuItem;
    ExternalIP1: TMenuItem;
    ExternalIPv61: TMenuItem;
    N3: TMenuItem;
    HostURL1: TMenuItem;
    StatusBar1: TStatusBar;
    Ping1: TMenuItem;
    racert1: TMenuItem;
    N4: TMenuItem;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    SaveDialog1: TSaveDialog;
    Save1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Copy1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Copyall1Click(Sender: TObject);
    procedure Geolocation1Click(Sender: TObject);
    procedure NetworkIP1Click(Sender: TObject);
    procedure ExternalIP1Click(Sender: TObject);
    procedure ExternalIPv61Click(Sender: TObject);
    procedure HostURL1Click(Sender: TObject);
    procedure Ping1Click(Sender: TObject);
    procedure racert1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Save1Click(Sender: TObject);
  private
    { Private declarations }
    procedure WriteOptions;
    procedure ReadOptions;
    procedure CaptureConsoleOutput(const ACommand, AParameters: String; AMemo: TMemo);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  TIF : TIniFile;

type
  TIPAddr = array[0..3] of Byte;
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;

implementation

{$R *.dfm}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var OPT :string;
begin
   OPT := 'Options';
   if not DirectoryExists(MainDir + 'Options\')
   then ForceDirectories(MainDir + 'Options\');

   TIF := TIniFile.Create(MainDir + 'Options\Options.ini');
   with TIF do
   begin
   if CheckBox2.Checked = true then
   begin
   WriteString(OPT,'ip1',Edit1.Text);
   WriteString(OPT,'ip2',Edit2.Text);
   WriteString(OPT,'ip3',Edit3.Text);
   WriteString(OPT,'ip4',Edit4.Text);
   WriteString(OPT,'ip5',Edit5.Text);
   WriteString(OPT,'ip6',Edit6.Text);
   WriteString(OPT,'ip7',Edit7.Text);
   WriteString(OPT,'ip8',Edit8.Text);
   end;
   WriteBool(OPT,'StayTop',CheckBox1.Checked);
   WriteBool(OPT,'SaveRange',CheckBox2.Checked);
   Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Options\Options.ini') then
  begin
  TIF:=TIniFile.Create(MainDir + 'Options\Options.ini');
  with TIF do
  begin
  Edit1.Text:=ReadString(OPT,'ip1',Edit1.Text);
  Edit2.Text:=ReadString(OPT,'ip2',Edit2.Text);
  Edit3.Text:=ReadString(OPT,'ip3',Edit3.Text);
  Edit4.Text:=ReadString(OPT,'ip4',Edit4.Text);
  Edit5.Text:=ReadString(OPT,'ip5',Edit5.Text);
  Edit6.Text:=ReadString(OPT,'ip6',Edit6.Text);
  Edit7.Text:=ReadString(OPT,'ip7',Edit7.Text);
  Edit8.Text:=ReadString(OPT,'ip8',Edit8.Text);
  CheckBox1.Checked:=ReadBool(OPT,'StayTop',CheckBox1.Checked);
  CheckBox2.Checked:=ReadBool(OPT,'SaveRange',CheckBox2.Checked);
  Free;
  end;
  end;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  ListBox1.Items.SaveToFile(SaveDialog1.FileName + '.txt');
end;

function IPAddrToName(IPAddr: Ansistring): string;
var
  SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
  WSAStartup($101, WSAData);
  SockAddrIn.sin_addr.s_addr := inet_addr(PAnsiChar(IPAddr));
  HostEnt := gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);

  if HostEnt <> nil then
    Result := StrPas(Hostent^.h_name) else Result := 'Socket Error!';
end;

procedure ListBoxToClipboard(ListBox: TListBox; CopyAll: Boolean);
var
  i: Integer;
  s: string;
begin
  s := '';
  for i := 0 to ListBox.Items.Count - 1 do
  begin
    if CopyAll or ListBox.Selected[i] then
      s := s + ListBox.Items[i] + sLineBreak;
  end;
  ClipBoard.AsText := s;
end;

procedure TForm1.CaptureConsoleOutput(const ACommand, AParameters: String; AMemo: TMemo);
 const
   CReadBuffer = 2400;
 var
   saSecurity: TSecurityAttributes;
   hRead: THandle;
   hWrite: THandle;
   suiStartup: TStartupInfo;
   piProcess: TProcessInformation;
   pBuffer: array[0..CReadBuffer] of AnsiChar;
   dRead: DWord;
   dRunning: DWord;
 begin
   saSecurity.nLength := SizeOf(TSecurityAttributes);
   saSecurity.bInheritHandle := True;
   saSecurity.lpSecurityDescriptor := nil;

   if CreatePipe(hRead, hWrite, @saSecurity, 0) then
   begin
     FillChar(suiStartup, SizeOf(TStartupInfo), #0);
     suiStartup.cb := SizeOf(TStartupInfo);
     suiStartup.hStdInput := hRead;
     suiStartup.hStdOutput := hWrite;
     suiStartup.hStdError := hWrite;
     suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
     suiStartup.wShowWindow := SW_HIDE;

     if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity,
       @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup, piProcess)
       then
     begin
       repeat
         dRunning := WaitForSingleObject(piProcess.hProcess, 100);
         Application.ProcessMessages();
         repeat
           dRead := 0;
           ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
           pBuffer[dRead] := #0;
           OemToAnsi(pBuffer, pBuffer);
           AMemo.Lines.Add(String(pBuffer));
         until
         (dRead < CReadBuffer);
       until
       (dRunning <> WAIT_TIMEOUT);
       CloseHandle(piProcess.hProcess);
       CloseHandle(piProcess.hThread);
     end;

     CloseHandle(hRead);
     CloseHandle(hWrite);
   end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then begin
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
  SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  ListBox1.Clear;
  Memo1.Clear;
end;

procedure TForm1.Copy1Click(Sender: TObject);
var
  i: integer;
  sl: TStringList;
begin
  if ListBox1.SelCount = 0 then Exit;
  sl := TStringList.Create;
  for i := 0 to ListBox1.Items.Count - 1 do
    if ListBox1.Selected[i] then
      sl.Add(ListBox1.Items[i]);
  ClipBoard.AsText := sl.Text;
  sl.Free;
end;

procedure TForm1.Copyall1Click(Sender: TObject);
begin
  ListBoxToClipboard(ListBox1, True);
end;

function GetNext(var IPAddr: TIPAddr): Boolean;
var
  C: Integer;
begin
  Result := True;
  for C := 3 downto 0 do
  begin
    if IPAddr[C] < 255 then
    begin
      Inc(IPAddr[C]);
      Exit;
    end;
    IPAddr[C] := 0;
  end;
  Result := False;
end;

function IsBelowOrEqual(IP, Limit: TIPAddr): Boolean;
begin
  Result := (IP[0] shl 24 + IP[1] shl 16 + IP[2] shl 8 + IP[3]) <=
    (Limit[0] shl 24 + Limit[1] shl 16 + Limit[2] shl 8 + Limit[3]);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Start, Stop: TIPAddr;
  i, t, b, g, k, l, m, n : Integer;

begin
  i := StrToInt(Edit1.Text);
  t := StrToInt(Edit2.Text);
  b := StrToInt(Edit3.Text);
  g := StrToInt(Edit4.Text);

  k := StrToInt(Edit5.Text);
  l := StrToInt(Edit6.Text);
  m := StrToInt(Edit7.Text);
  n := StrToInt(Edit8.Text);


  Start[0] := i;
  Start[1] := t;
  Start[2] := b;
  start[3] := g;

  Stop[0] := k;
  Stop[1] := l;
  Stop[2] := m;
  Stop[3] := n;
  repeat
    ListBox1.Items.Add(IntToStr(Start[0]) + '.' + IntToStr(Start[1]) + '.' +
      IntToStr(Start[2]) + '.' + IntToStr(Start[3]));
    if not GetNext(Start) then
      Exit;
  until not
  IsBelowOrEqual(Start, Stop);

  ListBox1.Selected[0] := true;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  WriteOptions;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
end;

procedure TForm1.Geolocation1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  StatusBar1.Panels[1].Text := 'Investigate Geolocation from IP, please wait...';
  Application.ProcessMessages;
  Memo1.Lines.Add('');
  Memo1.Lines.Add('================ Geolocation:' +
                  ListBox1.Items.Strings[ListBox1.ItemIndex]);
  try
  CaptureConsoleOutput('cmd /c', 'curl ipinfo.io/' +
                      ListBox1.Items.Strings[ListBox1.ItemIndex], Memo1);
  except
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

procedure TForm1.HostURL1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  StatusBar1.Panels[1].Text := 'Investigate Host URL from IPv4, please wait...';
  Application.ProcessMessages;
  Memo1.Lines.Add('');
  Memo1.Lines.Add('================ Host Url ' +
                  ListBox1.Items.Strings[ListBox1.ItemIndex] + ':');
  try
  Memo1.Lines.Add(IPAddrToName(ListBox1.Items.Strings[ListBox1.ItemIndex]));
  except
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

procedure TForm1.NetworkIP1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    Memo1.Lines.Add('');
    Memo1.Lines.Add('================ Network IP:');
    CaptureConsoleOutput('cmd /c', 'ipconfig', Memo1);
  except
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

procedure TForm1.Ping1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  StatusBar1.Panels[1].Text := 'Pinging, please wait...';
  Application.ProcessMessages;
  try
    Memo1.Lines.Add('');
    Memo1.Lines.Add('================ Ping:' +
                    ListBox1.Items.Strings[ListBox1.ItemIndex]);
    CaptureConsoleOutput('cmd /c', 'ping -w 100 ' +
                    ListBox1.Items.Strings[ListBox1.ItemIndex] + ' -n 2', Memo1);
  except
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

procedure TForm1.racert1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  StatusBar1.Panels[1].Text := 'Tracert, please wait...';
  Application.ProcessMessages;
  try
    Memo1.Lines.Add('');
    Memo1.Lines.Add('================ Tracert:' +
                    ListBox1.Items.Strings[ListBox1.ItemIndex]);
    CaptureConsoleOutput('cmd /c', 'tracert ' +
                    ListBox1.Items.Strings[ListBox1.ItemIndex], Memo1);
  except
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Start, Stop: TIPAddr;
  i, t, b, g, k, l, m, n : Integer;

begin
  ListBox1.Clear;
  StatusBar1.Panels[1].Text := 'Calculating Range, please wait...';
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  i := StrToInt(Edit1.Text);
  t := StrToInt(Edit2.Text);
  b := StrToInt(Edit3.Text);
  g := StrToInt(Edit4.Text);

  k := StrToInt(Edit5.Text);
  l := StrToInt(Edit6.Text);
  m := StrToInt(Edit7.Text);
  n := StrToInt(Edit8.Text);

  Start[0] := i;
  Start[1] := t;
  Start[2] := b;
  start[3] := g;

  Stop[0] := k;
  Stop[1] := l;
  Stop[2] := m;
  Stop[3] := n;
  repeat
    ListBox1.Items.Add(IntToStr(Start[0]) + '.' + IntToStr(Start[1]) + '.' +
      IntToStr(Start[2]) + '.' + IntToStr(Start[3]));
    if not GetNext(Start) then
      Exit;
  until not IsBelowOrEqual(Start, Stop);
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If not (Key in [#46, #48..#57, #8]) then Key := #0;

  if (Edit1.Text = '') or (Edit2.Text = '') or
     (Edit3.Text = '') or (Edit4.Text = '') or
     (Edit5.Text = '') or (Edit6.Text = '') or
     (Edit7.Text = '') or (Edit8.Text = '') then Exit;

  if StrToInt(Edit1.Text) > 255 then Edit1.Text := '255';
  if StrToInt(Edit2.Text) > 255 then Edit2.Text := '255';
  if StrToInt(Edit3.Text) > 255 then Edit3.Text := '255';
  if StrToInt(Edit4.Text) > 255 then Edit4.Text := '255';
  if StrToInt(Edit5.Text) > 255 then Edit5.Text := '255';
  if StrToInt(Edit6.Text) > 255 then Edit6.Text := '255';
  if StrToInt(Edit7.Text) > 255 then Edit7.Text := '255';
  if StrToInt(Edit8.Text) > 255 then Edit8.Text := '255';
end;

procedure TForm1.ExternalIP1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  StatusBar1.Panels[1].Text := 'Investigate External IPv4, please wait...';
  Application.ProcessMessages;
  try
    Memo1.Lines.Add('');
    Memo1.Lines.Add('================ IPv4:');
    CaptureConsoleOutput('cmd /c', 'curl ifcfg.me', Memo1);
  except
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

procedure TForm1.ExternalIPv61Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  StatusBar1.Panels[1].Text := 'Investigate External IPv6, please wait...';
  Application.ProcessMessages;
  try
    Memo1.Lines.Add('');
    Memo1.Lines.Add('================ IPv6:');
    CaptureConsoleOutput('cmd /c', 'curl icanhazip.com', Memo1);
  except
  end;
  Screen.Cursor := crDefault;
  StatusBar1.Panels[1].Text := 'Ready.';
end;

end.
