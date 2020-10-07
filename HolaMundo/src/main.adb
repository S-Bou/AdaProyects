with Text_IO; use Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

procedure Main is
x : Integer;
begin
   --  Insert code here.
   Put("Hola mundo.");
   New_Line;
   loop
      Put_Line("Dime un entero, si es 0 cierra el programa.");
      GEt(x);
      exit when x=0;
      if x mod 2 = 0 then
         Put_Line("El entero es par.");
      else
         Put_Line("El entero es impar");
      end if;
   end loop;
end Main;
