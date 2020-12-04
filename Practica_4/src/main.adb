with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.text_io; use ada.text_io;
with data; use data;

procedure Main is

    -- numero de tareas --
   Num_tasks: integer:=3; 
  
   tareas:task_set(1..Num_tasks);
 
begin
   
   inicializar(tareas, Num_tasks);
   conjuntos(tareas, 1);
   
   Put_line ("Programa que calcula si las siguientes tareas son planificables");  
   -- imprimir parametros temporales de tareas 
   imprimir(tareas, Num_tasks);
   
   for i in 1..Num_tasks loop
      -- si periodos = deadlines

      Put(params(tareas(i), 'C'),3);
      Put(params(tareas(i), 'D'),3);
   --      test del factor de utilizacion 
   --      si test utilizacion dice que no es planificable
   --        test del peor tiempo de respuesta 
   -- si no  
   --      test del peor tiempo de respuesta  
   null;
   end loop; 
end Main;
