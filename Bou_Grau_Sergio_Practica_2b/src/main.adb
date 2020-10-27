with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Calendar; use ada.Calendar;
with Text_IO; use text_io;
with pila_simple;

procedure Main is
   dimen : constant := 2000;

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

   procedure imprime_time(data : float) is
   begin
      ada.Float_Text_IO.put(data, 1, 6, 0);
   end imprime_time;

   package pila_delay is new pila_simple(dimen, float, imprime_time);
   use pila_delay;

   option, orden, y : integer;
   x, sumTime: float;
   p_flo: pila_float.pila;
   p_int: pila_int.pila;
   p_delay: pila_delay.pila;
   pila_llena: exception;
   pila_vacia: exception;
   T1, T2: ada.calendar.time;
   interval: Duration;

   begin

   Put_line("Escoja una opción:");Put_line("1. Decimales");Put_line("2. Enteros");
   Put_line("3. Ejercicio 2");Put("Opcion elejida: ");Get(option);
   if option = 3 then
      inicializar(p_delay);
      sumTime:=0.0;
      for i in 1..dimen loop
         T1 := clock;
         Delay(0.01);
         T2 := clock;
         interval := T2-T1;
         anyadir(p_delay, float(interval));
      end loop;
      listar(p_delay);
      for i in 1..dimen loop
         sacar(p_delay, x);
         sumTime := sumTime + x;
      end loop;
      put("Media de tiempos: ");
      put(sumTime/float(dimen), 1, 6, 0);

   else
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
                      if llena(p_flo) then raise pila_llena; --0with "La pila está llena.";
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
   end if;
end Main;
