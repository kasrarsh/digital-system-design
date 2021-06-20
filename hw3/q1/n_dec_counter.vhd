library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity n_dec_counter is
	generic (N: natural:= 4);
	port (
	clk, reset: in std_logic;
	en: in std_logic;
	q_n: out std_logic_vector(0 to (4*N)-1);
	p: out std_logic
	);
end n_dec_counter;

architecture counter_arch of n_dec_counter is
	component dec_counter
		port(
		clk, reset: in std_logic;
		en: in std_logic;
		q: out std_logic_vector(3 downto 0);
		pulse: out std_logic);
	end component;
	
	signal p_n: std_logic_vector(0 to N):= (0 => '1',others => '0');
	signal tmp: std_logic_vector(0 to N);

	begin 
		tmp(0) <= p_n(0);
		for_gen: for i in 0 to N-1 generate
			gen: dec_counter
				port map (clk => clk, reset => reset, en => p_n(i), q => q_n(4*i to 4*i+3), pulse => p_n(i+1));
		end generate for_gen;
		
		p_gen: for j in 1 to N-1 generate
			tmp(j) <= p_n(j) and tmp(j-1);
		end generate p_gen;
		p <= tmp(N-1);
	end counter_arch;
		