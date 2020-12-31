package data is


--------------------------------------
------ Definicion de tareas ----------
--------------------------------------

type v_enteros is array (integer range <>) of integer;

procedure Setdata (N_tasks: in out integer; Wcet, Deadline, Period: in out v_enteros);
procedure conjuntos (conjunto, Num_T: in integer; Wcet, Deadline, Period: in out v_enteros);
procedure Imprimir (Wcet, Deadline, Period: in v_enteros);
procedure ImprimirET (T_Compu:in integer; Eventstime: in v_enteros);
function SetTimeEvents (Eventstime:in out v_enteros) return integer;
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
