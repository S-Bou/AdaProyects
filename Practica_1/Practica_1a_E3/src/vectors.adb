
package body vectors is

--Calcula la suma de un vector y un escalar
   function "+" (K : Float; Right : Vector) return Vector is
      data : Vector(1..10);
   begin
      for i in 1..10 loop
         data(i) := Right(i) + K;
      end loop;
      return data;
   end "+";
   
--Calcula el producto de un vector y un escalar
   function "*" (K : Float; Right : Vector) return Vector is
      data : Vector(1..10);
   begin
      for i in 1..10 loop
         data(i) := Right(i) * K;
      end loop;
      return data;
   end "*";
             
--Calcula el producto de dos vectores
   function "*" (Left, Right : Vector) return Vector is
      data : Vector(1..10);
   begin
      for i in 1..10 loop
         data(i) := Left(i) * Right(i);
      end loop;
      return data;
   end "*";
   
--Calcula la suma de dos vectores
   function "+" (Left, Right : Vector) return Vector is
      data : Vector(1..10);
   begin
      for i in 1..10 loop
         data(i) := Left(i) + Right(i);
      end loop;
      return data;
   end "+";
     
--Show in console content of vector
   procedure printv (data : in Vector) is
   begin
      for i in 1..10 loop
      Put(data(i), 2, 1, 0);
      Put(", ");       
      end loop;
   end printv;
   
end vectors;

