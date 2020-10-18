generic

   type nolose is private;
   with procedure imprime(data : nolose);
   
package pilagenerica is

   N : constant := 4;
   type cola is limited private;
   type vector is array (integer range <>) of nolose;

   -- Procedure to start package parameters
   procedure inicializar(deposito : in out cola);
   procedure insertar(deposito : in out cola; data : in nolose);
   procedure sacar(deposito : in out cola; data : out nolose);
   function vacia(deposito : in cola) return boolean;
   function llena(deposito : in cola) return boolean;
   function menu return integer;
   procedure mostrar(deposito : in cola);
   
   private
   type cola is record
      pila : vector(0..N-1);
      posicion : integer;
   end record;
   
end pilagenerica;
