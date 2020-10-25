with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Text_IO; use Text_IO;

package body pilagenerica is

   procedure inicializar(deposito : in out cola)is
   begin
      deposito.posicion := 0;
   end inicializar;
   
   procedure insertar(deposito : in out cola; data : in nolose)is
   begin
      if llena(deposito) then
         Put_line("Pila llena, elija otra opción");
      else
         deposito.pila(deposito.posicion) := data;
         deposito.posicion := deposito.posicion + 1;
         Put_line("Numero guardado.");
      end if;
   end insertar;
   
   procedure sacar(deposito : in out cola; data : out nolose) is
   begin
      if vacia(deposito) then
         Put_line("Pila vacia.");
         data := deposito.pila(deposito.posicion);
      else
         data := deposito.pila(deposito.posicion - 1);
         deposito.posicion := deposito.posicion - 1;
      end if;   
   end sacar;
   
   function vacia(deposito : in cola) return boolean is
   begin
      return deposito.posicion = 0;
   end vacia;
   
   function llena(deposito : in cola) return boolean is
   begin
      return deposito.posicion = max;
   end llena;
   
   function menu return integer is 
      data : integer;
   begin
      Put_line("Elija una opción:");Put_line("1. Introducir");Put_line("2. Sacar");
      Put_line("3. Mostrar pila");Put_line("0. Salir");Put("Opción elegida: "); 
      Get(data);
      return data;
   end menu;
   
   procedure mostrar(deposito : in cola) is
   begin
      Put("Pila: ");New_line;
      for i in reverse 0..deposito.posicion-1 loop
         imprime(deposito.pila(i));
         New_line;
      end loop;
   end mostrar;
   
end pilagenerica;
