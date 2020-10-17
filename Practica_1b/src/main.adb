with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Text_IO; use Text_IO;
with pila; use pila;

procedure Main is

   monton : cola;
   muestra : integer;
begin
   inicializar(monton);
   insertar(monton,11);
   insertar(monton,22);
   insertar(monton,33);
   insertar(monton,44);
   insertar(monton,55); --Cuando intenta poner este no puede porque está lleno
   sacar(monton, muestra); --Saca el 44
   Put("Muestra extraida: ");Put(muestra, 2);
   New_line;
   sacar(monton, muestra); --Saca el 33
   Put("Muestra extraida: ");Put(muestra, 2);
   New_line;
   sacar(monton, muestra); --Saca el 22
   Put("Muestra extraida: ");Put(muestra, 2);
   New_line;
   sacar(monton, muestra); --Saca el 11
   Put("Muestra extraida: ");Put(muestra, 2);
   New_line;
   sacar(monton, muestra); --Cando intenta sacar otro no puede porque está vacío
   Put("Muestra extraida: ");Put(muestra, 2); --Muestra la posición 0 := 0
   New_line;

end Main;
