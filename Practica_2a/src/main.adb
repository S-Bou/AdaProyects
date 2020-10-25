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

   orden : integer;
   x : float;
   p: pila;

begin

   loop

      put_line("0 salir, 1 inicializar, 2 anyadir, 3 sacar, 4 listar");
      get(orden);
      case orden is
         when 1 => inicializar(p);
         when 2 =>
            if llena(p) then put_line("La pila esta llena");
            else
               Put_line("Dime el elemento");
               get(x);
               anyadir(p,x);
            end if;
         when 3 =>
            if vacia(p) then put_line("La pila esta vacia");
            else
               sacar(p,x);
               Put("El elemento sacado es: "); Put(x); New_line;
            end if;
            when 4 => listar(p);
         when 0 => exit;
            when others => null;
      end case;
   end loop;
end Main;
