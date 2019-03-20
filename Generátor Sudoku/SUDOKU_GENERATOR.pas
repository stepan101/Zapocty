{ Generování Sudoku }
{ zimní semestr 2015/16 }
program Sudoku_generator;
uses Crt;
var sudoku: array[0..80] of byte;
    plna: array[0..80] of byte;
    zkus: array[0..80] of byte;
    test:array[1..9] of integer;
    kandidati: array[0..80,1..9] of boolean;
    d,e,f,g,h,pp,oo,xx,n,m,q,r,t,z,l,x,y,k,s,zz,ii,scit,scita,scitani,hh,ll,typ,sloup,ct,pocitani,poc, zkouska:integer;
    tn,konec:char;
    dalsi:boolean;
{GENEROVÁNÍ PLNÉ TBULKY}
{Vynulování tabulky}
procedure inc;
var a:integer;
begin
for a:= 0 to 80 do
    plna[a] := 0;
end;
{Kontrola řádku pro generování}
function radek2:boolean;
begin
    radek2 := true;
    xx := x;

  if (x = 0) or (x mod 9 = 0) then
    radek2 := true
  else if (x > 0) and (x <= 8) then

      repeat
         xx := xx-1;
           if (plna[xx] = ll) then
              radek2 := false;
      until (xx = 0)

    else repeat
         xx := xx-1;
           if (plna[xx] = ll) then
              radek2 := false;
      until (xx mod 9 = 0);
 end;
{Kontrola sloupce pro generování}
function sloupec2:boolean;
  begin
      sloupec2 := true;
      xx := x;

      if (x <= 8) then
        y := 1
      else
        y := (x div 9);

      for k:= 1 to y do
        begin
          xx := xx-9;
         if (plna[xx] = ll) then
          sloupec2 := false;
        end;
  end;
 {Kontrola ctverce pro generování}
function ctverec2:boolean;
 begin
   ctverec2 := true;
     xx := x;
     y := (x div 9);
 if (y in [0,3,6]) then
   ctverec2 := true
 else
  begin
  if (x in [9,12,15,18,21,24,36,39,42,45,48,51,63,66,69,72,75,78]) then
     begin
       if (plna[xx - 17] = ll) or (plna[xx - 16] = ll) or (plna[xx - 8] = ll) or (plna[xx - 7] = ll) then
         ctverec2 := false;
     end;

  if (x in [10,13,16,19,22,25,37,40,43,46,49,52,64,67,70,73,76,79]) then
     begin
       if (plna[xx - 19] = ll) or (plna[xx - 17] = ll) or (plna[xx - 10] = ll) or (plna[xx - 8] = ll) then
         ctverec2 := false;
     end;

  if (x in [11,14,17,20,23,26,38,41,44,47,50,53,65,68,71,74,77,80]) then
     begin
       if (plna[xx - 20] = ll) or (plna[xx - 19] = ll) or (plna[xx - 11] = ll) or (plna[xx - 10] = ll) then
         ctverec2 := false;
     end;

  end;

end;
{Generovani plne tabulky}
procedure generovani;
begin
randomize;
  x := 0;
  zkouska := 0;
  inc;
repeat
   for pp := 1 to 9 do
     test[pp] := pp;
        repeat
              ll := random(9)+1;
              test[ll] := 0;
              dalsi := false;
              zkouska := 0;
              for oo:= 1 to 9 do
                  zkouska:= zkouska + test[oo];
               if radek2 and sloupec2 and ctverec2 then  begin
                plna[x] := ll;
                x := x+1;
                dalsi := true;
              end;
         until (dalsi = true) or (zkouska = 0);
         if (zkouska = 0) then
        x := x-9;
   until x = 81;
  for s:=0 to 80 do
    begin sudoku[s]:=plna[s];zkus[s]:=plna[s]; end;
  end;
 {KONEC GENEROVÁNÍ PLNÉ TBULKY}

