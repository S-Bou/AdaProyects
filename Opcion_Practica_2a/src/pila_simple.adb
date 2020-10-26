with Text_IO; use text_io;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

package body pila_simple is


   procedure anyadir(p: in out pila; i: comodin)is
   begin
      p.cima:=p.cima+1;
      p.v(p.cima):=i;
   end anyadir;


   procedure sacar(p: in out pila; i: out comodin) is
   begin
      i:=p.v(p.cima);
      p.cima:=p.cima-1;
   end sacar;

   procedure inicializar(p: in out pila) is
   begin
      p.cima:=0;
   end inicializar;

   function vacia(p: pila) return boolean is
   begin
      return p.cima=0;
   end vacia;
   function llena(p: pila) return boolean is
   begin
      return p.cima=max;
   end llena;

   procedure listar(p: pila) is
   begin
      Put_line("Elementos en la pila");
      for i in p.v'range loop
         if i<=p.cima then
            Put(p.v(i)); Put(";");
         end if;
      end loop;
      New_line;
   end listar;

end pila_simple;
