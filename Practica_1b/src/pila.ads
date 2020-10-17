
package pila is

   N : constant := 4;
   
   type vector is array (integer range <>) of integer;
   type pilas is limited private;
   
   -- Procedure to start package parameters
   procedure inicializar(deposito : in out pilas);
   procedure insertar(deposito : in out pilas; data : in integer);
   procedure sacar(deposito : in out pilas; data : out integer);
   
   private
   type pilas is record
      pila : vector(0..N-1);
      posicion : integer;
   end record;
   
end pila;