{ŘEŠÍCÍ ALGORITMY}
{Kontrola řádku řešení}
function radek:boolean;
var aa,bb,cc:integer;
begin
    radek := true;
    aa:=0;
   while aa<81 do begin
     for bb:=aa to aa+8 do
      begin
        for cc:=bb to aa+8 do
          if(sudoku[bb]=sudoku[cc]) and (sudoku[bb]>0) and (bb<>cc) then begin radek:= false; exit; end;

      end;
    aa:=aa+9;
   end;

 end;
{Kontrola sloupce řešení}
function sloupec:boolean;
var a,b,c:integer;
begin
    sloupec := true;
    c:=0;
    b:=0;

     for a:=0 to 8 do
      begin
        b:=0;
        while b< 81 do begin
          c:=0;
          while c< 81 do begin

          if(sudoku[a+b]=sudoku[c+a]) and (sudoku[a+b]>0) and (b<>c) then begin sloupec:= false; exit; end
            else begin sloupec := true; c:=c+9;end;
            end;
         b:=b+9;
         end;
      end;

   end;
{Kontrola čtverce řešení}
function ctverec:boolean;
var i,j:integer;
begin
 ctverec:=true;
 i:=0;j:=0;
 while j<81 do begin

   while i<9 do
   begin

     if ((sudoku[j+i] = sudoku[j+i+1]) or (sudoku[j+i] = sudoku[j+i+2]) or (sudoku[j+i] = sudoku[j+i+9]) or (sudoku[j+i] = sudoku[j+i+10]) or (sudoku[j+i] = sudoku[j+i+11]) or (sudoku[j+i] = sudoku[j+i+18]) or (sudoku[j+i] = sudoku[j+i+19]) or (sudoku[j+i] = sudoku[j+i+20]))and (sudoku[j+i]>0) then  begin ctverec:=false; exit; end else ctverec:=true;
     if ((sudoku[j+i+1] = sudoku[j+i]) or (sudoku[j+i+1] = sudoku[j+i+2]) or (sudoku[j+i+1] = sudoku[j+i+9]) or (sudoku[j+i+1] = sudoku[j+i+10]) or (sudoku[j+i+1] = sudoku[j+i+11]) or (sudoku[j+i+1] = sudoku[j+i+18]) or (sudoku[j+i+1] = sudoku[j+i+19]) or (sudoku[j+i+1] = sudoku[j+i+20]))and (sudoku[j+i+1]>0) then  begin ctverec:=false; exit; end else ctverec:=true;
     if ((sudoku[j+i+2] = sudoku[j+i+1]) or (sudoku[j+i+2] = sudoku[j+i]) or (sudoku[j+i+2] = sudoku[j+i+9]) or (sudoku[j+i+2] = sudoku[j+i+10]) or (sudoku[j+i+2] = sudoku[j+i+11]) or (sudoku[j+i+2] = sudoku[j+i+18]) or (sudoku[j+i+2] = sudoku[j+i+19]) or (sudoku[j+i+2] = sudoku[j+i+20]))and (sudoku[j+i+2]>0) then  begin ctverec:=false; exit; end else ctverec:=true;

     if ((sudoku[j+i+9] = sudoku[j+i+1]) or (sudoku[j+i+9] = sudoku[j+i+2]) or (sudoku[j+i+9] = sudoku[j+i]) or (sudoku[j+i+9] = sudoku[j+i+10]) or (sudoku[j+i+9] = sudoku[j+i+11]) or (sudoku[j+i+9] = sudoku[j+i+18]) or (sudoku[j+i+9] = sudoku[j+i+19]) or (sudoku[j+i+9] = sudoku[j+i+20]))and (sudoku[j+i+9]>0) then  begin ctverec:=false; exit; end else ctverec:=true;
     if ((sudoku[j+i+10] = sudoku[j+i+1]) or (sudoku[j+i+10] = sudoku[j+i+2]) or (sudoku[j+i+10] = sudoku[j+i+9]) or (sudoku[j+i+10] = sudoku[j+i]) or (sudoku[j+i+10] = sudoku[j+i+11]) or (sudoku[j+i+10] = sudoku[j+i+18]) or (sudoku[j+i+10] = sudoku[j+i+19]) or (sudoku[j+i+10] = sudoku[j+i+20]))and (sudoku[j+i+10]>0) then  begin ctverec:=false; exit; end else ctverec:=true;
     if ((sudoku[j+i+11] = sudoku[j+i+1]) or (sudoku[j+i+11] = sudoku[j+i+2]) or (sudoku[j+i+11] = sudoku[j+i+9]) or (sudoku[j+i+11] = sudoku[j+i+10]) or (sudoku[j+i+11] = sudoku[j+i]) or (sudoku[j+i+11] = sudoku[j+i+18]) or (sudoku[j+i+11] = sudoku[j+i+19]) or (sudoku[j+i+11] = sudoku[j+i+20]))and (sudoku[j+i+11]>0) then  begin ctverec:=false; exit; end else ctverec:=true;

     if ((sudoku[j+i+18] = sudoku[j+i+1]) or (sudoku[j+i+18] = sudoku[j+i+2]) or (sudoku[j+i+18] = sudoku[j+i+9]) or (sudoku[j+i+18] = sudoku[j+i+10]) or (sudoku[j+i+18] = sudoku[j+i+11]) or (sudoku[j+i+18] = sudoku[j+i]) or (sudoku[j+i+18] = sudoku[j+i+19]) or (sudoku[j+i+18] = sudoku[j+i+20]))and (sudoku[j+i+18]>0) then  begin ctverec:=false; exit; end else ctverec:=true;
     if ((sudoku[j+i+19] = sudoku[j+i+1]) or (sudoku[j+i+19] = sudoku[j+i+2]) or (sudoku[j+i+19] = sudoku[j+i+9]) or (sudoku[j+i+19] = sudoku[j+i+10]) or (sudoku[j+i+19] = sudoku[j+i+11]) or (sudoku[j+i+19] = sudoku[j+i+18]) or (sudoku[j+i+19] = sudoku[j+i]) or (sudoku[j+i+19] = sudoku[j+i+20]))and (sudoku[j+i+19]>0) then  begin ctverec:=false; exit; end else ctverec:=true;
     if ((sudoku[j+i+20] = sudoku[j+i+1]) or (sudoku[j+i+20] = sudoku[j+i+2]) or (sudoku[j+i+20] = sudoku[j+i+9]) or (sudoku[j+i+20] = sudoku[j+i+10]) or (sudoku[j+i+20] = sudoku[j+i+11]) or (sudoku[j+i+20] = sudoku[j+i+18]) or (sudoku[j+i+20] = sudoku[j+i+19]) or (sudoku[j+i+20] = sudoku[j+i]))and (sudoku[j+i+20]>0) then  begin ctverec:=false; exit; end else ctverec:=true;

     i:=i+3;
      end;
   i:=0;
   j:=j+27;
 end;
