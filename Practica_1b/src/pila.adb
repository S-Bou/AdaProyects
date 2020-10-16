package body pila is

   procedure Inicializar(P : in out pila; T : in nolose)is
   begin
      P.Entrada  := 0;
      P.Salida   :=-1;
      P.Contador := 0;
   end Inicializar;
   

end pila;
