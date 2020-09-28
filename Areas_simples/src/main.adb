with Text_IO; use Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with areas; use areas;

procedure Main is
   x, y : integer;

begin
   put("Dime el ancho de un rectangulo: ");
   get(x);
   put("Dime el largo de un rectangulo: ");
   get(y);

   put("El area del rectanguloes:");
   put(area_rectangulo(x, y));

end Main;
