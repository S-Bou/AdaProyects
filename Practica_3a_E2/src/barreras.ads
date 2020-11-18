package barreras is
   MAX : constant := 3;
   protected barrera is

      entry entra_Norte;
      entry entra_Sur;
      procedure sale_Norte;
      procedure sale_Sur;

   private
      contador_Norte, contador_Sur : integer := 0;

   end barrera;
end barreras;
