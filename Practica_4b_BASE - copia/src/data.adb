
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
package body data is

   procedure inicializar (taskup: in out task_set) is
   begin
      for i in taskup'range loop
         taskup(i).wcet:=0;
         taskup(i).deadline:=0;
         taskup(i).period:=0;
      end loop;
   end inicializar;

   procedure dataTask (taskup:in out tarea; dataC, dataD, dataT:in integer) is
   begin
      taskup.wcet:=dataC;
      taskup.deadline:=dataD;
      taskup.period:=dataT;
      --null;
   end dataTask;

   function params (taskup:in tarea; param:in character) return integer is
   begin
      if    param='C' then
         return taskup.wcet;
      elsif param='D' then
         return taskup.deadline;
      elsif param='T' then
         return taskup.period;
      else
         return 0;
      end if;
   end params;

   procedure ordenarPrioridad (taskup: in task_set) is
      T_S_AUX : task_set(taskup'range);
   begin
      for i in taskup'range loop
         -- mirar tiempo de computo para ordenar prioridades
         null;
      end loop;
   end ordenarPrioridad;

   procedure imprimir (taskup: in task_set) is
   begin
      for i in taskup'range loop
         Put("Tarea(");Put(i,1);Put(")=[");Put(taskup(i).wcet,3);Put(",");
         Put(taskup(i).deadline,3);Put(",");Put(taskup(i).period,3);Put("]");
         New_Line;
      end loop;
   end imprimir;

   procedure conjuntos (taskup: in out task_set; number, Num_T : in integer) is
   begin
      if    number=1 and Num_T=3 then
         dataTask(taskup(1),  2,  6,  8);   -- Tx=(C, D, T)
         dataTask(taskup(2),  4, 10, 15);
         dataTask(taskup(3),  5, 11, 14);
      elsif number=2 and Num_T=4 then
         dataTask(taskup(1),  2,  5,  5);
         dataTask(taskup(2),  3, 10, 13);
         dataTask(taskup(3),  5, 16, 20);
         dataTask(taskup(4),  2, 24, 24);
      elsif number=3 and Num_T=3 then
         dataTask(taskup(1),  2,  9,  9);
         dataTask(taskup(2),  3,  5, 10);
         dataTask(taskup(3),  3,  7, 11);
      elsif number=4 and Num_T=3 then
         dataTask(taskup(1), 20, 50, 60);
         dataTask(taskup(2), 50, 70, 80);
         dataTask(taskup(3), 70,100,110);
      else
         Put_Line("El número de tareas no coincide con el conjunto.");
         Put_Line("Tareas no definidas.");
         dataTask(taskup(1), 2, 10, 10);
         dataTask(taskup(2), 4, 12, 12);
         dataTask(taskup(3), 6, 22, 22);
      end if;
   end conjuntos;

end data;