end;
{Zapsání kandidátů do jednotlivých políček}
procedure kandidat;
begin
  for d:=0 to 80 do
   begin
    if (sudoku[d]<>0) then
      begin
      for e:=1 to 9 do
       kandidati[d,e]:=false;
      end
     else begin
       for l:=1 to 9 do begin
          sudoku[d]:=l;
          if radek and sloupec and ctverec then begin
           kandidati[d,l]:=true;
           sudoku[d]:=0;
            end
           else begin
              kandidati[d,l]:=false;
              sudoku[d]:=0;
            end;

          end;

      end;
   end;
end;
{ALGORITMUS: Naked Single}
procedure algoritmus;
begin
 pocitani:=0;
 g:=0;
 while g<81 do
   begin
    if (sudoku[g]=0) then
      begin

                     pocitani:=0;
                     for l:=1 to 9 do begin
                         if  kandidati[g,l] then begin pocitani:=pocitani+1; e:=g; f:=l end;
                                     end;
         if pocitani = 1 then begin sudoku[e]:=f;
         kandidat;
         g:=0;end else g:=g+1;
         end
        else g:=g+1;

          end;

      end;
{ALGORITMUS: Hidden Single na řádku}
procedure algoritmus_radek;
 begin

 h:=0;scita:=0;
 while h<81 do
   begin
    if (sudoku[h]=0) then
      begin
      for l:=1 to 9 do begin
                         if  kandidati[h,l] then begin
                             if ((h mod 9) = 0) then begin
                                   poc:=0;
                                   for m:=h+1 to h+9 do begin
                                    if (sudoku[m]=0) then begin
                                       sudoku[m]:=l;
                                       if radek and sloupec and ctverec then begin sudoku[m]:=0; poc:=poc+1; end

                                        else sudoku[m]:=0;
                                    end;
                                 end;
                                if poc=0 then begin sudoku[h]:=l; kandidat;  h:=0;   end else h:=h+1;
                             end else begin
                              n:=h;
                              while ((n mod 9) <> 0) do n:=n-1;
                                  poc:=0;
                                  for m:=n to n+9 do begin
                                    if (sudoku[m]=0) and (m<>h) then begin
                                       sudoku[m]:=l;
                                        if radek and sloupec and ctverec then begin sudoku[m]:=0; poc:=poc+1; end

                                        else sudoku[m]:=0;
                                    end;
                               end;
                                  if poc=0 then begin sudoku[h]:=l; kandidat;  h:=0; end else h:=h+1;
                             end;
                           end;
                     end; scita:=scita+1; if scita>5000 then exit;
      end else h:=h+1;
