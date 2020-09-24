program life;
uses sysutils;
{ Create and print a neighbors
  Daniel Scharstein 2009
}

const
   rows = 37;
   cols = 37;

type
  homie = record
         alive : boolean;
         end;
  neighbors  = array[1..rows, 1..cols] of homie;



function initneighbors():neighbors;
var r, c : integer;
var myneighbors: neighbors;
var myhomie: homie;
begin
  myhomie.alive:=False;
   for r := 1 to rows do
      for c := 1 to cols do
      begin
        if (random(2)=0) then
          begin
            myneighbors[r][c] := myhomie;
          end
        else
        begin
          myhomie.alive:=True;
          myneighbors[r][c] := myhomie;
          myhomie.alive:=False;
        end;
      end;
  initneighbors:=myneighbors;
end;


procedure printhomies(var myneighbors: neighbors);
var r, c : integer;
begin
  for r := 1 to rows do
    begin
      for c := 1 to cols do
      begin
      if myneighbors[r][c].alive then
        write('#') else write(' .');
      end;
      writeln;
    end;

end;

function updatehomies(generations:integer; var myneighbors :neighbors): neighbors;
var r, c, l, m, i : integer;
var surroundings: integer;
begin
for i:=1 to generations do
  begin
  for r := 1 to rows do
    begin

     for c := 1 to cols do
       begin

       surroundings:=0;
       for l:=-1 to 1 do
        begin
         for m:=-1 to 1 do
           begin
             if myneighbors[l+r][m+c].alive then
               inc(surroundings);
           end;

          if (myneighbors[r][c].alive) and ((surroundings=2) or (surroundings=3)) then
            myneighbors[r][c].alive:=False
          else
            if myneighbors[r][c].alive=False and (surroundings=3) then
              myneighbors[r][c].alive:=True
              else
                myneighbors[r][c].alive:=False;
        end;
      end;
    end;
        writeln('Generation: ',i);
        printhomies(myneighbors);
        sleep(200);
        writeln();
  end;
end;


{ program -------------------- }
var generations:integer;
var myneighbors:neighbors;
begin
   randomize;
   myneighbors:=initneighbors;
   printhomies(myneighbors);
   writeln('How many generations?');
   readln(generations);
   updatehomies(generations,myneighbors);
end.
