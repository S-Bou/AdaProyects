package areas is

   type rectangulo is private;

   function area_rectangulo(a, l: integer) return integer;

   --Darle valores a ancho y largo
   --procedure set_params(R: in out rectangulo; x, y: integer);

   private
   type rectangulo is record
      ancho, largo: integer;
   end record;

end areas;
