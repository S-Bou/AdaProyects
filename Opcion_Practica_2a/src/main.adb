with pila_simple; use pila_simple;
with Text_IO; use text_io;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

procedure Main is
   orden,x: integer;
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
