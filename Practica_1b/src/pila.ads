generic

package pila is

   N : constant := 4;
   type Vector is array (integer range <>) of nolose;
   Pila : Vector(0..N-1);
   Entrada, Salida, Contador : Integer;
   
   -- Procedure to start package parameters
   procedure Inicializar(P : in out pila; T : in nolose);
   
end pila;
