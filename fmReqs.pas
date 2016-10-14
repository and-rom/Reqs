unit fmReqs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,CLIPBRD,FileCtrl,ComObj,Wcrypt2,
  IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze,
  USubProgr,VisCmp, StdCtrls, ComCtrls, DB, DBGrids,
  ExtCtrls;

type
  TForm1 = class(TForm)
    ida: TIdAntiFreeze;
    StringGrid1: TStringGrid;
    EditLine: TEdit;
    btCreateReqs: TButton;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet4: TTabSheet;
    RadioGroup1: TRadioGroup;
    btnSave: TButton;
    btnOpen: TButton;
    btnNew: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;

    procedure DoClipbrdPaste;
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid1GetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure EditLineChange(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EditLineEnter(Sender: TObject);
    procedure EditLineExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btCreateReqsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);

  private
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
    procedure fShowHint(Text:String;FCaption:string);
    procedure HighLightCell(col, row: Integer; color: TColor; rect: TRect);
  public
    { Public declarations }
  end;
  TCols = record
        Name : string;
        Num : Integer;
  end;
var
  Form1: TForm1;
  flag:boolean;
  j:integer=0;
 const
  Cont_HotKey = $70;
  Phrase_HotKey = $71;
  PIN_HotKey = $72;
  StdPIN_HotKey = $73;
  Extra_HotKey = $74;
  UP_Hotkey = $21;
  DWN_HotKey=$22;

	SN : TCols =(Name:'Фамилия'; Num: 0);
	G : TCols =(Name:'Имя'; Num: 1);
	T : TCols =(Name:'Должность'; Num: 2);
	STREET : TCols =(Name:'Адрес'; Num: 3);
	CN : TCols =(Name:'Общее имя'; Num: 4);
	OU : TCols =(Name:'Подразделение'; Num: 5);
	O : TCols =(Name:'Организация'; Num: 6);
	L : TCols =(Name:'Город'; Num: 7);
	S : TCols =(Name:'Область'; Num: 8);
	E : TCols =(Name:'Эл. почта'; Num: 9);
	INN : TCols =(Name:'ИНН'; Num: 10);
	OGRN : TCols =(Name:'ОГРН'; Num: 11);
	SNILS : TCols =(Name:'СНИЛС'; Num: 12);
	TOKEN : TCols =(Name:'Носитель'; Num: 13);
	PIN : TCols =(Name:'ПИН'; Num: 14);
	PHRASE : TCols =(Name:'Фраза'; Num: 15);
	CONT : TCols =(Name:'Контейнер'; Num: 16);



implementation

{$R *.dfm}
procedure TForm1.btCreateReqsClick(Sender: TObject);
var
  chosenDirectory,reqstr : string;
  oEnroll:Variant;
  hProv: HCRYPTPROV;

  cont: PChar;
  err: string;
  i:integer;
