with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
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

   procedure ordenarPrioridad (taskup: in out task_set) is
      T_S_AUX: tarea;
      D_AUX:integer:=0;
   begin                       -- mirar el Deadline para ordenar prioridades
      for i in taskup'range loop
         for j in taskup'range loop
            if taskup(i).deadline < taskup(j).deadline then
               T_S_AUX:=taskup(j);
               taskup(j):=taskup(i);
               taskup(i):=T_S_AUX;
            end if;
         end loop;
      end loop;
   end ordenarPrioridad;

   function TiempoRespuesta (taskup: in task_set; N: integer) return boolean is
      EsPlaniONo: boolean:=true;
      W_i, last_W: integer:=taskup(1).wcet;
   begin
      for i in 1..N loop
         loop
            last_W:=W_i;
            W_i:=taskup(i).wcet+sumatorio(taskup, W_i, i);
            exit when W_i=last_W   ;
         end loop;
         Put("Peor tiempo de la tarea ");Put(i,1);Put(": ");Put(W_i,2);
         New_Line;
         if W_i > taskup(i).deadline then
            EsPlaniONo:=false;
         end if;
      end loop;
      return EsPlaniONo;
   end TiempoRespuesta;

   function sumatorio (taskup: in task_set; Wi, count: integer) return integer is
      suma: integer:=0;
   begin
      suma:=0;
      if count=1 then
         return suma;
      else
         for i in 1..count-1 loop
            suma:=suma+(integer(float'Ceiling(float(Wi)/float(taskup(i).period)))*taskup(i).wcet);
         end loop;
         return suma;
      end if;
   end sumatorio;

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
      if    number=1 and Num_T=3 then       --Tx=(C, D, T)
         dataTask(taskup(1),  2,  6,  8);   --No planificable
         dataTask(taskup(2),  4, 10, 15);
         dataTask(taskup(3),  5, 11, 14);
      elsif number=2 and Num_T=4 then
         dataTask(taskup(1),  2,  5,  5);  --No planificable
         dataTask(taskup(2),  3, 10, 13);
         dataTask(taskup(3),  5, 16, 20);
         dataTask(taskup(4),  2, 24, 24);
      elsif number=3 and Num_T=3 then
         dataTask(taskup(1),  2,  9,  9);  --S� planificable
         dataTask(taskup(2),  3,  5, 10);
         dataTask(taskup(3),  3,  7, 11);
      elsif number=4 and Num_T=3 then
         dataTask(taskup(1), 20, 50, 60);  --No planificable
         dataTask(taskup(2), 50, 70, 80);
         dataTask(taskup(3), 70,100,110);
      elsif number=5 and Num_T=3 then
         dataTask(taskup(1),  2, 10, 10);  --RM S� planificable
         dataTask(taskup(2),  4, 18, 18);
         dataTask(taskup(3),  6, 24, 24);
      elsif number=6 and Num_T=3 then
         dataTask(taskup(1),  2, 10, 10);  --RM No planificable
         dataTask(taskup(2),  4, 12, 12);
         dataTask(taskup(3),  6, 22, 22);
      elsif number=7 and Num_T=4 then
         dataTask(taskup(1),  3, 10, 10);  --RM = NO
         dataTask(taskup(2),  3, 15, 15);  --DM = S�
         dataTask(taskup(3),  2, 18, 18);
         dataTask(taskup(4),  5, 24, 24);
      else
         Put_Line("El n�mero de tareas no coincide con el conjunto.");
         Put_Line("Tareas no definidas.");
      end if;
   end conjuntos;

end data;
