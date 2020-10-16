Generic
   type nolose is private;
   with procedure Imprime(x: nolose);

package colas is

   type Cola_Circular is limited private;
   --Operaciones
   function Vacia(C : in Cola_Circular) return boolean;
   function Llena(C : in Cola_Circular) return boolean;
   
   procedure Inicializar (C : in out Cola_Circular);
   procedure Anyadir(C : in out Cola_Circular; I : in nolose);
   procedure Sacar(C : in out Cola_Circular; I : out  nolose);
   procedure Listar(C : in Cola_Circular);
   
   Cola_Llena, Cola_Vacia : exception;
   
private
   --estructura
   N : constant integer := 5;
   subtype Index is integer range 0..N-1;
   type Cola is array (Index) of nolose;
   type Cola_Circular is 
      record
         Vector : Cola;
         Entrada : integer := 0;
         Salida : integer := -1;
         Contador : integer := 0;
      end record;

end colas;