begin
  // Просим пользователя выбрать требуемый каталог, стартовый каталог C:
  if SelectDirectory('', '', chosenDirectory, [sdNewFolder, sdShowEdit, sdShowShares, sdNewUI, sdShowFiles,
   sdValidateDir])
  then ShowMessage('Выбранный каталог = '+chosenDirectory)
  else begin ShowMessage('Выбор каталога прервался'); exit;end;
  /////
  err := 'Cont '+DateToStr(Now)+' '+TimeToStr(Now);
  oEnroll:= CreateOLEObject('CEnroll.CEnroll.2');
  oEnroll.ProviderType := 75;
  oEnroll.ProviderName := 'Crypto-Pro GOST R 34.10-2001 Cryptographic Service Provider';
  oEnroll.ClientID := 0;
  oEnroll.EnableSMIMECapabilities := False;
  oEnroll.KeySpec := 1;
  oEnroll.GenKeyFlags := 0;
  oEnroll.UseExistingKeySet:=0;
  oEnroll.ContainerName:= err;
  oEnroll.createPKCS10('','');
  oEnroll.Reset;

  /////
  with StringGrid1 do
  for I := 1 to RowCount - 2 do
   begin
  oEnroll:= CreateOLEObject('CEnroll.CEnroll.2');
  oEnroll.ProviderType := 75;
  oEnroll.ProviderName := 'Crypto-Pro GOST R 34.10-2001 Cryptographic Service Provider';
  oEnroll.ClientID := 0;
  oEnroll.EnableSMIMECapabilities := False;
  oEnroll.KeySpec := 1;
  oEnroll.GenKeyFlags := 0;
  oEnroll.UseExistingKeySet:=1;
  oEnroll.ContainerName:= err;

  reqstr:='';

  if Cells[SNILS.Num,i]<>'' then
    reqstr:=reqstr+'1.2.643.100.3='+Cells[SNILS.Num,i]+',';

  if Cells[OGRN.Num,i]<>'' then
    reqstr:=reqstr+'1.2.643.100.1='+Cells[OGRN.Num,i]+',';

  if Cells[INN.Num,i]<>'' then
    reqstr:=reqstr+'1.2.643.3.131.1.1='+Cells[INN.Num,i]+',';

  if Cells[E.Num,i]<>'' then
    reqstr:=reqstr+'E='+Cells[E.Num,i]+',';

  reqstr:=reqstr+'C=RU,';

  if Cells[S.Num,i]<>'' then
    reqstr:=reqstr+'S="'+Cells[S.Num,i]+'",';

  if Cells[L.Num,i]<>'' then
    reqstr:=reqstr+'L="'+Cells[L.Num,i]+'",';

  if Cells[O.Num,i]<>'' then
    reqstr:=reqstr+'O="'+Cells[O.Num,i]+'",';

  if Cells[OU.Num,i]<>'' then
    reqstr:=reqstr+'OU="'+Cells[OU.Num,i]+'",';

  reqstr:=reqstr+'CN="'+Cells[CN.Num,i]+'",';

  if Cells[STREET.Num,i]<>'' then
    reqstr:=reqstr+'2.5.4.9="'+Cells[STREET.Num,i]+'",';

  if Cells[T.Num,i]<>'' then
    reqstr:=reqstr+'T='+Cells[T.Num,i]+',';

  if Cells[G.Num,i]<>'' then
    reqstr:=reqstr+'G='+Cells[G.Num,i]+',';

  if Cells[SN.Num,i]<>'' then
    reqstr:=reqstr+'SN='+Cells[SN.Num,i]+',';

  oEnroll.createFIlePKCS10(reqstr,'',chosenDirectory+'\'+Translit(Cells[SN.Num,i])+'_'+IntToStr(CurrentYear));
  oEnroll.Reset;
    end;

    cont := StrAlloc(length(err) + 1);
    StrPCopy(cont, err);
     if CryptAcquireContext(@hProv, cont, nil, PROV_GOST,
                             CRYPT_DELETEKEYSET) then begin

  showmessage('Контейнер '+err+' успешно удален.');
   {Button3Click(Form1);}
     end

    else
      showmessage('Была ошибка');

  /////

end;

procedure TForm1.btnNewClick(Sender: TObject);
var
  i: Integer;
begin
with StringGrid1 do
  begin
    for i:=FixedRows to RowCount-1 do
      begin
        Rows[i].Clear;
      end;
    RowCount:=2;
  end;
end;

procedure TForm1.btnOpenClick(Sender: TObject);
var
  List: TStringList;
  i, j, k: Integer;
begin
  List:=TStringList.Create;

  with OpenDialog1 do
    if Execute then
      List.LoadFromFile(FileName);
  with StringGrid1 do
    begin
      RowCount:=List.Count div 12 + 1;
        k:=0;
        for i:=1 to RowCount-1 do
          for j:=0 to  ColCount-1 do
            begin
              Cells[j, i]:=List[k];
              inc(k);
            end;
      RowCount:=RowCount + 1;
    end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  List: TStringList;
  i, j: Integer;
begin
  List:=TStringList.Create;

  with StringGrid1 do
    for i:=FixedRows to RowCount-2 do
      for j:=FixedCols to  ColCount-1 do
        List.Add(Cells[j, i]);

  with SaveDialog1 do
    if Execute then
      List.SaveToFile(FileName);
end;

procedure TForm1.DoClipbrdPaste;
var
  ClipbrdData: TStringList;
  ClipbrdRow: TStringList;
  i, j, RowCnt: Integer;
begin
  if not Clipboard.HasFormat(CF_TEXT) then Exit;
  ClipbrdData := TStringList.Create;
  ClipbrdRow := TStringList.Create;
  try
    ClipbrdData.Text := Clipboard.AsText;
    RowCnt := ClipbrdData.Count;
    // если не вмещается, увеличиваем число строк в StringGrid
    if StringGrid1.RowCount - StringGrid1.Row <=RowCnt then
      StringGrid1.RowCount := RowCnt + StringGrid1.Row+1;
    for i := 0 to RowCnt - 1 do
    begin
      ClipbrdData.Strings[i] := '"' + ClipbrdData.Strings[i] + '"';
      ClipbrdData.Strings[i] := StringReplace(ClipbrdData.Strings[i], #9,
                                              '"'#9'"', [rfReplaceAll]);
    end;
    ClipbrdRow.Delimiter := #9;
    ClipbrdRow.DelimitedText := ClipbrdData.Strings[0];
    // проверяем число столбцов в StringGrid. Если что, добавляем
   { if StringGrid1.ColCount - StringGrid1.Col < ClipbrdRow.Count then }
      StringGrid1.ColCount := ClipbrdRow.Count{ + StringGrid1.Col};
    for i := 0 to RowCnt - 1 do
    begin
      ClipbrdRow.DelimitedText := ClipbrdData.Strings[i];
      for j := 0 to ClipbrdRow.Count - 1 do
        StringGrid1.Cells[j{j + StringGrid1.Col}, i + StringGrid1.Row] := ClipbrdRow.Strings[j];
    end;
  finally
    ClipbrdData.Free;
    ClipbrdRow.Free;
  end;
end;





procedure TForm1.EditLineChange(Sender: TObject);
begin
  if flag then
    begin
      StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:=EditLine.Text;
      StringGridColumnsAlign(StringGrid1);
    end
  else
  exit;
Label1.Caption:='Длина: '+inttostr(Length(StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]));
end;

procedure TForm1.EditLineEnter(Sender: TObject);
begin
  flag:=true;
end;

procedure TForm1.EditLineExit(Sender: TObject);
begin
  flag:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  with StringGrid1 do
  begin
    i:=SN.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=SN.Name;
    i:=G.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=G.Name;
    i:=T.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=T.Name;
    i:=STREET.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=STREET.Name;
    i:=CN.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=CN.Name;
    i:=O.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=O.Name;
    i:=OU.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=OU.Name;
    i:=L.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=L.Name;
    i:=S.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=S.Name;
    i:=E.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=E.Name;
    i:=INN.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=INN.Name;
    i:=OGRN.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=OGRN.Name;
    i:=SNILS.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=SNILS.Name;
    i:=TOKEN.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=TOKEN.Name;
    i:=PIN.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=PIN.Name;
    i:=PHRASE.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=PHRASE.Name;
    i:=CONT.Num; StringGrid1.ColCount:=i+1; Cells[i,0]:=CONT.Name;
  end;
  with ComboBox1 do
    begin
      AddItem(SN.Name,Items);
      AddItem(G.Name,Items);
      AddItem(T.Name,Items);
      AddItem(STREET.Name,Items);
      AddItem(CN.Name,Items);
      AddItem(O.Name,Items);
      AddItem(OU.Name,Items);
      AddItem(L.Name,Items);
      AddItem(S.Name,Items);
      AddItem(E.Name,Items);
      AddItem(INN.Name,Items);
      AddItem(OGRN.Name,Items);
      AddItem(SNILS.Name,Items);
      AddItem(TOKEN.Name,Items);
      AddItem(PIN.Name,Items);
      AddItem(PHRASE.Name,Items);
      AddItem(CONT.Name,Items);

      ItemIndex:=0;
    end;
  RegisterHotKey(Form1.Handle, Cont_HotKey, 0, Cont_HotKey);
  RegisterHotKey(Form1.Handle, Phrase_HotKey, 0, Phrase_HotKey);
  RegisterHotKey(Form1.Handle, PIN_HotKey, 0, PIN_HotKey);
  RegisterHotKey(Form1.Handle, StdPIN_HotKey, 0, StdPIN_HotKey);
  RegisterHotKey(Form1.Handle, Extra_HotKey, 0, EXTRA_HotKey);
  RegisterHotKey(Form1.Handle, UP_HotKey, 0, UP_HotKey);
  RegisterHotKey(Form1.Handle, DWN_HotKey, 0, DWN_HotKey);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
UnRegisterHotKey(Form1.Handle, Cont_HotKey);
UnRegisterHotKey(Form1.Handle, Phrase_HotKey);
UnRegisterHotKey(Form1.Handle, PIN_HotKey);
UnRegisterHotKey(Form1.Handle, StdPIN_HotKey);
UnRegisterHotKey(Form1.Handle, Extra_HotKey);
UnRegisterHotKey(Form1.Handle, UP_HotKey);
UnRegisterHotKey(Form1.Handle, DWN_HotKey);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    PageControl1.Height:= Form1.ClientHeight;
    PageControl1.Width:=Form1.ClientWidth;

    StringGrid1.Width:=PageControl1.Width;
    StringGrid1.Height:=PageControl1.Height-96;

    btCreateReqs.Top:=Form1.ClientHeight-55;
    btnNew.Top:=Form1.ClientHeight-55;
    btnOpen.Top:=Form1.ClientHeight-55;
    btnSave.Top:=Form1.ClientHeight-55;
end;

procedure TForm1.HighLightCell(col, row: Integer; color: TColor; rect: TRect);
begin
  StringGrid1.Canvas.Brush.Color := color;
  StringGrid1.canvas.fillRect(rect);
  StringGrid1.canvas.TextOut(rect.Left,rect.Top,StringGrid1.Cells[col,row]);
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  {Подсветка текущей строки}
  if (ARow=j) and (j<>0)then HighLightCell(ACol,ARow,clLime,Rect);
  {ОбщИмя}
  if (
      (Acol=CN.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and (Length(StringGrid1.Cells[ACol,ARow])<>0) and

        ((Length(StringGrid1.Cells[ACol,ARow])>64) or (StringGrid1.Cells[ACol,ARow][Length(StringGrid1.Cells[ACol,ARow])]=' '))
      )
     then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;

  {Долж}
  if (
      (Acol=T.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and (Length(StringGrid1.Cells[ACol,ARow])<>0) and

        ((Length(StringGrid1.Cells[ACol,ARow])>64) or (StringGrid1.Cells[ACol,ARow][Length(StringGrid1.Cells[ACol,ARow])]=' '))
      )
     then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
  {Подр}
  if (
      (Acol=OU.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and (Length(StringGrid1.Cells[ACol,ARow])<>0) and

        ((Length(StringGrid1.Cells[ACol,ARow])>64) or (StringGrid1.Cells[ACol,ARow][Length(StringGrid1.Cells[ACol,ARow])]=' '))
      )
     then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
  {Орг}
  if (
      (Acol=O.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and (Length(StringGrid1.Cells[ACol,ARow])<>0) and

        ((Length(StringGrid1.Cells[ACol,ARow])>64) or (StringGrid1.Cells[ACol,ARow][Length(StringGrid1.Cells[ACol,ARow])]=' '))
      )
     then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
  {Мыло}
  if (
      (Acol=E.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and
       (
        (Length(StringGrid1.Cells[ACol,ARow])>128) or not IsValidEmail(StringGrid1.Cells[ACol,ARow])
       )
     ) then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
  {СНИЛС}
  if (
      (Acol=SNILS.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and
      ((Length(StringGrid1.Cells[ACol,ARow])>14) or not  CheckSNILS(StringGrid1.Cells[ACol,ARow]))
     ) then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
  {ИНН}
  if (
      (Acol=INN.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and
      ((Length(StringGrid1.Cells[ACol,ARow])>12) or not  CheckINN(StringGrid1.Cells[ACol,ARow]))
     ) then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
  {G}
  if (
      (Acol=G.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and (Length(StringGrid1.Cells[ACol,ARow])<>0) and

        ((Length(StringGrid1.Cells[ACol,ARow])>64) or (StringGrid1.Cells[ACol,ARow][Length(StringGrid1.Cells[ACol,ARow])]=' '))
      )
     then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
  {SN}
  if (
      (Acol=SN.Num) and (ARow<>0)and (ARow<>StringGrid1.RowCount-1) and (Length(StringGrid1.Cells[ACol,ARow])<>0) and

        ((Length(StringGrid1.Cells[ACol,ARow])>60) or (StringGrid1.Cells[ACol,ARow][Length(StringGrid1.Cells[ACol,ARow])]=' '))
      )
     then
     begin
       HighLightCell(ACol,ARow,clRed,Rect);
     end;
end;

procedure TForm1.StringGrid1GetEditText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  EditLine.Text:=StringGrid1.Cells[ACol,ARow];
  Label1.Caption:='Длина: '+inttostr(Length(StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]));
end;

procedure TForm1.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = 86) or (Key = 112)) and (ssCtrl in Shift) then
    begin
      DoClipbrdPaste();
      StringGridColumnsAlign(StringGrid1);
    end;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  EditLine.Text:=StringGrid1.Cells[ACol,ARow];
  Label1.Caption:='Длина: '+inttostr(Length(StringGrid1.Cells[ACol,ARow]));
end;

procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
 EditLine.Text:=StringGrid1.Cells[ACol,ARow];
 StringGridColumnsAlign(StringGrid1);
 Label1.Caption:='Длина: '+inttostr(Length(StringGrid1.Cells[ACol,ARow]));
end;
procedure ctrlv;
//var msg: TMessage;
begin
//msg.LParamLo:= MOD_CONTROL;
//msg.LParamHi:= VK_CONTROL or ord('V');
//PostMessage(GetForegroundWindow, WM_HOTKEY, 0, Msg.LParam);
keybd_event(VK_CONTROL, 0, 0, 0);
keybd_event(Ord('V'), 0, 0, 0);
keybd_event(Ord('V'), 0, KEYEVENTF_KEYUP, 0);
keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);
end;
 procedure TForm1.WMHotKey(var Msg: TWMHotKey);
 var
 s:string;
 //Rect: TRect;
 begin
  if Msg.HotKey=Cont_HotKey then
    begin
      ClipBoard.SetTextBuf(PChar(Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear)));
      ctrlv;
      Form1.fShowHint('Имя контейнер для пользователя '+#13#10+
                       AnsiUpperCase(StringGrid1.Cells[SN.Num,j])+': '+#13#10+
                       Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear),
                       'Носитель: '+Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear));
     end;
  if Msg.HotKey=PIN_HotKey then
    begin
      ClipBoard.SetTextBuf(PChar(StringGrid1.Cells[PIN.Num,j]));
      ctrlv;
      Form1.fShowHint('ПИН для пользователя '+#13#10+
                       AnsiUpperCase(StringGrid1.Cells[SN.Num,j])+': '+#13#10+
                       StringGrid1.Cells[PIN.Num,j],
                       'Носитель: '+Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear));
     end;
  if Msg.HotKey=Extra_HotKey then
    begin
      ClipBoard.SetTextBuf(PChar(StringGrid1.Cells[ComboBox1.ItemIndex,j]));
      ctrlv;
      Form1.fShowHint('ПИН для пользователя '+#13#10+
                       AnsiUpperCase(StringGrid1.Cells[SN.Num,j])+': '+#13#10+
                       StringGrid1.Cells[ComboBox1.ItemIndex,j],
                       'Носитель: '+Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear));
     end;
  if (Msg.HotKey=UP_HotKey) and (j>1) then
    begin
      dec(j);
      StringGrid1.Refresh;
      Form1.fShowHint('Текущий пользователь: '+#13#10+
                       AnsiUpperCase(StringGrid1.Cells[SN.Num,j]),
                       'Носитель: '+Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear));

     end;
  if (Msg.HotKey=DWN_HotKey) and (j<StringGrid1.RowCount-2) then
    begin
      inc(j);
      StringGrid1.Refresh;
      Form1.fShowHint('Текущий пользователь: '+#13#10+
                       AnsiUpperCase(StringGrid1.Cells[SN.Num,j]),
                       'Носитель: '+Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear));
     end;
  if Msg.HotKey=Phrase_HotKey then
    begin
      ClipBoard.SetTextBuf(PChar(StringGrid1.Cells[PHRASE.Num,j]));
      ctrlv;
      Form1.fShowHint('Ключевая фраза для пользователя '+#13#10+
                       AnsiUpperCase(StringGrid1.Cells[SN.Num,j])+': '+#13#10+
                       StringGrid1.Cells[PHRASE.Num,j],
                       'Носитель: '+Translit(StringGrid1.Cells[SN.Num,j])+'_'+IntToStr(CurrentYear));
     end;

  if Msg.HotKey=StdPIN_HotKey then
    begin
      if RadioGroup1.ItemIndex=0 then s:='12345678';
      if RadioGroup1.ItemIndex=1 then s:='1234567890';
      if RadioGroup1.ItemIndex=2 then s:='';
      ClipBoard.SetTextBuf(PChar(s));
      ctrlv;
     end;
