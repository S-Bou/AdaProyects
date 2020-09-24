with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;   use Ada.Float_Text_IO;

procedure Main is
   --  Definicion de vector
   type Vector is array (Integer range <>) of Integer;
   V1 : Vector(0..10);

begin
   V1(0) := 666;
   if V1(0) = 666 then
      -- Imprimir por consola
      Text_IO.Put_Line("Hello world");
      --Salto de linea
      New_Line;
   else
      Text_IO.Put_Line("World is destroyed");
      New_Line;
   end if;
end Main;