end;
 end;
{ALGORITMUS: Hidden Single ve sloupci}
procedure algoritmus_sloupec;
  begin
z:=0;scit:=0;
 while z<81 do
   begin
    if (sudoku[z]=0) then
      begin
      for l:=1 to 9 do begin
                         if  kandidati[z,l] then begin
                           if z<9 then begin
                             q:=0;sloup:=0;
                             while q <81 do begin
                                 if (sudoku[q]=0) and (q<>z) then begin
                                       sudoku[q]:=l;
                                       if radek and sloupec and ctverec then begin
                                         sudoku[q]:=0; sloup:=sloup+1; q:=q+9; end
                                        else begin sudoku[q]:=0; q:=q+9; end;
                                 end else q:=q+9;
                             end;
                           if sloup=0 then begin sudoku[z]:=l; kandidat;  z:=0;    end else z:=z+1;
                           end
                           else begin
                            r:=z; while r>8 do r:=r-9;
                              t:=0;sloup:=0;
                             while t <81 do begin
                                 if (sudoku[t]=0) and (t<>z) then begin
                                       sudoku[t]:=l;
                                       if radek and sloupec and ctverec then begin
                                         sudoku[t]:=0; sloup:=sloup+1; t:=t+9; end
                                        else begin sudoku[t]:=0; t:=t+9; end;
                                 end else t:=t+9;
                             end;
                           if sloup=0 then begin sudoku[z]:=l; kandidat; z:=0; end else z:=z+1;
                           end;


                         end;
                     end;scit:=scit+1; if scit>5000 then exit;
      end else z:=z+1;
end;
end;
{ALGORITMUS: Hidden Single ve čtverci}
procedure algoritmus_ctverec;
begin
zz:=0;scitani:=0;
 while zz<81 do begin
    if (sudoku[zz]=0) then begin
       for l:=1 to 9 do begin
                         if  kandidati[zz,l] then begin
                          case zz of
                           0,3,6,27,30,33,54,57,60:begin
                           hh:=zz;ct:=0;
                           while hh<zz+20 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0; end else zz:=zz+1;
                           end;
                           1,4,7,28,31,34,55,58,61:begin
                           hh:=zz-1; ct:=0;
                           while hh<zz+19 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0; end else zz:=zz+1;
                           end;

                           2,5,8,29,32,35,56,59,62:begin
                           hh:=zz-2;ct:=0;
                           while hh<zz+18 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0;end else zz:=zz+1;
                           end;
                           9,12,15,36,39,42,63,66,69:begin
                           hh:=zz-9; ct:=0;
                           while hh<zz+12 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0; end else zz:=zz+1;
                           end;
                           10,13,16,37,40,43,64,67,70:begin
                           hh:=zz-10;ct:=0;
                           while hh<zz+11 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0; end else zz:=zz+1;
                           end;
                           11,14,17,38,41,44,65,68,71:begin
                           hh:=zz-11; ct:=0;
                           while hh<zz+10 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0; end else zz:=zz+1;
                           end;
                           18,21,24,45,48,51,72,75,78:begin
                           hh:=zz-18; ct:=0;
                           while hh<zz+3 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0; end else zz:=zz+1;
                           end;
                           19,22,25,46,49,52,73,76,79:begin
                           hh:=zz-19;  ct:=0;
                           while hh<zz+2 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat; zz:=0;  end else zz:=zz+1;
                           end;
                           20,23,26,47,50,53,74,77,80:begin begin
                           hh:=zz-20;ct:=0;
                           while hh<zz+1 do
                             begin
                             ii:=0;
                             while ii<3 do begin
                                   if (sudoku[hh+ii]=0) and ((hh+ii)<>zz)then begin
                                    sudoku[hh+ii]:=l;
                                     if radek and sloupec and ctverec then begin
                                         sudoku[hh+ii]:=0; ct:=ct+1; ii:=ii+1; end
                                        else begin sudoku[hh+ii]:=0; ii:=ii+1; end;
                                   end else ii:=ii+1;

                                end;hh:=hh+9;
                             end; if ct=0 then begin sudoku[zz]:=l; kandidat;  zz:=0; end else zz:=zz+1;
                           end;
                          end;
                         end;
         end;
       end;
    scitani:=scitani+1; if scitani>5000 then exit;
  end else zz:=zz+1;
 end;
 end;
{KONEC ŘEŠÍCÍCH ALGORITMŮ}

