with Text_IO; use Text_IO;
with ada.Real_Time; use ada.Real_Time;
with barrera; use barrera;
procedure Main is

   task type coche(id:integer);
      espera_dentro : integer := 100;
      espera_fuera  : integer := 100;
   task body coche is
   begin
      loop
         -- Entra en tramo compartido
         barrera.entrar; -- Protocolo de entrada
         put_line("Coche " & integer'image(id) & " en cruze");
         delay to_duration(milliseconds(espera_dentro));

         -- Sale en tramo compartido
         barrera.salir; -- Protocolo de salida
         put_line("Coche " & integer'image(id) & " fuera cruze");
         delay to_duration(milliseconds(espera_fuera));
      end loop;
   end coche;

   cocheNorte : coche(1);
   cocheSur   : coche(2);

begin
   --  Insert code here.
   null;
end Main;
