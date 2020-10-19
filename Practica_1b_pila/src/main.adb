with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Text_IO; use Text_IO;
with pila; use pila;

procedure Main is

   monton : cola;
   muestra, option : integer;
begin
   inicializar(monton);
   option := menu;

   loop
      case option is
         when 1 => Put("Introduzca un número: ");Get(muestra);
            insertar(monton, muestra);
            option := menu;
         when 2 => if vacia(monton) then
               sacar(monton, muestra);
               option := menu;
            else
               sacar(monton, muestra);
               Put_line("Muestra extraida: "& integer'image(muestra));
               option := menu;
            end if;
         when 3 => mostrar(monton);
            New_line;
            option := menu;
         when 0 => Put_line("Programa finalizado.");exit;
            when others => Put_line("Opción no valida, escoja otra.");
            option := menu;
      end case;
   end loop;

end Main;
