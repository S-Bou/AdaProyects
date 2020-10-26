with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with Text_IO; use Text_IO;
with pilagenerica;

procedure Main is
   -- Size of pila
   N : constant := 5;

   procedure imprime_int (data : integer) is
   begin
      ada.Integer_Text_IO.put(data, 20);
   end imprime_int;

   --Pilagenerica package instantiation for integers
   package pila_int is new pilagenerica(N, integer, imprime_int);
   use pila_int;

   procedure imprime_float (data : float) is
   begin
      ada.Float_Text_IO.put(data, 20, 2, 0);
   end imprime_float;

   --Pilagenerica package instantiation for floats
   package pila_flo is new pilagenerica(N, float, imprime_float);
   use pila_flo;

   montonint : pila_int.cola;
   montonfloat : pila_flo.cola;
   muestraint, option : integer;
   muestraflo : float;

begin

   inicializar(montonint);
   inicializar(montonfloat);

   Put_line("Escoja una opción:");Put_line("1. Enteros");Put_line("2. Decimales");
   Put("Opcion elejida: ");
   Get(option);
   if option = 1 then
      option := pila_int.menu;
      loop
         case option is
         when 1 => Put("Introduzca un número: ");Get(muestraint);
            pila_int.insertar(montonint, muestraint);
            option := pila_int.menu;
         when 2 => if vacia(montonint) then
               pila_int.sacar(montonint, muestraint);
               option := pila_int.menu;
            else
               pila_int.sacar(montonint, muestraint);
               Put_line("Muestra extraida: "& integer'image(muestraint));
               option := pila_int.menu;
            end if;
         when 3 => mostrar(montonint);
            New_line;
            option := pila_int.menu;
         when 0 => Put_line("Programa finalizado.");exit;
            when others => Put_line("Opción no valida, escoja otra.");
            option := pila_int.menu;
         end case;
      end loop;
   else
      option := pila_flo.menu;
      loop
         case option is
         when 1 => Put("Introduzca un número: ");Get(muestraflo);
            pila_flo.insertar(montonfloat, muestraflo);
            option := pila_flo.menu;
         when 2 => if vacia(montonfloat) then
               pila_flo.sacar(montonfloat, muestraflo);
               option := pila_flo.menu;
            else
               pila_flo.sacar(montonfloat, muestraflo);
               Put_line("Muestra extraida: "& float'image(muestraflo));
               option := pila_flo.menu;
            end if;
         when 3 => mostrar(montonfloat);
            New_line;
            option := pila_flo.menu;
         when 0 => Put_line("Programa finalizado.");exit;
            when others => Put_line("Opción no valida, escoja otra.");
            option := pila_flo.menu;
         end case;
      end loop;
   end if;
end Main;

