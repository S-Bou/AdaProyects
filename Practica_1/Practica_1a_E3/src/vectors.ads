with Text_IO; use Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;

package vectors is

   type Vector is array(Integer range <>) of Float;
   --Calcula la suma de un vector y un escalar
   function "+" (K : Float; Right : Vector) return Vector;
   --Calcula el producto de un vector y un escalar
   function "*" (K : Float; Right : Vector) return Vector;
   --Calcula el producto de dos vectores
   function "*" (Left, Right : Vector) return Vector;
   --Calcula la suma de dos vectores 
   function "+" (Left, Right : Vector) return Vector;
   --Show in console content of vector
   procedure printv (data : in Vector);
   
end vectors;