{Kombinace algoritmů s řešením}
function zkous(n:integer):boolean;
var a:integer;
begin
 if n= 1 then begin
  kandidat;
  algoritmus;
end
 else if n=2 then begin
 kandidat;
 algoritmus;
 algoritmus_ctverec;
 algoritmus_sloupec;
 algoritmus_radek;
 end
 else if n=3 then begin
 kandidat;
 algoritmus;
 algoritmus_ctverec;
 algoritmus_sloupec;
 algoritmus_radek;
 algoritmus_ctverec;
 algoritmus_sloupec;
 algoritmus_radek;
   end;

zkous:=true;
  for a:=0 to 80 do
  begin
    if sudoku[a]=0 then begin zkous:= false; exit;end;
  end;
end;


 {DĚROVÁNÍ PLNÉ TABULKY}
procedure derovani(n:integer);
var l,k:integer;
    spravnost:boolean;
begin
randomize;
  spravnost:=true;

 while spravnost do begin
      k:=random(81);
      l:=zkus[k];
      zkus[k]:=0;
      sudoku:=zkus;
      if (zkous(n)=false) then begin zkus[k]:=l; spravnost:=false; end;
    end;
   end;



{ZAPSÁNÍ DO TEXTOVÝCH SOUBORŮ}
procedure zapis;
var f:textfile;
      i:integer;

begin
  assignfile(f,'reseni.txt');
  rewrite(f);

     for i:=0 to 80 do
   begin
  write(f,plna[(i)],' ');
        if ((i+1) mod 3 = 0) then write(f,' ');
        if ((i+1) mod 9 = 0) then writeln(f);
         if ((i)= 26)then writeln(f);
        if ((i)= 53)then writeln(f);

        end;
   close(f);
end;
procedure zapis_zadani;
var f:textfile;
      i:integer;
begin
  assignfile(f,'zadani.txt');
  rewrite(f);

     for i:=0 to 80 do
   begin
   if zkus[(i)]=0 then write(f,'.',' ') else
   write(f,zkus[(i)],' ');
        if ((i+1) mod 3 = 0) then write(f,' ');
        if ((i+1) mod 9 = 0) then writeln(f);
        if ((i)= 26)then writeln(f);
        if ((i)= 53)then writeln(f);



        end;
   close(f);
end;
{VIDITELNÉ TĚLO}
procedure zadani;
 begin
 Writeln('Automaticke generovani zadani a reseni Sudoku ');
 Writeln('Zapoctovy program - Stepan Picek ');
 Writeln('Pro vygenerovani jednoduche sukodu zmacknete: l');
 Writeln('Pro vygenerovani stredne tezke sukodu zmacknete: s');
 Writeln('Pro vygenerovani tezke sukodu zmacknete: t');
 tn:=readKey;
 if (tn = 'l') then typ:=1
 else if (tn = 's') then typ:=2
 else if (tn = 't') then typ:=3
 else typ:=4;

   if (typ<>4) then begin
   Writeln('Sudoku se generuje');
   generovani;
   derovani(typ);
   Writeln('Zadani a reseni sudkou bylo uspesne vygenerovano a ulozeno.');
   Writeln('Pro ukonceni stisknete libivolnou klavesnici.');
   zapis;
   zapis_zadani;
   end else writeln('Zmackli jste spatnou klavesnici, program se po stisknuti libovolne klavesnice ukonci!');
   konec:=readKey;
 end;
begin
   zadani;
 end.                                                            
