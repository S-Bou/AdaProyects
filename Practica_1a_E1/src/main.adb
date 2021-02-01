--*****************************************************************************************************************************************
with Text_IO; use Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;
--*****************************************************************************************************************************************
procedure Main is

   type vectstr is array (Integer range <>) of string(1..2);
   name : vectstr(0..3);

   type vectnum is array (Integer range <>) of float;
   posi : vectnum(0..3);

   dx, dy, distance : float;
--*****************************************************************************************************************************************
begin

   name := ("x1", "y1", "x2", "y2");

   for i in 0..3 loop       -- = for i in posi'range loop
      Put("Introduzca ");Put(name(i));Put(" en formato real");Put(": ");
      Get(posi(i));
   end loop;

   Put("P1 = (");Put(posi(0), 1, 1, 0);Put(", ");Put(posi(1), 1, 1, 0);Put(")");    --(float, SpaceLeft, Decimals, Exponents)
   New_Line;
   Put("P2 = (");Put(posi(2), 1, 1, 0);Put(", ");Put(posi(3), 1, 1, 0);Put(")");
   New_Line;

   dx := posi(2)-posi(0);
   dy := posi(3)-posi(1);
   distance := sqrt(dx*dx+dy*dy);

   Put("Distancia de separación: ");Put(distance, 1, 1, 0); --Expresion by floats: Put(float, left space, decimals, exponents)
   Put_line(" unidades");
   New_line;
end Main;
--*****************************************************************************************************************************************
