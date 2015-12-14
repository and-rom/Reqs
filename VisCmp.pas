unit VisCmp;

interface

  uses Grids;

    procedure StringGridColumnsAlign(Grid: TStringGrid);

implementation
{begin}

procedure StringGridColumnsAlign(Grid: TStringGrid);
var
  x, y, w: integer;
  MaxWidth: integer;
begin
  with Grid do
  
  begin
    for x := 0 to ColCount - 1 do
    begin
      if x=1 then continue;
      
      MaxWidth :=0;
      for y := 0 to RowCount - 1 do
      begin
        w := Canvas.TextWidth(Cells[x,y]);
        if w > MaxWidth then
          MaxWidth := w           
      end;

      ColWidths[x] := MaxWidth+5;
    end;
  end;
end;

{end}
end.
