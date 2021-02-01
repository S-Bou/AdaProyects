with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
package body data is
---------------------------------------------------------------------------------------------------------------------------------
-- Ver si hay algun evento aperiodico activado en este tiempo
   procedure Estadotareas (time_loop: in integer;grupotareas,grupoaperiodicos: in out v_taskgroup) is
      orden:float:=0.0;
      tarea_AUX:tarea;
   begin
   -- Ordenar las tareas por índice por si hay varias con el mismo tiempo
      if Tarea_activa then
         for i in grupotareas'range loop
            for j in grupotareas'range loop
               if grupotareas(i).task_id < grupotareas(j).task_id then
                  tarea_AUX:=grupotareas(i);
                  grupotareas(i):=grupotareas(j);
                  grupotareas(j):=tarea_AUX;
               end if;
            end loop;
         end loop;
      end if;
   -- Si se activa una tarea se pone a true el estado
      for i in grupotareas'Range loop
         orden:=orden+0.1;
         if(time_loop mod grupotareas(i).period = 0) then
            grupotareas(i).time:=float(time_loop)+orden;
            grupotareas(i).state:=true;
         end if;
      end loop;
   -- si coincide el time_loop con el tiempo del evento aperiodico se pone a true el estado
      for i in grupoaperiodicos'Range loop
         if grupoaperiodicos(i).time=float(time_loop) then
            grupoaperiodicos(i).state:=true;
         end if;
      end loop;
   end Estadotareas;
---------------------------------------------------------------------------------------------------------------------------------
-- Ordenar las tareas por tiempo y su estado de activación
   procedure Setpriority (grupotareas,grupoaperiodicos: in out v_taskgroup;time: in integer)  is
      tarea_AUX:tarea;
   begin
   -- mirar el tiempo de activación para ordenar prioridades
      if Tarea_activa then
         for i in grupotareas'range loop
            for j in grupotareas'range loop
               if grupotareas(i).time < grupotareas(j).time then
                  tarea_AUX:=grupotareas(i);
                  grupotareas(i):=grupotareas(j);
                  grupotareas(j):=tarea_AUX;
               end if;
            end loop;
         end loop;
   -- Si hay alguna tarea activa se actualiza Task_ON y sale
         for i in grupotareas'range loop
            if grupotareas(i).state then
               Task_ON:=i;
               Tarea_activa:=false;
               Exit;
            end if;
   -- Si no hay tareas activas se actualiza Aperiodic_ON y Task_ON
            if i=grupotareas'Last then
               for i in grupoaperiodicos'range loop
                  if grupoaperiodicos(i).state then
                     Aperiodic_ON:=i;
                     Task_ON:=0;
                     Tarea_activa:=false;
                  end if;
               end loop;
            end if;
         end loop;
      end if;
   -- Si no hay tareas activas ni eventos aperiodicos se actualiza Task_ON
      if Tarea_activa then
         Task_ON:=-1;
         Aperiodic_ON:=0;
         Tarea_activa:=true;
      end if;
   end Setpriority;
