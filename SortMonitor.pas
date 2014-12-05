unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

const
    BtnHeight = 50;
type
  TForm1 = class(TForm)
    btnFill: TButton;
    ComboBox1: TComboBox;
    btnGo: TButton;
    chkCompare: TCheckBox;
    ComboBox2: TComboBox;
    TrackBar1: TTrackBar;
    lblSize: TLabel;
    procedure RandomGen(Sender: TObject);
    procedure ShowPoint(i : Integer);
    procedure HidePoint(i : Integer);
    procedure FormCreate(Sender: TObject);
    procedure Go(Sender: TObject);
    { sorts }
    procedure Bubble;
    procedure Shaker;
    procedure Gnome;
    procedure Insertion;
    procedure Quick(l, r : Integer);
    procedure Selection;
    procedure Shell;
    procedure Heap;
    procedure Shear;
    procedure MergeSort(l, r : Integer);
    procedure OddEvenTransposition;
    procedure ChangeSize(Sender: TObject);
  private
    a : array[1..1000] of Integer;
    MaxNumbers: Integer;
    procedure swap(i, j : Integer);
    procedure compare(i, j : Integer);
    procedure DisableButtons;
    procedure EnableButtons;
    procedure UpdateWindow;
    procedure Makeheap(n : Integer);
    procedure Heapify(n, i : Integer);
    procedure Merge(l, m, r : Integer);
    procedure SortPart1(low,hi,nx:integer; up:boolean);
    procedure SortPart2(low,hi,nx:integer; up:boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Math;

{$R *.dfm}

procedure TForm1.compare(i, j : Integer);
var x : Integer;
begin
    if (chkCompare.Checked=false) then exit;
    Canvas.Pen.Color := clRed;
    Canvas.MoveTo(i*2,ClientHeight-MaxNumbers*2);
    Canvas.LineTo(i*2,ClientHeight);
    Canvas.MoveTo(j*2,ClientHeight-MaxNumbers*2);
    Canvas.LineTo(j*2,ClientHeight);
    for x:=1 to 1000000 do ;
    Canvas.Pen.Color := clBtnFace;
    Canvas.MoveTo(i*2,ClientHeight-MaxNumbers*2);
    Canvas.LineTo(i*2,ClientHeight);
    Canvas.MoveTo(j*2,ClientHeight-MaxNumbers*2);
    Canvas.LineTo(j*2,ClientHeight);
    ShowPoint(i);
    ShowPoint(j);
end;

procedure TForm1.ShowPoint(i : Integer);
var x, y : Integer;
begin
    x := i*2;
    y := ClientHeight-a[i]*2;
    Canvas.Pixels[x,y] := clBlack;
    Canvas.Pixels[x,y+1] := clBlack;
    Canvas.Pixels[x+1,y] := clBlack;
    Canvas.Pixels[x+1,y+1] := clBlack;
end;

procedure TForm1.HidePoint(i : Integer);
var x, y : Integer;
begin
    x := i*2;
    y := ClientHeight-a[i]*2;
    Canvas.Pixels[x,y] := clBtnFace;
    Canvas.Pixels[x,y+1] := clBtnFace;
    Canvas.Pixels[x+1,y] := clBtnFace;
    Canvas.Pixels[x+1,y+1] := clBtnFace;

end;

procedure TForm1.swap(i, j : Integer);
var t : Integer;
begin
    HidePoint(i);
    HidePoint(j);
    t := a[i];
    a[i] := a[j];
    a[j] := t;
    ShowPoint(i);
    ShowPoint(j);
end;

procedure TForm1.DisableButtons;
begin
    ComboBox1.Enabled := false;
    ComboBox2.Enabled := false;
    btnGo.Enabled := false;
    btnFill.Enabled := false;
end;

procedure TForm1.EnableButtons;
begin
    ComboBox1.Enabled := true;
    ComboBox2.Enabled := true;
    btnGo.Enabled := true;
    btnFill.Enabled := true;
end;

procedure TForm1.RandomGen(Sender: TObject);
var
    i,j,k,x : Integer;
    t : Integer;
begin
    t := ComboBox2.ItemIndex;
    for i:=1 to MaxNumbers do HidePoint(i);
    case t of
    0:
        for i:=1 to MaxNumbers do
            a[i] := Random(MaxNumbers);
    1:
        for i:=1 to MaxNumbers do
            a[i] := i-1;
    2:
        for i:=1 to MaxNumbers do
            a[i] := MaxNumbers - i;
    3:  begin
        for i:=1 to MaxNumbers do
            a[i] := i-1;
        for i:=1 to 1000000 do
        begin
            j := RandomRange(1,MaxNumbers);
            k := RandomRange(1,MaxNumbers);
            x := a[j];
            a[j] := a[k];
            a[k] := x;
        end;
        end;
    4: begin
        for i:=1 to MaxNumbers div 2 do
            a[i] := MaxNumbers div 2 - i;
        for i:= MaxNumbers div 2 to MaxNumbers do
            a[i] :=  MaxNumbers - i + (MaxNumbers div 2);
       end;
    5: begin
        j := 1;
        k := 2;
        for i:= 1 to MaxNumbers do begin
            a[i] := j;
            Inc(j,k);
            if (j>MaxNumbers) then begin
                a[i] := MaxNumbers;
                k := -k;
                j := j +k -1;
            end;
        end;
       end;
    6: begin
        a[MaxNumbers div 2] := MaxNumbers;
        j := 1;
        k := MaxNumbers;
        i := MaxNumbers;
        while i>0 do begin
            if (i=MaxNumbers div 2) then dec(i);
            a[i] := j;
            inc(j); dec(i);
            if (i=maxNumbers div 2) then dec(i);
            if (i>0) then a[i] := k;
            dec(k); dec(i);
        end;
       end;
    7: begin
        a[MaxNumbers div 2] := MaxNumbers;
        a[(MaxNumbers div 2)-1] := 1;
        j := 2;
        i := 1;
        while i<=MaxNumbers do begin
            if (i<>(MaxNumbers div 2)) and
               (i<>(MaxNumbers div 2)-1) then begin
               a[i]:=j;
               inc(j);
               end;
            inc(i);
        end;
       end;
    end;
    for i:=1 to MaxNumbers do ShowPoint(i);
end;

procedure TForm1.Go(Sender: TObject);
var i:integer;
begin
    DisableButtons;
    i := ComboBox1.ItemIndex;
    case i of
        0: Bubble;
        1: Shaker;
        2: Gnome;
        3: Insertion;
        4: Quick(1,MaxNumbers);
        5: Selection;
        6: Shell;
        7: Heap;
        8: MergeSort(1,MaxNumbers);
        9: OddEvenTransposition;
        10: Shear;
    end;
    EnableButtons;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
    TrackBar1.Position := 250;
    MaxNumbers := 250;

    ComboBox1.Items.Clear;
    ComboBox1.Items.Add('Bubble Sort');
    ComboBox1.Items.Add('Shaker Sort');
    ComboBox1.Items.Add('Gnome Sort');
    ComboBox1.Items.Add('Insertion Sort');
    ComboBox1.Items.Add('Quick Sort');
    ComboBox1.Items.Add('Selection Sort');
    ComboBox1.Items.Add('Shell Sort');
    ComboBox1.Items.Add('Heap Sort');
    ComboBox1.Items.Add('Merge Sort');
    ComboBox1.Items.Add('Odd-Even Transposition Sort');
    ComboBox1.Items.Add('Shear Sort');
    ComboBox1.ItemIndex := 0;

    ComboBox2.Items.Clear;
    ComboBox2.Items.Add('Random Data');
    ComboBox2.Items.Add('Sorted Data');
    ComboBox2.Items.Add('Reversed Data');
    ComboBox2.Items.Add('Uniform Dist. Data');
    ComboBox2.Items.Add('Misc 1!');
    ComboBox2.Items.Add('Misc 2!');
    ComboBox2.Items.Add('Misc 3!');
    ComboBox2.Items.Add('Misc 4!');
    ComboBox2.ItemIndex := 0;

    UpdateWindow;
end;

procedure TForm1.UpdateWindow;
begin
    lblSize.Caption := IntToStr(MaxNumbers);
    ClientWidth := MaxNumbers*2;
    ClientHeight := MaxNumbers*2 + btnGo.Height + btnGo.Top + 10;
end;

procedure TForm1.Bubble;
var
    i, j : Integer;
begin
    for i:=MaxNumbers downto 1 do
        for j:=1 to i-1 do
        begin
            compare(j,j+1);
            if a[j] > a[j+1] then
                swap(j,j+1);
        end;
end;


procedure TForm1.Shaker;
var
    first, last, i, p : Integer;
begin
    first := 1;
    last := MaxNumbers;
    p := first;
    repeat
        for i:=first to last-1 do
        begin
            compare(i,i+1);
            if a[i] > a[i+1] then
            begin
                swap(i,i+1);
                p := i;
            end;
        end;
        last := p;
        for i:=last-1 downto first do
        begin
            compare(i,i+1);
            if a[i] > a[i+1] then
            begin
                swap(i,i+1);
                p := i;
            end;
        end;
        first := p;
    until first >= last;
end;

procedure TForm1.Gnome;
var i : Integer;
begin
    i := 1;
    while i < MaxNumbers do
    begin
        compare(i,i+1);
        if a[i] <= a[i+1] then Inc(i)
        else begin
            swap(i, i+1);
            Dec(i);
            if i = -1 then i := 0;
        end;
    end;
end;

procedure TForm1.Insertion;
var
    i, j : Integer;
begin
    for i:=2 to MaxNumbers do
    begin
        j := i;
        compare(j,j-1);
        while (j > 1)and(a[j] < a[j-1]) do
        begin
            swap(j-1, j);
            Dec(j);
            compare(j,j-1);
        end;
    end;
end;

procedure TForm1.Quick(l, r : Integer);
var i, j, x, pivot : Integer;
begin
	i := l;
    j := r;
//    x := a[(l+r)div 2];
    pivot := RandomRange(l,r);
    x := a[pivot];
	repeat
		while(a[i] < x) do begin
            compare(i,pivot);
            Inc(i);
        end;
		while(x < a[j]) do begin
            compare(j,pivot);
            Dec(j);
        end;
		if (i <= j) then
        begin
			swap(i,j);
			Inc(i); Dec(j);
		end;
	until (i > j);
	if (l < j) then Quick(l,j);
	if (i < r) then Quick(i,r);
end;

procedure TForm1.Selection;
var
    min , i, j : Integer;
begin
	for i:=1 to MaxNumbers-1 do
    begin
		min := i;
		for j:=i+1 to MaxNumbers do
        begin
            compare(j,min);
			if a[j] < a[min] then min := j;
        end;
    	swap(i, min);
	end;
end;

procedure TForm1.Shell;
var
    gap, i, j : Integer;
begin
	gap := MaxNumbers div 2;
    while gap > 0 do
    begin
        for i:=gap to MaxNumbers-1 do
        begin
            j := i;
            compare(j+1,j-gap+1);
            while (j>=gap)and(a[j+1]<a[j-gap+1]) do
            begin
                swap(j+1, j-gap+1);
                Dec(j, gap);
                compare(j+1, j-gap+1);
            end;
        end;
        gap := gap div 2;
    end;
end;

procedure TForm1.Heapify(n, i : Integer);
var j, lch, rch : Integer;
begin
    while True do
    begin
        j := i;
        lch := 2*j + 0;
        rch := 2*j + 1;
        compare(i, lch);
        if (lch < n)and(a[i] < a[lch]) then i := lch;
        compare(i, rch);
        if (rch < n)and(a[i] < a[rch]) then i := rch;
        if i<>j then swap(i, j)
        else break;
    end;

end;

procedure TForm1.Makeheap(n : Integer);
var i : Integer;
begin
    for i:=(n div 2) downto 1 do
        Heapify(n, i);
end;

procedure TForm1.Heap;
var i : Integer;
begin
    MakeHeap(MaxNumbers);
    for i:=MaxNumbers downto 2 do
    begin
        swap(1, i);
        Heapify(i, 1);
    end;
end;

procedure TForm1.Merge(l, m, r : Integer);
var
    i, j, k, size : Integer;
    tmp : array of Integer;
begin
    i := l;
    j := m + 1;
    size := r - l + 1;
    SetLength(tmp, size+1);
    for k:=1 to size do
    begin
        compare(i, j);
        if ((a[i] < a[j])and(i <= m))or(j > r) then begin
            tmp[k] := a[i];
            Inc(i);
        end
        else begin
            tmp[k] := a[j];
            Inc(j);
        end;
    end;
    for i:=1 to size do
    begin
        HidePoint(l + i - 1);
        a[l + i - 1] := tmp[i];
        ShowPoint(l+ i - 1);
    end;

end;

procedure TForm1.MergeSort(l, r : Integer);
var m : Integer;
begin
    m := (l + r) div 2;

    if l = r then exit;

    MergeSort(l, m);
    MergeSort(m+1, r);

    Merge(l, m, r);
end;

procedure TForm1.OddEvenTransposition;
var
    i, j, n : Integer;
begin
    n := MaxNumbers;
	for i:=1 to (n div 2) do
	begin
        j := 1;
		while j <= n-1 do
        begin
            compare(j, j+1);
            if a[j] > a[j+1] then
				swap(j, j+1);
            Inc(j, 2);
        end;
        j := 2;
        while j <= n-1 do
        begin
            compare(j, j+1);
            if a[j] > a[j+1] then
				swap(j, j+1);
            Inc(j, 2);
        end;
	end;
end;

procedure TForm1.SortPart1(low,hi,nx: integer; up: boolean);
var
    i : integer;
begin
    i := low;
    while (i+nx<hi) do begin
        compare(i+1,i+nx+1);
        if
            ((up) and (a[i+1]>a[i+nx+1])) or
            ((not up) and (a[i+1]<a[i+nx+1])) then swap(i+1,i+nx+1);
        i := i + (2*nx);
    end;
end;

procedure TForm1.SortPart2(low,hi,nx: integer; up: boolean);
var
    i : integer;
begin
    i := low+nx;
    while (i+nx<hi) do begin
        compare(i+1,i+nx+1);
        if
            ((up) and (a[i+1]>a[i+nx+1])) or
            ((not up) and (a[i+1]<a[i+nx+1])) then swap(i+1,i+nx+1);
        i := i + (2*nx);
    end;
end;

procedure TForm1.Shear;
var
    Log,Rows,Cols: integer;
    Pow,_div: integer;
    h: array[1..1000] of integer;
    i,j,k: integer;
    n:integer;
begin
    Pow := 1;
    _div := 1;
    n := MaxNumbers;
    i := 1;
    while (i*i<=n) do begin
        if (n mod i = 0) then _div := i;
        Inc(i);
    end;
    Rows := _div;
    Cols := n div _div;
    Log := 0;
    while (Pow<=Rows) do begin
        Pow := Pow * 2;
        Inc(Log);
    end;
    for i:=0 to Rows-1 do h[i] := i*Cols;
    for k:=0 to Log-1 do begin
        for j:=0 to (Cols div 2)-1 do begin
            for i:=0 to Rows-1 do
                SortPart1(i*Cols,(i+1)*Cols,1,(i mod 2 = 0));
            for i:=0 to Rows-1 do
                SortPart2(i*Cols,(i+1)*Cols,1,(i mod 2 = 0));
        end;
        for j:=0 to (Rows div 2)-1 do begin
            for i:=0 to Cols-1 do
                SortPart1(i,Rows*Cols+i,Cols,true);
            for i:=0 to Cols-1 do
                SortPart2(i,Rows*Cols+i,Cols,true);
        end;
    end;
    for j:=0 to (Cols div 2)-1 do begin
        for i:=0 to Rows-1 do
            SortPart1(i*Cols,(i+1)*Cols,1,true);
        for i:=0 to Rows-1 do
            SortPart2(i*Cols,(i+1)*Cols,1,true);
    end;
    for i:=0 to Rows-1 do h[i]:=-1;
end;

procedure TForm1.ChangeSize(Sender: TObject);
begin
    MaxNumbers := TrackBar1.Position;
    UpdateWindow;
    Repaint;
    RandomGen(nil);
end;

end.
