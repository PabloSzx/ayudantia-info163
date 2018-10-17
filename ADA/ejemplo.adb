with Ada.Text_IO;
with Ada.Integer_Text_IO;

with Ada.Numerics.Discrete_Random;
use Ada.Integer_Text_IO;

use Ada.Text_IO;

procedure ejemplo is

subtype rangeRandom is Integer range 1 .. 10;
package Random_Gen is new Ada.Numerics.Discrete_Random(rangeRandom);
use Random_Gen;
G: Generator;

i: Integer;
n: Integer := 10;

matrizA : array(1 .. 10, 1 .. 10) of Integer; 

begin
    Random_Gen.Reset(G);
    i := Random(G);

    for j in 1 .. n
    loop
        Put(j);
    end loop;
end ejemplo;