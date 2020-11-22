with ada.Real_Time; use ada.Real_Time;
with Text_IO; use Text_IO;

procedure Main is

   task barrera is
      entry entra_Norte;
      entry sale_Norte;
      entry entra_Sur;
      entry sale_Sur;
   end barrera;

   task body barrera is
      MAX : constant := 3;
      contador_Norte, contador_Sur : integer := 0;
   begin
      loop
         select
            when contador_Norte < MAX and contador_Sur = 0 =>
               accept entra_Norte do
                  contador_Norte := contador_Norte + 1;
               end entra_Norte;
         or
            accept sale_Norte do
               contador_Norte := contador_Norte - 1;
            end sale_Norte;
         or
            when contador_Sur < MAX and contador_Norte = 0 =>
               accept entra_Sur do
                  contador_Sur := contador_Sur + 1;
               end entra_Sur;
         or
            accept sale_Sur do
               contador_Sur := contador_Sur - 1;
            end sale_Sur;
         --or terminate;
         or delay 0.01;
         --else put_line("Nada");
         end select;
      end loop;
   end barrera;

   -- Cliente
   task type coche(id:integer; e_in:integer; e_out:integer; lado:character) is
   end coche;

   task body coche is
      espera_dentro : integer;
      espera_fuera  : integer;
   begin
      espera_dentro := e_in;
      espera_fuera  := e_out;
      loop
         if lado = 'N' then
            barrera.entra_Norte;
               -- Entra en tramo compartido
               put_line("Coche" & integer'image(id) & " en cruze");
               delay to_duration(milliseconds(espera_dentro));

               -- Sale en tramo compartido
               put_line("Coche" & integer'image(id) & " fuera cruze");
            barrera.sale_Norte;
               delay to_duration(milliseconds(espera_fuera));

            --delay 0.5;
         elsif lado = 'S' then
            barrera.entra_Sur;
               -- Entra en tramo compartido
               put_line("Coche" & integer'image(id) & " en cruze");
               delay to_duration(milliseconds(espera_dentro));

               -- Sale en tramo compartido
               put_line("Coche" & integer'image(id) & " fuera de cruze");
            barrera.sale_Sur;
               delay to_duration(milliseconds(espera_fuera));

            --delay 0.5;
         end if;
      end loop;
   end coche;

   C1 : coche(1, 10, 55, 'N');   -- Impares Norte, pares Sur
   C2 : coche(2, 15, 15, 'S');
   C3 : coche(3, 20, 30, 'N');
   C4 : coche(4, 35, 35, 'S');
   C5 : coche(5, 30, 45, 'N');
   C6 : coche(6, 40, 50, 'S');
   C7 : coche(7, 50, 15, 'N');
   C8 : coche(8, 25, 25, 'S');

begin
   null;
end Main;
