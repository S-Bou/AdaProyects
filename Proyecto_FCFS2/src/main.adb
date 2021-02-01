-- Trabajo 2: Planificador FCFS y eventos con la menor prioridad; por Sergio Bou Grau.
-- Prioridad de tareas por índice más bajo.
with schedule_output_functions; use schedule_output_functions;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with text_io; use text_io;
with data; use data;
---------------------------------------------------------------------------------------------------------------------------------
procedure Main is
   -- Definición de excepciones
   ErrorData, NoPlani:exception;
   -- numero de instantes del cronograma
   exec:integer:=0; -- poner a 0 cuando se empiece el trabajo   
   -- Datos de eventos aperiódicos:
   -- numero de eventos aperiodicos
   num_aperiodic: integer:=0;
   -- unidades de computo del evento aperiodico
   wcet_aperiodic: integer:=0;
   
begin
   loop
      Put("Introduzca el número de tareas del conjunto [1..9]: ");
      Get(num_tasks);
      if num_tasks<=0 or num_tasks>=10 then Put("Valor no válido.");New_Line; end if;      
      exit when num_tasks>0 and num_tasks<10;
   end loop;

   loop
      Put("Introduzca el número de eventos aperiódicos [1..9]: ");
      Get(num_aperiodic);
      if num_aperiodic<=0 or num_aperiodic>=10 then Put("Valor no válido.");New_Line;end if;      
      exit when num_aperiodic>0 and num_aperiodic<10;
   end loop;
   
   declare 
      -- El vector de tareas --
      wcet:v_enteros(1..num_tasks);
      deadline:v_enteros(1..num_tasks);
      period:v_enteros(1..num_tasks);
      -- vector de tiempos de ocurrencia de eventos aperiodicos
      aperiodicgroup:v_taskgroup(1..num_aperiodic);
      -- vector con parámetros de tareas   
      taskgroup:v_taskgroup(1..num_tasks);
      
   begin 
      -- Introducimos los datos de las tareas aqui a mano o elegimos uno conjunto predefinido
      -- Mejora: se pueden pedir por teclado
      if Setdata(wcet,deadline,period) then raise ErrorData; end if;
      -- Introducimos los datos de computo aperiódico y tiempos en los que suceden los eventos
      -- Mejora: se pueden pedir por teclado 
      aperiodicgroup:=SetTimeEvents(num_aperiodic);
      -- Comprobación de valores de las tareas   
      if CompruebaParametros(wcet,deadline,period)=1 then raise ErrorData;
      elsif CompruebaParametros(wcet,deadline,period)=2 then raise NoPlani; end if;      
      -- Se muestra por pantalla los valores de las tareas   
      Imprimir(wcet,deadline,period);
      -- Se muestra por pantalla los tiempos de los eventos aperiódicos
      ImprimirAperiodicos(wcet_aperiodic,aperiodicgroup);
      --Inicializar lo que haga falta
      Inittasks(taskgroup,wcet,deadline,period);

   -- Planificacion -------------------------------------------------------------------------------------------------------------
      for time in 0..99 loop     
         -- Actualizar tareas activas
         Estadotareas(time,taskgroup,aperiodicgroup);
         Setpriority(taskgroup,aperiodicgroup,time);     

         -- Ver si hay algun evento aperiodico activado en este tiempo
         -- Si hay evento aperiodico, decidir que hacer. Si se elige para
         -- ejecutar la tarea aperiodica entonces task_id=0
         -- muestra por consola el tiempo y el estado de las tareas 
         ShowStateTasks(time,taskgroup);
         -- Si no hay nigun evento aperiodico,
         if GetTaskON=0 then
            exec:=exec+1;
            chrono(exec).task_id:=GetTaskON;
            chrono(exec).start:=time;
            chrono(exec).finish:=chrono(exec).start +1;

         elsif GetTaskON>0 then
            exec:=exec+1;
         -- Escribir en chrono             
            chrono(exec).task_id:=taskgroup(GetTaskON).task_id;
            chrono(exec).start:=time;
            chrono(exec).finish:=chrono(exec).start +1;
            
         end if;
         -- Decrementar computo pendiente de la tarea elegida y si llega a cero, suspenderla            
         Refreshcomput(taskgroup,aperiodicgroup,wcet);
      end loop;
   ------------------------------------------------------------------------------------------------------------------------------
   -- Y lo escribimos en un fichero
      write_chronogram(period, deadline, chrono, num_tasks, exec, "test.svg");
      Put_line("Cronograma generado en test.svg");
   end;
   
Exception 
   when ErrorData =>
      Put("Error en los datos introducidos, no es posible ejecutar las tareas.");
   when NoPlani =>
      Put("Las tareas no son planificables.");        
end Main;

