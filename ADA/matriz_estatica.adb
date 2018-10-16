with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Real_Time;
use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Ada.Float_Text_IO;


procedure matriz_estatica is

subtype rangeRandom is Integer range 1 .. 10;
package Random_Gen is new Ada.Numerics.Discrete_Random(rangeRandom);
use Random_Gen;
G: Generator;

type Matriz is array(1 .. 3,1 .. 3) of Integer;

matrizA : Matriz;
matrizB : Matriz;
matrizR : Matriz;

task fila1;
task fila2;
task fila3;

task genMatrizA;
task genMatrizB;

task monitor is
    entry genMatriz(i: in Character);
    entry ready(i: in Integer);
    entry fila(i: in Integer);
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
sum: Integer;
begin
    monitor.ready(1);
    for I in 1 .. 3 loop
        sum := 0;
        for J in 1 .. 3 loop
            sum := sum + (matrizA(1, J) * matrizB(J, I));
        end loop;
        matrizR(1, I) := sum;
    end loop;
    monitor.fila(1);
end fila1;

task body fila2 is
sum: Integer;
begin
    monitor.ready(2);
    for I in 1 .. 3 loop
        sum := 0;
        for J in 1 .. 3 loop
            sum := sum + (matrizA(2, J) * matrizB(J, I));
        end loop;
        matrizR(2, I) := sum;
    end loop;
    monitor.fila(2);
end fila2;


task body fila3 is
sum: Integer;
begin
    monitor.ready(3);
    for I in 1 .. 3 loop
        sum := 0;
        for J in 1 .. 3 loop
            sum := sum + (matrizA(3, J) * matrizB(J, I));
        end loop;
        matrizR(3, I) := sum;
    end loop;
    monitor.fila(3);
end fila3;

task body monitor is
count: Integer := 0;
begin
    Put_Line("");
    Put_Line("Paso 1: Generar Matrices Random");
    Put_Line("");

    loop
        select 
            accept genMatriz(i: in Character) do
                count := count + 1;
                Put_Line("Matriz " & i & " Generada");
            end genMatriz;
        end select;
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

    loop
        accept fila(i: in Integer) do
            count := count + 1;
            Put_Line("Fila" & Integer'Image(i) & " completada");
        end fila;
        exit when count = 8;
    end loop;

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
end monitor;


begin
null;
end matriz_estatica;