---------------------------------------------------------------------------------------------------------------------------------
-- Decrementar el tiempo de computo o reiniciar
   procedure Refreshcomput (grupotareas,grupoaperiodicos: in out v_taskgroup;wcet: in v_enteros) is
   begin
      if Task_ON=0 then
         if grupoaperiodicos(Aperiodic_ON).wcet > 0 then
            grupoaperiodicos(Aperiodic_ON).wcet:=grupoaperiodicos(Aperiodic_ON).wcet - 1;
            Tarea_activa:=true;
         end if;
         if grupoaperiodicos(Aperiodic_ON).wcet <= 0 then
            grupoaperiodicos(Aperiodic_ON).state:=false;
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
---------------------------------------------------------------------------------------------------------------------------------
-- Opciones del menú en consola según la opción elegida
   function Setdata (Wcet, Deadline, Period: in out v_enteros) return boolean is
      menu, Num_Conjunto, data: integer:=0;
      SetData: boolean:=false;
   begin
      loop
         Put_Line("1. Seleccionar conjunto predefinido.");
         Put_line("2. Introducir tareas a mano.");
         Put("Opción seleccionada: ");
         Get(menu);
         if menu=1 then
            loop
               Put("Introduzca el numero del conjunto [1..5]: ");
               Get(Num_Conjunto);
               if Num_Conjunto<1 or Num_Conjunto>5 then Put("Valor no válido.");New_Line;end if;
               exit when Num_Conjunto>=1 and Num_Conjunto<=5;
            end loop;
            SetData:=conjuntos(Num_Conjunto,Wcet,Deadline,Period); --Establece los valores de las tareas
         elsif menu=2 then
            for i in 1..Num_tasks loop
               loop
                  Put("Introduzca el T. de Computo (C) de la tarea ");Put(i,1);Put(" [1..25]: ");
                  Get(data);
                  if data<=0 or data>25 then Put("Valor no válido.");New_Line;end if;
                  exit when data>0 and data<=25;
               end loop;
               Wcet(i):=data;
               loop
                  Put("Introduzca el Plazo (D) de la tarea ");Put(i,1);Put(" [1..25]: ");
                  Get(data);
                  if data<=0 or data>25 then Put("Valor no válido.");New_Line;end if;
                  exit when data>0 and data<=25;
               end loop;
               Deadline(i):=data;
               loop
                  Put("Introduzca el Periodo (T) de la tarea ");Put(i,1);Put(" [1..25]: ");
                  Get(data);
                  if data<Deadline(i) then null; end if;
                  if data<=0 or data>25 then Put("Valor no válido.");New_Line;end if;
                  exit when data>0 and data<=25;
               end loop;
               Period(i):=data;
            end loop;
         end if;
         if menu<1 or menu>2 then Put("Valor no válido.");New_Line;end if;
         exit when menu=1 or menu=2;
      end loop;
      Return SetData;
   end Setdata;
---------------------------------------------------------------------------------------------------------------------------------
-- Opciones del menú por consola para establecer los eventos aperiódicos
   function SetTimeEvents (N_aperiodicos:in integer) return v_taskgroup is
      data, dataTime: integer:=1;
      lastdata: integer:=0;
      aperiodicdata:v_taskgroup(1..N_aperiodicos);
   begin
      Num_aperiodicos:=N_aperiodicos;
      loop
         Put("Introduzca el tiempo de computo de los eventos [1..5]: ");
         Get(dataTime);
         if dataTime<1 or dataTime>5 then Put("Valor no válido.");New_Line;end if;
         exit when dataTime>=1 and dataTime<=5;
      end loop;
      for i in aperiodicdata'Range loop
         loop
            Put("Introduzca el tiempo del evento aperiódico ");Put(i,1);Put(" [");Put(lastdata,0);Put("..100]: ");
            Get(data);
            if data<1 or data>100 or data<lastdata then Put("El valor tiene que ser mayor que "); Put(lastdata,0); Put(" y menor que 101.");New_Line;end if;
            exit when data>=1 and data<=100 and data>=lastdata;
         end loop;
         lastdata:=data+1;
         if lastdata>100 then lastdata:=100; end if;
         aperiodicdata(i).task_id:=i;
         aperiodicdata(i).time:=float(data);
         aperiodicdata(i).state:=false;
         aperiodicdata(i).wcet:=dataTime;
         aperiodicdata(i).deadline:=0;
         aperiodicdata(i).period:=0;
      end loop;
      return aperiodicdata;
   end SetTimeEvents;
---------------------------------------------------------------------------------------------------------------------------------
-- Imprime por consola los datos del conjunto de tareas
   procedure Imprimir (Wcet, Deadline, Period: in v_enteros) is
   begin
      for i in Wcet'Range loop
         Put("Tarea(");Put(i,1);Put(")=[");Put(Wcet(i),3);Put(",");
         Put(Deadline(i),3);Put(",");Put(Period(i),3);Put("]");
         New_Line;
      end loop;
   end Imprimir;
