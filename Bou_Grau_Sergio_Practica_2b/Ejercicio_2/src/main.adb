with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.Calendar; use ada.Calendar;
with Text_IO; use text_io;
with pila_simple;

procedure Main is
   dimen : constant := 2000;

   procedure imprime_time(data : float) is
   begin
      ada.Float_Text_IO.put(data, 1, 6, 0);
   end imprime_time;

   package pila_delay is new pila_simple(dimen, float, imprime_time);
   use pila_delay;

   x, sumTime: float;

   p_delay: pila_delay.pila;

   T1, T2: ada.calendar.time;
   interval: Duration;

   begin

      inicializar(p_delay);
      sumTime:=0.0;
      for i in 1..dimen loop
         T1 := clock;
         Delay(0.01);
         T2 := clock;
         interval := T2-T1;
         anyadir(p_delay, float(interval));
      end loop;
      listar(p_delay);
      for i in 1..dimen loop
         sacar(p_delay, x);
         sumTime := sumTime + x;
      end loop;
      put("Media de tiempos: ");
      put(sumTime/float(dimen), 1, 6, 0);

end Main;
