package data is
   Num_tasks:integer;
   Task_ON:integer:=1;
   Tarea_activa:Boolean:=false;
   Aperiodic_ON:integer;
   Num_aperiodicos:integer;

   --------------------------------------
   ------ Definicion de tareas ----------
   --------------------------------------
   type tarea is record
      task_id: integer;
      time: float;
      state:boolean;
      wcet: integer;
      deadline:integer;
      period:integer;
   end record;

   type v_taskgroup is array (integer range <>) of tarea;
   type v_enteros is array (integer range <>) of integer;

   procedure SetNumTasks (N_tasks:in integer);
   procedure Refreshcomput (grupotareas,grupoaperiodicos: in out v_taskgroup;wcet: in v_enteros);
   procedure Estadotareas (time_loop: in integer;grupotareas,grupoaperiodicos: in out v_taskgroup);
   procedure Setdata (Wcet, Deadline, Period: in out v_enteros);
   procedure Setpriority (grupotareas,grupoaperiodicos: in out v_taskgroup;time: in integer);
   procedure conjuntos (conjunto: in integer; Wcet, Deadline, Period: in out v_enteros);
   procedure Inittasks (taskgroup:in out v_taskgroup;wcet,deadline,period:in v_enteros);
   procedure Imprimir (Wcet, Deadline, Period: in v_enteros);
   procedure ImprimirAperiodicos (T_Compu:in integer; aperiodicdata: in v_taskgroup);
   function SetTimeEvents (N_aperiodicos:in integer) return v_taskgroup;
   function CompruebaParametros (Wcet, Deadline, Period: in out v_enteros) return integer;
   procedure ShowStateTasks (time:in integer;taskgroup:in v_taskgroup);
   function GetTaskON return integer;

   --------------------------------------
   ------- Definicion de cronograma -----
   --------------------------------------

   -- Cada evento se compone de tiempo de inicio, fin e identificador de tarea
   type events is record
      task_id: integer;
      start: integer;
      finish: integer;
   end record;

   -- el cronograma es un vector de eventos de este tipo
   type chrono_set is array (integer range <>) of events;
   -- número máximo de instantes del cronograma --
   num_execs: integer:= 100;
   -- el vector del cronograma
   chrono: chrono_set(1..num_execs);

end data;
