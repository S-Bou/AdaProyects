with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
package body data is

   procedure Estadotareas (time: in integer;grupotareas: in out v_taskgroup) is
   begin
      for i in 1..Num_tasks loop
         if(TIME mod grupotareas(i).period = 0) then
            grupotareas(i).time:=time;
            grupotareas(i).state:=true;
         end if;
      end loop;
   end Estadotareas;

   procedure Setpriority (grupotareas: in out v_taskgroup)  is
      tarea_AUX:tarea;
   begin -- mirar el tiempo de activación para ordenar prioridades
      for i in grupotareas'range loop
         for j in grupotareas'range loop
            if grupotareas(i).time < grupotareas(j).time then
               tarea_AUX:=grupotareas(i);
               grupotareas(i):=grupotareas(j);
               grupotareas(j):=tarea_AUX;
            end if;
         end loop;
      end loop;
      Task_ON:=grupotareas(1).task_id;
   end Setpriority;

   procedure Refreshcomput (tareason,wcet,real_wcet: in out v_enteros) is
   begin
null;
   end Refreshcomput;

   procedure Setdata (Wcet, Deadline, Period: in out v_enteros) is
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
            for i in 1..Num_tasks loop
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

   procedure Inittasks (taskgroup:in out v_taskgroup;wcet,deadline,period:in v_enteros) is
   begin
      Put("Prioridad inicial de tareas: [");
      for i in 1..Num_tasks loop
         taskgroup(i).task_id:=i;
         taskgroup(i).time:=0;
         taskgroup(i).state:=false;
         taskgroup(i).wcet:=wcet(i);
         taskgroup(i).deadline:=deadline(i);
         taskgroup(i).period:=period(i);
         Put(taskgroup(i).task_id,1);
         if i<Num_tasks then
            Put(", ");
         end if;
      end loop;
      Put("]");New_Line;
   end Inittasks;


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

   procedure ShowStateTasks (time:in integer;taskgroup:in v_taskgroup) is
   begin
      Put("Time = ");Put(TIME,3);Put("; Task state = [");
      for i in taskgroup'Range loop
         if taskgroup(i).state then
            Put(" ON ");
         else
            Put(" OFF ");
         end if;
      end loop;
      Put("]");
      Put("; [id, time] = [ ");
      for i in taskgroup'Range loop
         Put("(");
         Put(taskgroup(i).task_id,3);Put(", ");
         Put(taskgroup(i).time,3);
         Put(") ");
      end loop;
      Put("]");
      New_Line;
   end ShowStateTasks;

   procedure SetNumTasks (N_tasks:in integer) is
   begin
      Num_tasks:=N_tasks;
   end SetNumTasks;

   function Getpriority return integer is
   begin
      return Task_ON;
   end Getpriority;

end data;
