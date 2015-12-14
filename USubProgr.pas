unit USubProgr;

interface
uses SysUtils;
  function CheckAllowed(const s: string): boolean;
  function IsValidEmail(const Value: string): boolean;
  Function russianQuoting(strForQuote:String):String;
  function CheckINN(const INN: string): Boolean;
  function CheckSNILS(const SNILS: string): Boolean;
  function Translit (const Str: string): string;
implementation
  function CheckAllowed(const s: string): boolean;
    var
      i: integer;
    begin
      Result:= false;
      for i:= 1 to Length(s) do
      begin
        if not (s[i] in ['a'..'z', 'A'..'Z', '0'..'9', '_', '-', '.']) then
          Exit;
      end;
      Result:= true;
    end;

  function IsValidEmail(const Value: string): boolean;
  var
    i: integer;
    namePart, serverPart: string;
  begin
    Result:= false;
    i:= Pos('@', Value);
    if i = 0 then
      Exit;
    namePart:= Copy(Value, 1, i - 1);
    serverPart:= Copy(Value, i + 1, Length(Value));
    if (Length(namePart) = 0) or ((Length(serverPart) < 5)) then
      Exit;
    i:= Pos('.', serverPart);
    if (i = 0) or (i > (Length(serverPart) - 2)) then
      Exit;
    Result:= CheckAllowed(namePart) and CheckAllowed(serverPart);
  end;
function ReplaceStr(const S, Srch, Replace: string): string;
{замена подстроки в строке}
var
  I: Integer;
  Source: string;
begin
  Source := S;
  Result := '';
  repeat
    I := Pos(Srch, Source);
    if I >0 then
    begin
      Result := Result + Copy(Source, 1, I - 1) + Replace;
      Source := Copy(Source, I + Length(Srch), MaxInt);
    end
    else
      Result := Result + Source;
  until I<= 0;
end;
Function russianQuoting(strForQuote:string):string;
begin        //заменим кавычку с пробелом перед ней
        strForQuote:= ReplaceStr(strForQuote,   '('+Chr(34)+Chr(34)   ,   '('+Chr(34)+Chr(171)   );
        strForQuote:= ReplaceStr(strForQuote,   Chr(34)+Chr(34)+')'   ,   Chr(187)+Chr(34)+')'   );

        strForQuote:= ReplaceStr(strForQuote,   ','+Chr(34)+Chr(34)   ,   ','+Chr(34)+Chr(171)   );
        strForQuote:= ReplaceStr(strForQuote,   Chr(34)+Chr(34)+','   ,   Chr(187)+Chr(34)+','   );

        strForQuote:= ReplaceStr(strForQuote,   ' '+Chr(34)   ,   ' '+Chr(171)   );
        strForQuote:= ReplaceStr(strForQuote,   Chr(34)+' '   ,   Chr(187)+' '   );

        russianQuoting:= strForQuote;
End;

  function OnlyDigits(const s: string): boolean;
    var
      i: integer;
    begin
      Result:= false;
      for i:= 1 to Length(s) do
      begin
        if not (s[i] in ['0'..'9']) then
          Exit;
      end;
      Result:= true;
    end;

function CheckINN(const INN: string): Boolean;
const
  factor1: array[0..8] of byte = (2, 4, 10, 3, 5, 9, 4, 6, 8);
  factor2: array[0..9] of byte = (7, 2, 4, 10, 3, 5, 9, 4, 6, 8);
  factor3: array[0..10] of byte = (3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8);
var
  i: byte;
  sum: word;
  sum2: word;
begin
  Result := False;
  if not OnlyDigits(INN) then exit;

  try
    if Length(INN) = 10 then begin
      sum := 0;
      for i := 0 to 8 do
        sum := sum + StrToInt(INN[i + 1]) * factor1[i];
      sum := sum mod 11;
      sum := sum mod 10;
      Result := StrToInt(INN[10]) = sum;
    end
    else if Length(INN) = 12 then begin
      sum := 0;
      for i := 0 to 9 do
        sum := sum + StrToInt(INN[i + 1]) * factor2[i];
      sum := sum mod 11;
      sum := sum mod 10;
      sum2 := 0;
      for i := 0 to 10 do
        sum2 := sum2 + StrToInt(INN[i + 1]) * factor3[i];
      sum2 := sum2 mod 11;
      sum2 := sum2 mod 10;
      Result := (StrToInt(INN[11]) = sum) and
        (StrToInt(INN[12]) = sum2);
    end; //
  except
    Result := False;
  end; // try
end;
function CheckSNILS(const SNILS: string): Boolean;
var
  sum: Word;
  i: Byte;
begin
  Result := False;
  if not OnlyDigits(SNILS) then exit;

  sum := 0;
  if Length(SNILS) <> 11 then Exit;

  try
    for i := 1 to 9 do
      sum := sum + StrToInt(SNILS[i]) * (9 - i + 1);
    sum := sum mod 101;
    Result := StrToInt(Copy(SNILS, 10, 2)) = sum;
  except
    Result := False;
  end; // try
end;
function Translit (const Str: string): string;
const
  RArrayL = 'абвгдеЄжзийклмнопрстуфхцчшщьыъэю€';
  RArrayU = 'јЅ¬√ƒ≈®∆«»… ЋћЌќѕ–—“”‘’÷„Ўў№џЏЁёя';
  colChar = 33;
  arr: array[1..2, 1..ColChar] of string =
  (('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y',
    'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f',
    'kh', 'ts', 'ch', 'sh', 'shch', '''', 'y', '''', 'e', 'yu', 'ya'),
    ('A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y',
    'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F',
    'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '''', 'Y', '''', 'E', 'Yu', 'Ya'));
var
  i: Integer;
  LenS: Integer;
  p: integer;
  d: byte;
begin
  result := '';
  LenS := length(str);
  for i := 1 to lenS do
  begin
    d := 1;
    p := pos(str[i], RArrayL);
    if p = 0 then
    begin
      p := pos(str[i], RArrayU);
      d := 2
    end;
    if p <> 0 then
      result := result + arr[d, p]
    else
      result := result + str[i]; //если не русска€ буква, то берем исходную
  end;
end;
end.
