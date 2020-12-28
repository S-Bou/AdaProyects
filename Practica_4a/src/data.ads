package data is

--------------------------------------
------ Definicion de tareas ----------
--------------------------------------
type tarea is private;

-- El conjunto de tareas es un vector de este tipo
type task_set is array (integer range <>) of tarea;

   -- subprogramas de escritura y lectura del tipo privado
   procedure inicializar (taskup: in out task_set);
   procedure dataTask (taskup:in out tarea; dataC, dataD, dataT:in integer);
   function params (taskup:in tarea; param:in character) return integer;
   procedure ordenarPrioridad (taskup: in task_set);
   procedure imprimir (taskup: in task_set);
   procedure conjuntos (taskup: in out task_set; number, Num_T : in integer);

type set_tasks (Num_tasks: integer) is
   record
   tareas:task_set(1..Num_tasks);
 end record;

private
type tarea is record
      wcet, deadline, period: integer;
end record;

end data;
