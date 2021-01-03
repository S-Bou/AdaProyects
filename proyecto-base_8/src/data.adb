with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
package body data is

   procedure Estadotareas (time: in integer;grupotareas,grupoaperiodicos: in out v_taskgroup) is
   begin
      for i in grupotareas'Range loop
         if(time mod grupotareas(i).period = 0) then
            grupotareas(i).time:=time;
            grupotareas(i).state:=true;
         end if;
      end loop;
      for i in grupoaperiodicos'Range loop
         if grupoaperiodicos(i).time=time then
            grupoaperiodicos(i).state:=true;
         end if;
      end loop;
   end Estadotareas;

   procedure Setpriority (grupotareas,grupoaperiodicos: in out v_taskgroup;time: in integer)  is
   begin -- mirar el tiempo de activación para ordenar prioridades
      if Tarea_activa then
         for i in grupotareas'range loop
            if grupotareas(i).state then
               Task_ON:=i;
               Tarea_activa:=false;
               exit;
            elsif grupoaperiodicos(i).state then
               Aperiodic_ON:=i;
               Task_ON:=0;
               Tarea_activa:=false;
            end if;
         end loop;
      end if;
      if Tarea_activa then
         Task_ON:=-1;
         Tarea_activa:=true;
      end if;

   end Setpriority;

   procedure Refreshcomput (grupotareas,grupoaperiodicos: in out v_taskgroup;wcet: in v_enteros) is
   begin
      if Task_ON=0 then
         if grupoaperiodicos(Aperiodic_ON).wcet > 0 then
            grupoaperiodicos(Aperiodic_ON).wcet:=grupoaperiodicos(Aperiodic_ON).wcet - 1;
         end if;
         if grupoaperiodicos(Aperiodic_ON).wcet <= 0 then
            grupoaperiodicos(Aperiodic_ON).state:=false;
            Tarea_activa:=true;
         end if;
      elsif Task_ON>0 then
         if grupotareas(Task_ON).wcet > 0 then
            grupotareas(Task_ON).wcet:=grupotareas(Task_ON).wcet - 1;
         end if;
         if grupotareas(Task_ON).wcet <= 0 then
            grupotareas(Task_ON).state:=false;
            grupotareas(Task_ON).wcet:=wcet(grupotareas(Task_ON).task_id);
            Tarea_activa:=true;
         end if;
      end if;
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

   function SetTimeEvents (N_aperiodicos:in integer) return v_taskgroup is
      data,lastdata,dataTime: integer:=0;
      aperiodicdata:v_taskgroup(1..N_aperiodicos);
   begin
      Num_aperiodicos:=N_aperiodicos;
      loop
         Put("Introduzca el tiempo de computo de los eventos [1..5]: ");
         Get(dataTime);
         exit when dataTime>=1 and dataTime<=5;
      end loop;
      for i in aperiodicdata'Range loop
         loop
            Put("Introduzca el tiempo del evento aperiódico ");Put(i,1);Put(" [0..100]: ");
            Get(data);
            exit when data>0 and data<100 and data>lastdata;
         end loop;
         lastdata:=data;
         aperiodicdata(i).task_id:=i;
         aperiodicdata(i).time:=data;
         aperiodicdata(i).state:=false;
         aperiodicdata(i).wcet:=dataTime;
         aperiodicdata(i).deadline:=0;
         aperiodicdata(i).period:=0;
      end loop;
      return aperiodicdata;
   end SetTimeEvents;

   procedure Imprimir (Wcet, Deadline, Period: in v_enteros) is
   begin
      for i in Wcet'Range loop
         Put("Tarea(");Put(i,1);Put(")=[");Put(Wcet(i),3);Put(",");
         Put(Deadline(i),3);Put(",");Put(Period(i),3);Put("]");
         New_Line;
      end loop;
   end Imprimir;

   procedure ImprimirAperiodicos (T_Compu:in integer; aperiodicdata: in v_taskgroup) is
   begin
      Put("Eventos aperiodicos: [id, time, wcet] = [");
      for i in aperiodicdata'Range loop
         Put("(");
         Put(aperiodicdata(i).task_id,2);Put(",");
         Put(aperiodicdata(i).time,2);Put(",");
         Put(aperiodicdata(i).wcet,2);Put(")");
      end loop;
      Put("]");
      New_Line;
   end ImprimirAperiodicos;

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
      Put("Time = ");Put(time,3);Put("; Task state = [");
      for i in taskgroup'Range loop
         if taskgroup(i).state then
            Put(" ON ");
         else
            Put("OFF ");
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
      Put("] ");Put(Task_ON,3);
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
