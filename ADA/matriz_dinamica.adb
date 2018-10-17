with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Calendar;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Ada.Float_Text_IO;
use Ada.Calendar;

procedure matriz_dinamica is

n: Integer := 10;

subtype rangeRandom is Integer range 1 .. 10;
package Random_Gen is new Ada.Numerics.Discrete_Random(rangeRandom);
use Random_Gen;
G: Generator;

type Matriz is array(1 .. n,1 .. n) of Integer;

matrizA : Matriz;
matrizB : Matriz;
matrizR : Matriz;

time1: Time;
time2: Time;

task monitor is
    entry genMatriz(i: in Character);
    entry complete(i: in Integer);
end monitor;

task type multiplicaFila(id: Integer);
type multiplicaFilaAccess is access multiplicaFila;
P: multiplicaFilaAccess;

task genMatrizA;
task genMatrizB;

task body genMatrizA is
begin
    Random_Gen.Reset(G);
    for I in 1 .. n loop
        for J in 1 .. n loop
            matrizA(I, J) := Random(G);
        end loop;
    end loop;
    monitor.genMatriz('A');
end genMatrizA;

task body genMatrizB is
begin
    Random_Gen.Reset(G);
    for I in 1 .. n loop
        for J in 1 .. n loop
            matrizB(I, J) := Random(G);
        end loop;
    end loop;
    monitor.genMatriz('B');
end genMatrizB;

task body multiplicaFila is
begin
    Put_Line("Fila" & Integer'Image(id) & " liberada");
    for I in 1 .. n loop
        matrizR(id, I) := 0;
        for J in 1 .. n loop
            matrizR(id, I) := matrizR(id, I) + (matrizA(id, J) * matrizB(J, I));
        end loop;
    end loop;
    monitor.complete(id);
end multiplicaFila;

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
    Put_Line("Paso 2: Lanzar Tasks de Multiplicacion");
    Put_Line("");

    for I in 1 .. n loop
        P := new multiplicaFila(I);
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
        exit when count = n + 2;
    end loop;
    time2 := Clock;

    Put_Line("");
    Put_Line("Paso 4: Imprimir resultados");
    Put_Line("");
    Put_Line("Matriz A:");

    For I in 1 .. n loop
        For J in 1 .. n loop
            Put(MatrizA(I, J));
        end loop;
        Put_Line("");
    end loop;

    Put_Line("");
    Put_Line("Matriz B:");

    For I in 1 .. n loop
        For J in 1 .. n loop
            Put(MatrizB(I, J));
        end loop;
        Put_Line("");
    end loop;

    Put_Line("");
    Put_Line("Matriz R:");

    For I in 1 .. n loop
        For J in 1 .. n loop
            Put(MatrizR(I, J));
        end loop;
        Put_Line("");
    end loop;

    Put_Line("");
    Put_Line("Tiempo de ejecucion: " & Duration'Image(time2 - time1) & " segundos");
end monitor;

begin
    null;
end matriz_dinamica;