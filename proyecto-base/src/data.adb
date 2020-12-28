with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
package body data is

   procedure Setdata (N_tasks: in out integer; Wcet, Deadline, Period: in out v_enteros) is
      menu, Num_Conjunto, data: integer:=0;
   begin
      loop
         Put_Line("1. Seleccionar conjunto predefinido.");
         Put_line("2. Introducir tareas a mano.");
         Put("Opción seleccionada: ");
         Get(menu);
         if menu=1 then
            loop
               Put("Introduzca el numero del conjunto [1..7]: ");
               Get(Num_Conjunto);
               exit when Num_Conjunto>=1 and Num_Conjunto<=7;
            end loop;
            conjuntos(Num_Conjunto,N_tasks,Wcet,Deadline,Period); --Establece los valores de las tareas
         elsif menu=2 then
            for i in 1..N_tasks loop
               Put("Introduzca el T. de Computo (C) de la tarea ");Put(i,1);Put(": ");
               Get(data);
               Wcet(i):=data;
               Put("Introduzca el Plazo (D) de la tarea ");Put(i,1);Put(": ");
               Get(data);
               Deadline(i):=data;
               Put("Introduzca el Periodo (T) de la tarea ");Put(i,1);Put(": ");
               Get(data);
               Period(i):=data;
            end loop;
         end if;
         exit when menu=1 or menu=2;
      end loop;
   end Setdata;

   function SetTimeEvents (Eventstime:in out v_enteros) return integer is
      data, dataTime: integer:=0;
   begin
      loop
         Put("Introduzca el tiempo de computo de los eventos [1..5]: ");
         Get(dataTime);
         exit when dataTime>=1 and dataTime<=5;
      end loop;
      for i in Eventstime'Range loop
         loop
            Put("Introduzca el tiempo del evento aperiódico ");Put(i,1);Put(" [0..100]: ");
            Get(data);
         exit when data>0 and data<100;
         end loop;
         Eventstime(i):=data;
      end loop;
      return dataTime;
   end SetTimeEvents;

   procedure Imprimir (Wcet, Deadline, Period: in v_enteros) is
   begin
      for i in Wcet'Range loop
         Put("Tarea(");Put(i,1);Put(")=[");Put(Wcet(i),3);Put(",");
         Put(Deadline(i),3);Put(",");Put(Period(i),3);Put("]");
         New_Line;
      end loop;
   end Imprimir;

   procedure ImprimirET (T_Compu:in integer; Eventstime: in v_enteros) is
   begin
      Put("Tiempo de computo de cada evento aperiódico = ");Put(T_Compu,1);
      New_Line;
      for i in Eventstime'Range loop
         Put("Tiempo del evento ");Put(i,1);Put(" = ");Put(Eventstime(i),2);
         New_Line;
      end loop;
   end ImprimirET;

   procedure conjuntos (conjunto, Num_T: in integer; Wcet, Deadline, Period: in out v_enteros) is
   begin
      if conjunto=1 and Num_T=3 then
         Wcet:=(2,3,4);
         Deadline:=(8,10,15);
         Period:=(10,12,20);
      else
         Put_Line("El número de tareas no coincide con el conjunto.");
         Put_Line("Tareas no definidas.");
      end if;
   end conjuntos;

end data;
