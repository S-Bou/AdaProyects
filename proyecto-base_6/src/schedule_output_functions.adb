with data; use data;
with Text_IO; use Text_IO;
with Ada.Strings.Fixed; use ada.strings.Fixed;

package body Schedule_Output_functions is
   width, height: integer;
   zoom:integer:=30;
   offset:integer:=20;

   procedure SVG_Put_Header(f:file_type) is

   begin
      Put_line(f,"<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>" );
      Put_line(f,"<!DOCTYPE svg PUBLIC ""-//W3C//DTD SVG 1.0//EN"" ""http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"">");
      Put_line(f,"<svg height="""& integer'Image(height) &""" width=""" & integer'Image(width) & """ xmlns=""http://www.w3.org/2000/svg"" xmlns:svg=""http://www.w3.org/2000/svg"" xmlns:xlink=""http://www.w3.org/1999/xlink"">");

   end SVG_Put_header;

   procedure SVG_Put_Footer(f:file_type) is
   begin
      Put_line(f,"</svg>");
   end SVG_Put_Footer;

   procedure SVG_Put_Exec(f:file_type; h,w,x,y:in integer) is
   begin
       --Put_line(f,"<rect height="""&integer'Image(h)&"""  stroke=""black"" stroke-width=""6"" fill=""green""  width=""" &integer'image(w)& """ x=""" & integer'image(x) & """ y=""" & integer'image(y)& """ />");
     Put_line(f,"<rect height="""&Trim(integer'Image(h),Ada.Strings.Left)&""" id=""ss_134"" style=""stroke-miterlimit: 4; fill-opacity: 1; stroke: inherit; stroke-opacity: 1; stroke-linejoin: miter; opacity: 1; fill: rgb(0, 0, 0); stroke-width: 1"" width=""" &Trim(integer'Image(w),Ada.Strings.Left)& """ x=""" & Trim(integer'Image(x),Ada.Strings.Left) & """ y=""" & Trim(integer'Image(y),Ada.Strings.Left)& """ />");
   end SVG_Put_Exec;

   procedure SVG_Put_Task_Params(f:file_type; d,p:v_enteros) is
   x,xf,y,j:integer;
   begin
      for i in d'range loop
         j:=0;
         loop
            x:=2*offset+j*p(i)*zoom;
            xf:=x+d(i)*zoom;
            y:=i*zoom+offset;
 	    Put_line(f,"<line id="""" style=""stroke: red; stroke-width: 2"" x1="""&Trim(integer'Image(x),Ada.Strings.Left)&""" x2="""&Trim(integer'Image(x),Ada.Strings.Left)&""" y1="""&Trim(integer'Image(y),Ada.Strings.Left)&""" y2="""&Trim(integer'Image(y-offset),Ada.Strings.Left)&""" />");
 	    Put_line(f,"<line id="""" style=""stroke: red; stroke-width: 2"" x1="""&Trim(integer'Image(x),Ada.Strings.Left)&""" x2="""&Trim(integer'Image(xf),Ada.Strings.Left)&""" y1="""&Trim(integer'Image(y),Ada.Strings.Left)&""" y2="""&Trim(integer'Image(y),Ada.Strings.Left)&""" />");
 	    Put_line(f,"<line id="""" style=""stroke: red; stroke-width: 2"" x1="""&Trim(integer'Image(xf),Ada.Strings.Left)&""" x2="""&Trim(integer'Image(xf),Ada.Strings.Left)&""" y1="""&Trim(integer'Image(y),Ada.Strings.Left)&""" y2="""&Trim(integer'Image(y-offset),Ada.Strings.Left)&""" />");
            j:=j+1;
            exit when j>height/zoom;
         end loop;

      end loop;

   end SVG_Put_Task_Params;


   procedure SVG_Put_Grid(f:file_type) is
        i: integer:=0;
        inc: integer:=1;
     begin
        loop
         Put_line(f,"<line id="""" style=""stroke-dasharray: 2 2; stroke: grey; stroke-width: 1"" x1="""&Trim(integer'Image(i*zoom+2*offset),Ada.Strings.Left)&""" x2="""&Trim(integer'Image(i*zoom+2*offset),Ada.Strings.Left)&""" y1="""&Trim(integer'Image(offset),Ada.Strings.Left)&""" y2="""&Trim(integer'Image(height-2*offset),Ada.Strings.Left)&""" />");
         if (i mod 5 =0) then
      	   Put_line(f,"<text id=""T"&Trim(integer'Image(i),Ada.Strings.Left)&""" style=""text-anchor: middle; font-weight: 500; font-family: Verdana; font-size: 10"" x="""&Trim(integer'Image(i*zoom+2*offset),Ada.Strings.Left)&""" y="""&Trim(integer'image(height-offset),Ada.Strings.Left)&""">"&Trim(integer'Image(i),Ada.Strings.Left)&"</text>");
         end if;
         i:=i+inc;
         exit when i>zoom*height;
        end loop;
   end SVG_Put_Grid;


   procedure SVG_Put_Task_Lines(f:file_type; n:integer) is
   begin
      for i in 1..n loop

        Put_line(f,"<text id=""T"&Trim(integer'Image(i),Ada.Strings.Left)&""" style=""text-anchor: middle; font-weight: 500; font-family: Verdana; font-size: 14"" x="""&Trim(integer'Image(offset),Ada.Strings.Left)&""" y="""&Trim(integer'image(i*zoom+offset),Ada.Strings.Left)&""">T"&Trim(integer'Image(i),Ada.Strings.Left)&"</text>");
         Put_line(f,"<line id="""" style=""stroke: rgb( 50, 50, 50); stroke-width: 1"" x1="""&Trim(integer'Image(0),Ada.Strings.Left)&""" x2="""&Trim(integer'Image(width),Ada.Strings.Left)&""" y1="""&Trim(integer'Image(i*zoom+offset),Ada.Strings.Left)&""" y2="""&Trim(integer'Image(i*zoom+offset),Ada.Strings.Left)&""" />");
      end loop;

   end SVG_Put_Task_Lines;



procedure write_Chronogram(d,p:v_enteros; v: chrono_set; n,e: integer; file_name: string) is

      f: file_type;
begin

      Create(f, out_file, file_name);

      width:=3*offset+zoom*(v(e).finish);
      height:= 3*offset+zoom*(n+1);

      SVG_Put_Header(f);

      -- Task horizontal lines and params
      SVG_Put_Task_Lines(f,n);
      SVG_Put_Task_Params(f,p,d);
      -------------------------

      -- Grid
      SVG_Put_Grid(f);
      -----------------------

      -- Execution boxes
      for i in 1..e loop
         if v(i).task_id>0 then
            SVG_Put_Exec (f,zoom-offset,zoom*(v(i).finish-v(i).start),zoom*v(i).start+2*offset,2*offset+zoom*(v(i).task_id-1));
          else
            SVG_Put_Exec (f,zoom-offset,zoom*(v(i).finish-v(i).start),zoom*v(i).start+2*offset,2*offset+zoom*(n));
           end if;
       end loop;
      ---------------------

      SVG_Put_Footer(f);

      close(f);

   end write_Chronogram;




end schedule_output_functions;
