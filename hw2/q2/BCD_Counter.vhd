library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD_Counter is port(
	clk, reset: in std_logic;
	Dir: in std_logic;
	q: out std_logic_vector(3 downto 0)
	);
end BCD_Counter;

architecture arch of BCD_Counter is 
	signal counter: unsigned(3 downto 0);
	
	begin
		process(clk, reset) 
			begin
				if (reset = '1') then
					counter <= (others => '0');
				elsif (clk'event and clk = '1') then
					if (Dir = '1') then 
						counter <= counter + 1;
					elsif (Dir = '0') then
						counter <= counter - 1;
					end if;
				end if;
			end process;
		
		q <= std_logic_vector(counter);
		
	end arch;
	
					
	