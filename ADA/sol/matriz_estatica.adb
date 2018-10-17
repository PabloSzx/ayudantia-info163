with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Calendar;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Ada.Calendar;

procedure matriz_estatica is

subtype rangeRandom is Integer range 1 .. 10;
package Random_Gen is new Ada.Numerics.Discrete_Random(rangeRandom);
use Random_Gen;
G: Generator;

type Matriz is array(1 .. 3,1 .. 3) of Integer;

matrizA : Matriz := ((1, 2, 3), (1, 2, 3), (1, 2, 3));
matrizB : Matriz := ((1, 2, 3), (1, 2, 3), (1, 2, 3));
matrizR : Matriz := ((1, 2, 3), (1, 2, 3), (1, 2, 3));

time1: Time;
time2: Time;

task fila1;
task fila2;
task fila3;

task genMatrizA;
task genMatrizB;

task monitor is
    entry genMatriz(i: in Character);
    entry ready(i: in Integer);
    entry complete(i: in Integer);
end monitor;

task body genMatrizA is
begin
    Random_Gen.Reset(G);
    for I in 1 .. 3 loop
        for J in 1 .. 3 loop
            matrizA(I, J) := Random(G);
        end loop;
    end loop;
    monitor.genMatriz('A');
end genMatrizA;

task body genMatrizB is
begin
    Random_Gen.Reset(G);
    for I in 1 .. 3 loop
        for J in 1 .. 3 loop
            matrizB(I, J) := Random(G);
        end loop;
    end loop;
    monitor.genMatriz('B');
end genMatrizB;

task body fila1 is
begin
    monitor.ready(1);
    for I in 1 .. 3 loop
        matrizR(1, I) := 0;
        for J in 1 .. 3 loop
            matrizR(1, I) := matrizR(1, I) + (matrizA(1, J) * matrizB(J, I));
        end loop;
    end loop;
    monitor.complete(1);
end fila1;

task body fila2 is
begin
    monitor.ready(2);
    for I in 1 .. 3 loop
        matrizR(2, I) := 0;
        for J in 1 .. 3 loop
            matrizR(2, I) := matrizR(2, I) + (matrizA(2, J) * matrizB(J, I));
        end loop;
    end loop;
    monitor.complete(2);
end fila2;


task body fila3 is
sum: Integer;
begin
    monitor.ready(3);
    for I in 1 .. 3 loop
        matrizR(3, I) := 0;
        for J in 1 .. 3 loop
            matrizR(3, I) := matrizR(3, I) + (matrizA(3, J) * matrizB(J, I));
        end loop;
    end loop;
    monitor.complete(3);
end fila3;

task body monitor is
count: Integer := 0;
begin
    Put_Line("");
    Put_Line("Paso 1: Generar Matrices Random");
    Put_Line("");

    loop
        accept genMatriz(i: in Character) do
            count := count + 1;
            Put_Line("Matriz " & i & " Generada");
        end genMatriz;
        exit when count = 2;
    end loop;

    Put_Line("");
    Put_Line("Paso 2: Liberar tasks de multiplicacion");
    Put_Line("");

    loop
        accept ready(i: in Integer) do
            count := count + 1;
            Put_Line("Fila" & Integer'Image(i) & " liberada");
        end ready;
        exit when count = 5;
    end loop;

    Put_Line("");
    Put_Line("Paso 3: Recibir task de multiplicaciones completadas");
    Put_Line("");

    time1 := Clock;
    loop
        accept complete(i: in Integer) do
            count := count + 1;
            Put_Line("Fila" & Integer'Image(i) & " completada");
        end complete;
        exit when count = 8;
    end loop;
    time2 := Clock;

    Put_Line("");
    Put_Line("Paso 4: Imprimir resultados");
    Put_Line("");
    Put_Line("Matriz A:");

    For I in 1 .. 3 loop
        For J in 1 .. 3 loop
            Put(MatrizA(I, J));
        end loop;
        Put_Line("");
    end loop;

    Put_Line("");
    Put_Line("Matriz B:");

    For I in 1 .. 3 loop
        For J in 1 .. 3 loop
            Put(MatrizB(I, J));
        end loop;
        Put_Line("");
    end loop;

    Put_Line("");
    Put_Line("Matriz R:");

    For I in 1 .. 3 loop
        For J in 1 .. 3 loop
            Put(MatrizR(I, J));
        end loop;
        Put_Line("");
    end loop;

    Put_Line("");
    Put_Line("Tiempo de ejecucion: " & Duration'Image(time2 - time1) & " segundos");
end monitor;


begin
null;
end matriz_estatica;
