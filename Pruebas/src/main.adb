with ada.integer_Text_IO; use ada.integer_Text_IO;
with ada.float_text_io; use ada.float_Text_IO;

procedure Main is
   x: float;
   a: integer;
begin
   get(a);
   case a is
     when 0..integer'last =>x:=1.0;
     when integer'first..-1 =>x:=0.0;
   end case;
   put(x);
end Main;
