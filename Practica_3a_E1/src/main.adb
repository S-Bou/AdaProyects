with Text_IO; use Text_IO;
with ada.Real_Time; use ada.Real_Time;
with barreras; use barreras;
procedure Main is

   task type coche(id:integer; e_in:integer; e_out:integer);
      espera_dentro : integer;
      espera_fuera  : integer;
   task body coche is
   begin
      espera_dentro := e_in;
      espera_fuera  := e_out;
      loop
            -- Entra en tramo compartido
         barrera.entrar; -- Protocolo de entrada
            put_line("Coche" & integer'image(id) & " en cruze");
            delay to_duration(milliseconds(espera_dentro));

            -- Sale en tramo compartido
            put_line("Coche" & integer'image(id) & " fuera de cruze");
         barrera.salir; -- Protocolo de salida
            delay to_duration(milliseconds(espera_fuera));

      end loop;
   end coche;

   C1 : coche(1, 10, 20);
   C2 : coche(2, 15, 15);
   C3 : coche(3, 20, 30);
   C4 : coche(4, 35, 35);
   C5 : coche(5, 30, 45);
   C6 : coche(6, 40, 50);

begin
   --  Insert code here.
   null;
end Main;
