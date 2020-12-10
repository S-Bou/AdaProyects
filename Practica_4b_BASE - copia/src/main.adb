with ada.Numerics.Elementary_Functions; use ada.Numerics.Elementary_Functions;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with ada.text_io; use ada.text_io;
with data; use data;

procedure Main is
   Num_tasks: integer:=0;
   Num_Conjunto: integer;
   tipe_RM, tipe_DM, plani: boolean:=true;
   U_RM, Un_RM: float:=0.0;

begin  --Hay que indicar el numero de tareas que tendr� el conjunto
   loop
      Put("Introduzca el numero de tareas del conjunto: ");
      Get(Num_tasks);
      exit when Num_tasks>0;
   end loop;
   declare 
      tareas: task_set(1..Num_tasks);
   begin 
      
      inicializar(tareas); --Pone todos los valores a cero
      Put("Introduzca el numero del conjunto [1..6]: ");
      Get(Num_Conjunto);

      conjuntos(tareas, Num_Conjunto, Num_tasks); --Establece los valores de las tareas
   
      Put_line ("Programa que calcula si las siguientes tareas son planificables:");  
      -- imprimir parametros temporales de tareas 
      imprimir(tareas);
      -- Se comprueba si todos los periodos = deadlines y que periodos < deadlines
      for i in 1..Num_tasks loop
         if (params(tareas(i), 'T') /= params(tareas(i), 'D')) then
            tipe_RM := false;
         end if;
         if (params(tareas(i), 'T') < params(tareas(i), 'D')) then
            Put_Line("El conjunto NO es planificable (D > T).");
            tipe_DM := false;
         end if;
      end loop; 
-- si periodos = deadlines
      if tipe_RM then
         Put_Line("Todas las tareas tienen T = D");
         for i in 1..Num_tasks loop
            U_RM:=U_RM + float(params(tareas(i), 'C')) / float(params(tareas(i), 'T'));
         end loop;
         Un_RM:= float(Num_tasks)*(2.0**(1.0/float(Num_tasks))-1.0);
         Put("U = ");Put(U_RM,1,2,0);Put("; ");Put("U(n) = ");Put(Un_RM,1,2,0);
--      test del factor de utilizacion 
         if U_RM <= Un_RM then
            New_Line;
            Put_Line("El test del factor de utilizacion dice que el conjunto S� es planificable U <= U(n).");
--      si test utilizacion dice que no es planificable
         else if U_RM > Un_RM then
            New_Line;
            Put_Line("El test del factor de utilizacion dice que el conjunto NO es planificable U > U(n).");
            plani:=false;   
            end if;
         end if;
      if plani then
--        test del peor tiempo de respuesta 
            Put_Line("Hay que hacer el test del peor tiempo de respuesta.");
            tipe_RM:=false;
         end if;
      end if;
-- si periodos /= deadlines
      if tipe_RM=false and plani and tipe_DM then
--      test del peor tiempo de respuesta 
            Put_Line("Se realiza test del peor tiempo de respuesta para.");
      end if;
      
   end;
end Main;
