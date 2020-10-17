package body pila is

   procedure inicializar(deposito : in out pilas)is
   begin
      deposito.posicion := 0;
   end inicializar;
   
   procedure insertar(deposito : in out pilas; data : in integer)is
   begin
      deposito.pila(deposito.posicion) := data;
      deposito.posicion := deposito.posicion + 1;
   end insertar;
   
   procedure sacar(deposito : in out pilas; data : out integer) is
   begin
      data := deposito.pila(deposito.posicion - 1);
      deposito.posicion := deposito.posicion - 1;
   end sacar;
   
end pila;
