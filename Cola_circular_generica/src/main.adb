with colas;
with Text_IO; use text_io;
with ada.integer_Text_IO; use ada.integer_Text_IO;

procedure Main is

   procedure Imprime_enteros(a: integer) is
      begin
      ada.integer_Text_IO.Put(a);
   end imprime_enteros;

   package colas_enteros is new colas(integer, Imprime_enteros);
   use colas_enteros;

   type coordenadas is record
      x,y: integer;
   end record;

   --package colas_coord is new colas(coordenadas);
  -- use colas_coord;
  -- C2: colas_coord.cola_circular;

   C1: colas_enteros.Cola_circular;
   I: integer;
   coord1, coord2: coordenadas;

begin
  Anyadir(C1,1);
   Anyadir(C1,2);
  Anyadir(C1,3);
 Sacar(C1,I);
   Anyadir(C1,4);
  Anyadir(C1,5);


   Listar(C1);
   coord1.x:=30;
   coord1.y:=45;

  --Anyadir(C2,coord1);
 --   Sacar(C2,coord2);

   --Put("Coordenada x: ");
   --Put(coord2.x);
  -- New_line;
  -- Put_line("Coordenada x: " & integer'image(coord2.x));
  --   Put_line("Coordenada y: " & integer'image(coord2.y));



end Main;