---------------------------------------------------------------------------------------------------------------------------------
-- Imprime por consola los datos de los eventos aperiodicos
   procedure ImprimirAperiodicos (T_Compu:in integer; aperiodicdata: in v_taskgroup) is
   begin
      Put("Eventos aperiodicos: [id, time, wcet] = [");
      for i in aperiodicdata'Range loop
         Put("(");
         Put(aperiodicdata(i).task_id,2);Put(",");
         Put(aperiodicdata(i).time,2,2,0);Put(",");
         Put(aperiodicdata(i).wcet,2);Put(")");
      end loop;
      Put("]");
      New_Line;
   end ImprimirAperiodicos;
---------------------------------------------------------------------------------------------------------------------------------
-- Inicializa los valores de el vector con las tareas
   procedure Inittasks (taskgroup:in out v_taskgroup;wcet,deadline,period:in v_enteros) is
   begin
      Put("Prioridad inicial de tareas: [");
      for i in 1..Num_tasks loop
         taskgroup(i).task_id:=i;
         taskgroup(i).time:=0.0;
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
---------------------------------------------------------------------------------------------------------------------------------
-- Conjuntos predefinidos
   function conjuntos (conjunto: in integer;Wcet, Deadline, Period: in out v_enteros) return boolean is
      ErrorConjuntos: boolean:=false;
   begin
      if    conjunto=1 and Num_tasks=3 then
         Wcet:=    ( 2, 3, 4);
         Deadline:=( 8,10,15);
         Period:=  (10,12,20);
      elsif conjunto=3 and Num_tasks=4 then
         Wcet:=    ( 2, 3, 4, 5);
         Deadline:=( 8,10,15,18);
         Period:=  (10,12,20,22);
      elsif conjunto=2 and Num_tasks=5 then
         Wcet:=    ( 3, 4, 5, 6, 7);
         Deadline:=( 9,11,16,16,18);
         Period:=  (11,13,21,18,26);
      elsif conjunto=4 and Num_tasks=6 then
         Wcet:=    ( 2, 3, 4, 5, 3, 3);
         Deadline:=(16,15,17,18,17,24);
         Period:=  (22,18,20,21,19,25);
      elsif conjunto=5 and Num_tasks=6 then
         Wcet:=    ( 2, 3, 4, 5, 3, 3);
         Deadline:=(16,15,17,18,17,24);
         Period:=  (22,18,20,21,19,23); -- Periodo(6) < plazo(6) = error
      else
         Put_Line("El número de tareas no coincide con el conjunto.");
         Put_Line("Tareas no definidas.");
         ErrorConjuntos:=true;
      end if;
      Return ErrorConjuntos;
   end conjuntos;
---------------------------------------------------------------------------------------------------------------------------------
-- Comprobación de que los parámetros introducidos tienen valores lógicos y son realizables
   function CompruebaParametros (Wcet, Deadline, Period: in out v_enteros) return integer is
      test:integer:=0;
   begin
      for i in Wcet'Range loop
         if Wcet(i)>Deadline(i) or Wcet(i)>Period(i) or Period(i)<Deadline(i) then
            test:=1;
            return test;
         end if;
      end loop;

      for i in Wcet'Range loop
          for j in 2..Num_tasks loop
             if Wcet(i)+Wcet(j)>Deadline(j) then
                test:=2;
                return test;
            end if;
         end loop;
      end loop;
      return test;
   end CompruebaParametros;
---------------------------------------------------------------------------------------------------------------------------------
-- Muetra por consola el estado de las tareas según el loop principal (time)
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
         Put(taskgroup(i).task_id,1);Put(", ");
         Put(taskgroup(i).time,2,1,0);
         Put(") ");
      end loop;
      Put("] ");Put("Task_ON: ");Put(Task_ON,2);Put(" Aperiodic_ON: ");Put(Aperiodic_ON,2);
      New_Line;
   end ShowStateTasks;
---------------------------------------------------------------------------------------------------------------------------------
-- Devuelve la tarea activa
   function GetTaskON return integer is
   begin
      return Task_ON;
   end GetTaskON;
---------------------------------------------------------------------------------------------------------------------------------

end data;

