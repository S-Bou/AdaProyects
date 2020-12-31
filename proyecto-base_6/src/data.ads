package data is
   Num_tasks:integer;
   tarea_on:integer:=0;
   procesingtask:boolean:=false;
   aperiodic:boolean:=false;
--------------------------------------
------ Definicion de tareas ----------
--------------------------------------
   type tarea is record
	   task_id: integer;
      time: integer;
      state:boolean;
      wcet: integer;
      deadline:integer;
      period:integer;
   end record;

type v_taskgroup is array (integer range <>) of tarea;
type v_enteros is array (integer range <>) of integer;

procedure SetNumTasks (N_tasks:in integer);
function Refreshcomput (tareason,wcet,real_wcet: in out v_enteros) return v_enteros;
procedure Estadotareas (TIME: in integer;grupotareas: in out v_taskgroup);
procedure Setdata (Wcet, Deadline, Period: in out v_enteros);
function Setpriority (tareason,rowtasks: in out v_enteros) return v_enteros;
procedure conjuntos (conjunto: in integer; Wcet, Deadline, Period: in out v_enteros);
procedure Inittasks (taskgroup:in out v_taskgroup;wcet,deadline,period:in v_enteros);
procedure Imprimir (Wcet, Deadline, Period: in v_enteros);
procedure ImprimirET (T_Compu:in integer; Eventstime: in v_enteros);
function SetTimeEvents (Eventstime:in out v_enteros) return integer;
procedure ShowStateTasks (time:in integer;taskgroup:in v_taskgroup);
function Getpriority return integer;

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
