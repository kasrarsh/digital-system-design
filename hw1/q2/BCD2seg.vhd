library ieee;
use ieee.std_logic_1164.all;

entity BCD2seg is 
	port(
		w: in std_logic_vector(3 downto 0);
		seg: out std_logic_vector(6 downto 0));
	end BCD2seg;
	
architecture decoder_arch of BCD2seg is 
	begin
		process(w)
		begin
		case w is
			when "0000" => 
				seg <= "1111110";
			when "0001" => 
				seg <= "0110000";
			when "0010" => 
				seg <= "1101101";
			when "0011" => 
				seg <= "1111001";
			when "0100" => 
				seg <= "0110011";
			when "0101" => 
				seg <= "1011011";
			when "0110" => 
				seg <= "1011111";
			when "0111" => 
				seg <= "1110000";
			when "1000" => 
				seg <= "1111111";
			when "1001" => 
				seg <= "1111011";
			when "1010" => 
				seg <= "1111101";
			when "1011" => 
				seg <= "0011111";
			when "1100" => 
				seg <= "1001110";
			when "1101" => 
				seg <= "0111101";
			when "1110" => 
				seg <= "1001111";
			when others => 
				seg <= "1000111";
		end case;
		end process;
	end decoder_arch;