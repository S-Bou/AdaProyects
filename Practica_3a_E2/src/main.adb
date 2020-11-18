with Text_IO; use Text_IO;
with ada.Real_Time; use ada.Real_Time;
with barreras; use barreras;
procedure Main is

   task type coche(id:integer; lado:character);
      espera_dentro : integer := 40;
      espera_fuera  : integer := 10;

   task body coche is
   begin
      loop
         if lado = 'N' then
            -- Entra en tramo compartido
            barrera.entra_Norte; -- Protocolo de entrada
            put_line("Coche" & integer'image(id) & " en cruze");
            delay to_duration(milliseconds(espera_dentro));

            -- Sale en tramo compartido
            put_line("Coche" & integer'image(id) & " fuera cruze");
            delay to_duration(milliseconds(espera_fuera));
            barrera.sale_Norte; -- Protocolo de salida
            delay 0.5;
         elsif lado = 'S' then
            -- Entra en tramo compartido
            barrera.entra_Sur; -- Protocolo de entrada
            put_line("Coche" & integer'image(id) & " en cruze");
            delay to_duration(milliseconds(espera_dentro));

            -- Sale en tramo compartido
            put_line("Coche" & integer'image(id) & " fuera cruze");
            delay to_duration(milliseconds(espera_fuera));
            barrera.sale_Sur; -- Protocolo de salida
            delay 0.5;
         end if;
      end loop;
   end coche;

   C1 : coche(1, 'N');   -- Impares Norte, pares Sur
   C2 : coche(2, 'S');
   C3 : coche(3, 'N');
   C4 : coche(4, 'S');
   C5 : coche(5, 'N');
   C6 : coche(6, 'S');
   --C7 : coche(7, 'N');
   --C8 : coche(8, 'S');

begin
   --  Insert code here.
   null;
end Main;
