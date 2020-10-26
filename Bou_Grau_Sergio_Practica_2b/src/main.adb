with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with Text_IO; use text_io;
with pila_simple;

procedure Main is
   procedure imprime_floats(data : float) is
   begin
      ada.Float_Text_IO.put(data);
   end imprime_floats;

   package pila_float is new pila_simple(5, float, imprime_floats);
   use pila_float;

   procedure imprime_int(data : integer) is
   begin
      ada.Integer_Text_IO.put(data);
   end imprime_int;

   package pila_int is new pila_simple(5, integer, imprime_int);
   use pila_int;

   option, orden, y : integer;
   x : float;
   p_flo: pila_float.pila;
   p_int: pila_int.pila;
   pila_llena: exception;
   pila_vacia: exception;

   begin

   Put_line("Escoja una opción:");Put_line("1. Decimales");Put_line("2. Enteros");
   Put("Opcion elejida: ");Get(option);

   loop
begin
      put_line("0 salir, 1 inicializar, 2 anyadir, 3 sacar, 4 listar");
      get(orden);
      case orden is
         when 1 => if option = 1 then                  --Inicializar
                      inicializar(p_flo);
                   else
                      inicializar(p_int);
                   end if;
         when 2 => if option = 1 then                     --Anyadir
                      if llena(p_flo) then raise pila_llena with "La pila está llena.";
                      else
                         Put_line("Dime el elemento");
                         get(x);
                         anyadir(p_flo,x);
                      end if;
                   else
                      if llena(p_int) then raise pila_llena;
                      else
                         Put_line("Dime el elemento");
                         get(y);
                         anyadir(p_int, y);
                      end if;
                   end if;
         when 3 => if option = 1 then                       --Sacar
                      if vacia(p_flo) then raise pila_vacia;
                      else
                         sacar(p_flo,x);
                         Put("El elemento sacado es: "); Put(x); New_line;
                      end if;
                   else
                      if vacia(p_int) then raise pila_vacia;

                      else
                        sacar(p_int,y);
                        Put("El elemento sacado es: "); Put(x); New_line;
                      end if;
                   end if;
         when 4 => if option = 1 then                        --Listar
                      listar(p_flo);
                   else
                      listar(p_int);
                   end if;
         when 0 => exit;                                       --Exit
            when others => null;
         end case;
         exception
   when pila_llena => put_line("La pila esta llena, no se puede añadir.");
   when pila_vacia => put_line("La pila esta vacia");
         end;
   end loop;
end Main;
