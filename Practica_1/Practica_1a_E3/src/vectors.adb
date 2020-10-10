package body vectors is

   package Vectors is
      type Vector is array(Integer range <>) of Float;
      function "+" (K : Float; Right : Vector) return Vector;
      --Calcula la suma de un vector y un escalar
      function "*" (K : Float; Right : Vector) return Vector;
      --Calcula el producto de un vector y un escalar
      function "*" (Left, Right : Vector) return Float;
      --Calcula el producto de dos vectores
      function "+" (Left, Right : Vector) return Vector;
      --Calcula la suma de dos vectores
   end Vectors;
   
end vectors;
