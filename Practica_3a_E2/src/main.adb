with Text_IO; use Text_IO;
with ada.Real_Time; use ada.Real_Time;
with barreras; use barreras;
procedure Main is

   task type coche(id:integer; e_in:integer; e_out:integer; lado:character);
      espera_dentro : integer;
      espera_fuera  : integer;
   task body coche is
   begin
      espera_dentro := e_in;
      espera_fuera  := e_out;
      loop
         if lado = 'N' then

            barrera.entra_Norte; -- Protocolo de entrada
               -- Entra en tramo compartido
               put_line("Coche" & integer'image(id) & " en cruze");
               delay to_duration(milliseconds(espera_dentro));

               -- Sale en tramo compartido
               put_line("Coche" & integer'image(id) & " fuera cruze");
            barrera.sale_Norte; -- Protocolo de salida
               delay to_duration(milliseconds(espera_fuera));

            delay 0.5;
         elsif lado = 'S' then

            barrera.entra_Sur; -- Protocolo de entrada
               -- Entra en tramo compartido
               put_line("Coche" & integer'image(id) & " en cruze");
               delay to_duration(milliseconds(espera_dentro));

               -- Sale en tramo compartido
               put_line("Coche" & integer'image(id) & " fuera de cruze");
            barrera.sale_Sur; -- Protocolo de salida
               delay to_duration(milliseconds(espera_fuera));

            delay 0.5;
         end if;
      end loop;
   end coche;

   C1 : coche(1, 10, 20, 'N');   -- Impares Norte, pares Sur
   C2 : coche(2, 15, 15, 'S');
   C3 : coche(3, 20, 30, 'N');
   C4 : coche(4, 35, 35, 'S');
   C5 : coche(5, 30, 45, 'N');
   C6 : coche(6, 40, 50, 'S');
   C7 : coche(7, 50, 15, 'N');
   C8 : coche(8, 25, 25, 'S');

begin
   --  Insert code here.
   null;
end Main;
