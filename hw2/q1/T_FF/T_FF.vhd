library ieee;
use ieee.std_logic_1164.all;

entity T_FF is 
  port(
    clk: in std_logic;
    reset: in std_logic;
    t: in std_logic;
    q: out std_logic
    );
end T_FF;

architecture arch of T_FF is 
  
  signal q_next: std_logic;
  
  begin
    process(clk, reset)
      begin
        if (reset = '1') then
          q_next <= '0';
        elsif (clk'event and clk = '1') then
            q_next <= (t xor q_next);
        end if;
        q <= q_next;
    end process;
end arch;