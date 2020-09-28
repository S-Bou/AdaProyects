with Text_IO; use Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

procedure Main is
   -- cabecera
   function es_primo(numero:integer) return boolean;
   -- definición
   function es_primo(numero:integer) return boolean is
      p : boolean;
   begin
      p := true;

      for i in 2..numero-1 loop

         if numero mod i = 0 then --numero es divible entre "i"
            p := false;
         end if;
      end loop;

      return p;
   end es_primo;

   x : integer;
   primo : boolean;

   procedure es_primo2(numero:in integer; p: out boolean) is
   begin
      p := true;

      for i in 2..numero-1 loop

         if numero mod i = 0 then --numero es divible entre "i"
            p := false;
         end if;
      end loop;
   end es_primo2;

begin

   put("Dame un entero:");
   get(x);

   primo := es_primo(x);
   es_primo2(x, primo);

   if primo = true then
      put("El numero es primo");
   else
      put("El numero no es primo.");
   end if;


end Main;
