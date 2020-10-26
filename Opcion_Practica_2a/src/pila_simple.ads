generic
   max : integer;
   type comodin is private;
   with procedure imprime(data : comodin);

package pila_simple is

   type pila is limited private;
   type vector is array (1..max) of integer;


   procedure anyadir(p: in out pila; i: comodin);
   procedure sacar(p: in out pila; i: out comodin);
   procedure inicializar(p: in out pila);

   function vacia(p: pila) return boolean;
   function llena(p: pila) return boolean;
   procedure listar(p: pila);

private
   type pila is record
      v: vector;
      cima: integer;
   end record;

end pila_simple;
