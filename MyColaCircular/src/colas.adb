with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with Text_IO; use Text_IO;

package body Colas is
   --operaciones
   function Vacia (C : in Cola_Circular) return boolean is 
   begin 
      return C.Contador = 0;
   end Vacia;

   function Llena (C : in Cola_Circular) return boolean is
   begin
      return C.Contador = N;
   end Llena;
   
   procedure Inicializar (C : in out Cola_Circular) is
   begin
      C.Entrada := 0;
      C.Salida := -1;
      C.Contador := 0;
   end Inicializar;
   
   procedure Anyadir (C : in out Cola_Circular; I : in nolose) is
   begin
      if Llena(C) then raise Cola_Llena;
      else C.Vector(C.Entrada) := I;
         C.Entrada := (C.Entrada+1) mod N;
         C.Contador := C.Contador +1;
         if C.Salida = -1 then C.Salida := 0; end if;
         end if;
      end Anyadir;
      
      procedure Sacar (C : in out Cola_Circular; I : out nolose) is 
      begin
         if Vacia(C) then raise Cola_Vacia;
      else
         I := C.Vector(C.Salida);
         C.Salida := (C.Salida+1) mod N;
         C.Contador := C. Contador - 1;
      end if;
   end Sacar;
   
   procedure Listar (C: in Cola_Circular) is
      K : integer;
   begin
      Put("Numero de elementos en la cola: ");
      Put(C.Contador);
      New_line;
      if not Vacia(C) then 
         Put("Elementos en la cola: ");
         K := C.Salida;
         loop
            --Put(C.Vector(K));
            Imprime(C.Vector(K));
            Put(" - ");
            K := (K + 1) mod N;
            exit when K = C.Entrada;
         end loop;
         New_line;
      end if;
   end Listar;
   
end colas;
