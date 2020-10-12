with Text_IO; use Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with vectors; use vectors;

procedure Main is
   vecR, vecL, data : Vector(1..10);
   num : float := 2.0;

begin
   for i in data'range loop
      vecR(i) := float(i);
      vecL(i) := float(i);
      data(i) := 0.0;
   end loop;

   data := num + vecR;
   printv(data);
   New_line;

   data := num * vecR;
   printv(data);
   New_line;

   data := vecL * vecR;
   printv(data);
   New_line;

   data := vecL + vecR;
   printv(data);

end Main;
