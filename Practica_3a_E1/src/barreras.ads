package barreras is
   protected barrera is

      entry entrar;
      procedure salir;

   private
      abierta : boolean := true;

   end barrera;
end barreras;
