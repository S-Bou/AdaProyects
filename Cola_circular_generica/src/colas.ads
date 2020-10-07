generic
   type nolose is private;
   with procedure Imprime(x: nolose);

package Colas is

  type Cola_Circular is limited private;

  -- operaciones

  function Vacia(C : in Cola_Circular) return Boolean;
  function Llena(C : in Cola_Circular) return Boolean;

  procedure Inicializar (C : in out Cola_Circular);

  procedure Anyadir( C : in out Cola_Circular; I: in nolose);
  procedure Sacar (C : in out Cola_Circular; I: out nolose);

  procedure Listar(C : in Cola_Circular);

  Cola_Llena, Cola_Vacia: exception;

private
  -- estructura
  N: constant integer := 5;
  subtype Index is Integer range 0..N-1;
  type Cola is array (Index) of nolose;
  type Cola_Circular is
  record
    Vector: Cola;
    Entrada: Integer := 0;
    Salida: Integer := -1;
    Contador: Integer :=0;
  end  record;

end Colas;
