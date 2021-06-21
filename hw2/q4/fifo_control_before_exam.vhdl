library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.numeric_std.all;
-- use IEEE.STD_LOGIC_UNSIGNED.all;
entity fifo_control_before_exam is
    port (
             clk, reset : in std_logic;
             wr,rd      : in std_logic;
         full, empty    : out std_logic;
    w_address,r_address : out std_logic_vector (2 downto 0) );
end fifo_control_before_exam;

architecture arch of fifo_control_before_exam is
        signal read_r_reg : unsigned(3 downto 0 ) := "0000";
        signal read_r_next : unsigned(3 downto 0 ) := "0000";
        signal write_r_reg : unsigned(3 downto 0 ) := "0000";
        signal write_r_next : unsigned(3 downto 0 ) := "0000";
        signal empty_r_reg : std_logic;
        signal empty_r_next : std_logic;
        signal full_r_reg : std_logic;
        signal full_r_reg : std_logic;

    begin 
        process(clk,reset)
            begin 
                if(reset = '1') then
                    read_r_reg = "0000";
                    write_r_reg = "0000";
                    empty_r_reg = '0';
                    full_r_reg = '0';
                elsif(clk'event and clk='1') then
                    read_r_reg <= read_r_next;
                    write_r_reg <= write_r_next;
                    empty_r_reg <= empty_r_next;
                    full_r_reg <= full_r_next
                end if;
            end process;
        process(wr)
        begin
            if(wr = '1')then 
                if((read_r_reg(2 downto 0) = write_r_reg(2 downto 0)) and (read_r_reg(3) /= write_r_reg(3)))then
                    full_r_next <= '1';
                elsif(write_r_reg = "1111") then
                    write_r_next <= "0000";               
                else
                    write_r_next <= write_r_reg + 1;
                end if;
            end if;
        end process;

        process(rd)
        begin
            if(rd = '1')then
                if(read_r_reg = write_r_reg) then
                    empty_r_next <= '1';
                elsif(read_r_reg = "1111") then
                    read_r_next <= "0000";       
                else
                    read_r_next <= read_r_reg + 1;
                end if;
            end if;
        end process
        full <= full_r_reg
        empty <= empty_r_reg
        w_address <= std_logic_vector(write_r_reg(2 downto 0));
        r_address <= std_logic_vector(read_r_reg(2 downto 0));
   
end architecture;

