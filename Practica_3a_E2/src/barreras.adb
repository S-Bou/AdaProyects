package body barreras is
   protected body barrera is

      entry entra_Norte when contador_Norte < MAX and contador_Sur = 0 is
      begin
         contador_Norte := contador_Norte + 1;
      end entra_Norte;

      entry entra_Sur when contador_Sur < MAX and contador_Norte = 0 is
      begin
         contador_Sur := contador_Sur + 1;
      end entra_Sur;

      procedure sale_Norte is
      begin
         contador_Norte := contador_Norte - 1;
      end sale_Norte;

      procedure sale_Sur is
      begin
         contador_Sur := contador_Sur - 1;
      end sale_Sur;

   end barrera;
end barreras;