end;
procedure TForm1.fShowHint(Text:String;FCaption:string);
var H:HWND;
    Rec:TRect;
    NeededTop:integer;
    HintForm:TForm;
    HintLabel:TLabel;
    aw:hwnd;
begin
  H := FindWindow('Shell_TrayWnd', nil);
  if h=0 then exit;

  GetWindowRect(h, Rec);

  HintForm:=TForm.Create(nil);
  with HintForm do
  begin
    Width:=245;
    Height:=100;

    Color:=clInfoBk;
    BorderStyle:=bsToolWindow;
    Caption:=FCaption;
    BorderIcons:=[];
    FormStyle:=fsStayOnTop;
    //Создаём текст
    HintLabel:=TLabel.Create(nil);
    with HintLabel do
    begin
        Parent:=HintForm;

        WordWrap:=true;

        Caption:=' '+Trim(Text)+' ';

        Align:=alClient;
        Layout:=tlCenter;
        Alignment:=taCenter;
    end;

    AlphaBlend:=true;
    AlphaBlendValue:=255;

    aw:=GetActiveWindow;
    ShowWindow(handle,SW_SHOWNOACTIVATE);
    SetActiveWindow(aw);

    Left:=Screen.Width-Width;
    Top:=Screen.Height-20;

    //Выезжаем вверх
    NeededTop:=Rec.Top-Height;
    while Top>NeededTop do
    begin
      Top:=Top-2;
      Repaint;
      ida.Sleep(6);
      ida.Process;
    end;

    ida.Sleep(2000);

    //Выезжаем вниз
    NeededTop:=Screen.Width-20;
    while Top<NeededTop do
    begin
      Top:=Top+2;
      Repaint;
      ida.Sleep(3);
      ida.Process;
    end;

    HintLabel.Free;
    Free;
  end;

end;

end.
