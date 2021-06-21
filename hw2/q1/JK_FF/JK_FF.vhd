library ieee;
use ieee.std_logic_1164.all;

entity JK_FF is port(
	clk, reset: in std_logic;
	j, k: in std_logic;
	q: out std_logic
	);
end JK_FF;

architecture arch of JK_FF is 

	signal q_temp: std_logic;

	begin
		-- process(clk,reset)
		-- 	begin 
		-- 		if(reset = '1') then 
		-- 			r_reg <= (othres => '0');
		-- 		elsif(clk'event and clk = '1') then
		-- 			r_reg <= r_next
		-- 		end if;
		-- end process;
		-- if(j = '0' and k = '0') then 
		-- 		r_next <= r_reg;
		-- 	elsif(j = '0' and k = '1') then
		-- 		r_next <= '0';
		-- 	elsif(j = '1' and k = '0') then
		-- 		r_next <= '1';
		-- 	elsif(j = '1' and k = '1') then
		-- 		r_next <= not (r_reg);
		-- 	end if;
		-- q <= r_reg

		process(clk, reset) 
			begin
				if(reset = '1') then
					q_temp <= '0';
				elsif (clk'event and clk = '1') then
					if(j = '0' and k = '0') then 
						q_temp <= q_temp;
					elsif(j = '0' and k = '1') then
						q_temp <= '0';
					elsif(j = '1' and k = '0') then
						q_temp <= '1';
					elsif(j = '1' and k = '1') then
						q_temp <= not (q_temp);
					end if;
				end if;
			end process;
			q <= q_temp;
		end arch;
					