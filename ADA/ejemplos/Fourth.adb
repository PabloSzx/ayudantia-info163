-- Copyright (C) 2006 M. Ben-Ari. See copyright.txt
with Text_IO; use Text_IO;
procedure Fourth is
  pragma Time_Slice(0.01);

  C1, C2: Integer := 1;
  pragma Volatile(C1);
  pragma Volatile(C2);

  task T1;
  task body T1 is
  begin
    loop
      Put_Line("Task 1 idling");
      C1 := 0;
      loop 
        exit when C2 /= 0; 
        C1 := 1;
        Put_Line("Task 1 reset variable");
        C1 := 0;
      end loop;
      Put_Line("Task 1 critical section");
      C1 := 1;
    end loop;
  end T1;

  task T2;
  task body T2 is
  begin
    loop
      Put_Line("Task 2 idling");
      C2 := 0;
      loop 
        exit when C1 /= 0; 
        C2 := 1;
        Put_Line("Task 2 reset variable");
        C2 := 0;
      end loop;
      Put_Line("Task 2 critical section");
      C2 := 1;
    end loop;
  end T2;

begin
  null;
end Fourth;
