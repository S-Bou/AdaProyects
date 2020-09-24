with Text_IO;
with Ada_Imteger_Text_IO;
with Ada_Float_Text_IO;

procedure Main is

begin
   --  Definition of vector:
   type Vector is array (Integer range <>) of Integer;
   V1 : Vector(0..10);
   -- Imprimir por consola:
   Text_IO.Put_Line("Hola");

   null;
end Main;
