with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
package body data is

   function Estadotareas (TIME: in integer;tareason,Period,R_wcet: in out v_enteros) return v_enteros is
   begin
      for i in 1..Num_tasks loop
         if(TIME mod Period(i) = 0) then
            tareason(i):=1;
         end if;
         if(R_wcet(i)=0) then
            tareason(i):=0;
         end if;
      end loop;
      return tareason;
   end Estadotareas;

   function Setpriority (tareason: in v_enteros) return integer is
      priority:integer:=0;
   begin
      for i in tareason'Range loop
         if(tareason(i)=1) then
            priority:=i;
            exit;
         end if;
      end loop;
      if priority=0 and aperiodic=false then
         priority:=-1;
      end if;
      return priority;
   end Setpriority;

   function Refreshcomput (tarea_on:in integer; Wcet,real_wcet: in out v_enteros) return v_enteros is
   begin
      if(tarea_on<=0) then
         real_wcet:=Wcet;
         return real_wcet;
      else
         real_wcet(tarea_on):=real_wcet(tarea_on)-1;
         return real_wcet;
      end if;
   end Refreshcomput;

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
            conjuntos(Num_Conjunto,Wcet,Deadline,Period); --Establece los valores de las tareas
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

   procedure conjuntos (conjunto: in integer;Wcet, Deadline, Period: in out v_enteros) is
   begin
      if conjunto=1 and Num_tasks=3 then
         Wcet:=(2,3,4);
         Deadline:=(8,10,15);
         Period:=(10,12,20);
      elsif conjunto=2 and Num_tasks=4 then
         Wcet:=(2,3,4,5);
         Deadline:=(8,10,15,18);
         Period:=(10,12,20,22);
      else
         Put_Line("El número de tareas no coincide con el conjunto.");
         Put_Line("Tareas no definidas.");
      end if;
   end conjuntos;

   procedure Showstatetasks (TIME,taskon:in integer; tareason:in v_enteros) is
   begin
      Put("Time = ");Put(TIME,3);Put("; Task state = ");
      for i in tareason'Range loop
         Put(tareason(i),1);
      end loop;
      Put("; Task on: ");Put(taskon,1);
      New_Line;
   end Showstatetasks;

   procedure SetNumTasks (N_tasks:in integer) is
   begin
      Num_tasks:=N_tasks;
   end SetNumTasks;

end data;
