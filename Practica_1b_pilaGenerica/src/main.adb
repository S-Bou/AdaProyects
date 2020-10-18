with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with Text_IO; use Text_IO;
with pilagenerica;

procedure Main is

   procedure imprime_int (data : integer) is
   begin
      ada.Integer_Text_IO.put(data, 20);
   end imprime_int;

   --Instanciación del paquete pilagenerica para enteros
   package pila_int is new pilagenerica(integer, imprime_int);
   use pila_int;

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

