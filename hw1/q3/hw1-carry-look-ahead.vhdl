library ieee;
use ieee.std_logic_1164.all;


entity carry_look_ahead_adder is 
port(
   input1,input2,carryIn : in bit;
   sum,gen,propagate : out bit);
end entity;

architecture struct of carry_look_ahead_adder is

begin
    sum <= (input1 xor input2) xor carryIn;
    propagate <= input1 xor input2;
    gen <= input1 and input2;
end architecture;
