with Text_IO; use Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

procedure Main is
A, B : integer;
begin
   Put("Inserte el  primer numero: ");Get(A);
   Put("Inserte el segundo numero: ");Get(B);
   if A>0 and B>0 then
      While A/=B loop

         if A < B then
            B := B-A;
         else
            A := A-B;
         end if;

      end loop;

      Put("M.C.D. = ");Put(A, 1);
      New_line;

      If A=1 or B=1 then
         Put("M.C.D. = 1 -> SI son primos entre si.");
      else
         Put("M.C.D. /= 1 -> NO son primos entre si.");
      end if;
   else
        Put("Introduzca valores mayores que cero.");
   end if;
end Main;
