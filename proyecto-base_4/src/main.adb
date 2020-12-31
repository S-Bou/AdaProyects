-- Trabajo 2:Planificador FCFS; por Sergio Bou Grau
with schedule_output_functions; use schedule_output_functions;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with text_io; use text_io;
with data; use data;

procedure Main is
   -- numero de tareas --
   num_tasks: integer:=0;
   
   -- numero de instantes del cronograma
   exec:integer:=4; -- poner a 0 cuando se empiece el trabajo
   
   -- Datos de eventos aperiódicos
   -- numero de eventos aperiodicos
   num_events: integer:=0;
   -- unidades de computo del evento aperiodico
   t_compu_events: integer:=0;
   
begin
      loop
         Put("Introduzca el número de tareas del conjunto [1..9]: ");
         Get(num_tasks);
      exit when num_tasks>0 and num_tasks<10;
   end loop;

      loop
         Put("Introduzca el número de eventos aperiódicos [1..9]: ");
         Get(num_events);
      exit when num_events>0 and num_events<10;
      end loop;
   declare 
      -- El vector de tareas --
      wcet:v_enteros(1..num_tasks);
      deadline:v_enteros(1..num_tasks);
      period:v_enteros(1..num_tasks);
   -- vector de tiempos de ocurrencia de eventos aperiodicos
      eventstime:v_enteros(1..num_events);
   -- vector con estados de las tareas: 1= activa, 0 inactiva
      tasksstate:v_enteros(1..num_tasks);
   -- vector con el valor actualizado del tiempo de computo   
      real_WCET:v_enteros(1..num_tasks);
   begin 
   -- Introducimos los datos de las tareas aqui a mano o elegimos uno conjunto predefinido
   -- Mejora: se pueden pedir por teclado
      Setdata(num_tasks,wcet,deadline,period);
   -- Introducimos los datos de computo aperiódico 
   -- y tiempos en los que suceden los eventos
   -- Mejora: se pueden pedir por teclado   
      t_compu_events:=SetTimeEvents(eventstime);
   -- Se muestra por pantalla los valores de las tareas   
      Imprimir(wcet,deadline,period);
   -- Se muestra por pantalla los tiempos de los eventos aperiódicos
      ImprimirET(t_compu_events,eventstime);
   --Inicializar lo que haga falta
   for i in tasksstate'Range loop
      tasksstate(i):=0;
   end loop;
    -- Planificacion    -------------------------
   for time in 0..100 loop
      null;
      -- Actualizar tareas activas
      tasksstate:=Estadotareas(time,tasksstate,period,wcet);
      -- muestra por consola el tiempo y el estado de las tareas (1=ON, 0=OFF)
      Showstatetasks(time,tasksstate);
      -- Ver si hay algun evento aperiodico activado en este tiempo
      -- Si hay evento aperiodico, decidir que hacer. Si se elige para
      -- ejecutar la tarea aperiodica entonces task_id=0
      -- Si no hay nigun evento aperiodico,
      --    elegir la tarea según el algoritmo de planificacion
      --    considerar el caso de que no haya ninguna activa
      -- Escribir en chrono     
      -- Decrementar computo pendiente de la tarea elegida 
      --    y si llega a cero, suspenderla
   end loop;
   --------------------------
   -- Ejemplo, comentar cuando se empiece a implementar
   chrono(1).task_id:=1;
   chrono(1).start:=0;
   chrono(1).finish:=1;
   chrono(2).task_id:=2;
   chrono(2).start:=2;
   chrono(2).finish:=5;
   chrono(3).task_id:=3;
   chrono(3).start:=5;
   chrono(3).finish:=11;
   chrono(4).task_id:=1;
   chrono(4).start:=15;
   chrono(4).finish:=18;
   -- Y lo escribimos en un fichero
   write_chronogram(period, deadline, chrono, num_tasks, exec, "test.svg");
      Put_line("Cronograma generado en test.svg");
   end;
end Main;

