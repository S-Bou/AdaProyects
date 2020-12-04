package data is

--------------------------------------
------ Definicion de tareas ----------
--------------------------------------
type tarea is private;

-- El conjunto de tareas es un vector de este tipo
type task_set is array (integer range <>) of tarea;

   -- subprogramas de escritura y lectura del tipo privado
   procedure inicializar (taskup : in out task_set; N_tasks:in integer);
   procedure dataTask (taskup:in out tarea; dataC, dataD, dataT:in integer);
   function params (taskup:in tarea; param:in character) return integer;
   procedure imprimir (taskup: in task_set; N_tasks:in integer);
   procedure conjuntos (taskup: in out task_set; number : in integer);
private
type tarea is record
      wcet, deadline, period: integer;
end record;

end data;
