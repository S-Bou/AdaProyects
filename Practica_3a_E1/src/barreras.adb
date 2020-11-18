package body barreras is
   protected body barrera is

      entry entrar when abierta is
      begin
         abierta := false;
      end entrar;

      procedure salir is
      begin
         abierta := true;
      end salir;

   end barrera;
end barreras;
