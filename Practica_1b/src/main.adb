with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Text_IO; use Text_IO;
with pila; use pila;

procedure Main is

   monton : pilas;
   muestra : integer;
begin
   inicializar(monton);
   insertar(monton,10);
   insertar(monton,11);
   insertar(monton,12);
   sacar(monton, muestra);
   Put("Muestra extraida: ");Put(muestra, 2);
   New_line;
   sacar(monton, muestra);
   Put("Muestra extraida: ");Put(muestra, 2);
   New_line;

end Main;
