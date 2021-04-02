library ieee;
use ieee.std_logic_1164.all;

entity shifter4 is
  port(
    s: in  std_logic_vector(1 downto 0);
    w: in  std_logic_vector(3 downto 0);
    y: out std_logic_vector(3 downto 0)
  );
end shifter4;

architecture sel_shift of shifter4 is
begin
  with s select
    y <= (w(3) & w(2) & w(1) & w(0)) when "00",
			(w(0) & w(3) & w(2) & w(1)) when "01",
			(w(1) & w(0) & w(3) & w(2)) when "10",
			(w(2) & w(1) & w(0) & w(3)) when others;
end sel_shift;
