
package pila is
   
   type vector is array (integer range <>) of integer;
   N : constant := 6;
   
   type cola is record
      pila : vector(0..N-1);
      posicion : integer;
   end record;
   
   -- Procedure to start package parameters
   procedure inicializar(deposito : in out cola);
   procedure insertar(deposito : in out cola; data : in integer);
   procedure sacar(deposito : in out cola; data : out integer);
   function vacia(deposito : in cola) return boolean;
   function llena(deposito : in cola) return boolean;
   function menu return integer;
   procedure mostrar(deposito : in cola);
   
end pila;
