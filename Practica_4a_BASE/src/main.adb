with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.text_io; use ada.text_io;
with data; use data;

procedure Main is

    -- numero de tareas --
   Num_tasks: integer:=3; 
   Num_Conjunto: integer;
   tareas:task_set(1..Num_tasks);
begin
   Put("Introduzca el numero del conjunto [1..4]: ");
   Get(Num_Conjunto);

   inicializar(tareas);
   conjuntos(tareas, Num_Conjunto);
   
   Put_line ("Programa que calcula si las siguientes tareas son planificables");  
   -- imprimir parametros temporales de tareas 
   imprimir(tareas);
   
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
