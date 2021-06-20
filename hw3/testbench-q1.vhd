library ieee;
use ieee.std_logic_1164.all;

entity testbench is 

end testbench;

architecture arch of testbench is 

	component n_dec_counter is 
		generic (N: natural);
		port (
			clk, reset: in std_logic;
			en: in std_logic;
			q_n: out std_logic_vector(4*N-1 downto 0);
			p: out std_logic);
	end component;
	
	constant N: natural:= 4;
	signal clk: std_logic:= '0';
	signal reset: std_logic:= '0';
	signal en: std_logic:= '1';
	signal q: std_logic_vector(4*N-1 downto 0);
	signal p: std_logic:= '0';
	
	begin 
		uut: n_dec_counter
			generic map (N => N)
			port map (
				clk => clk,
				reset => reset,
				en => en,
				q_n => q,
				p => p);
				
	process 
		begin 
			clk <= '1';
			wait for 15 ns;
			clk <= '0';
			wait for 15 ns;
			clk <= '1';
			wait for 15 ns;
			clk <= '0';
			wait for 15 ns;
			clk <= '1';
			wait for 15 ns;
			clk <= '0';
			wait for 15 ns;
	end process;
	
	end arch;