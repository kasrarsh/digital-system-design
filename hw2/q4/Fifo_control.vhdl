library ieee;
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- use ieee.numeric_std.all;
-- use IEEE.STD_LOGIC_UNSIGNED.all;
entity Fifo_control is
    port (
             clk, reset : in std_logic;
             wr,rd      : in std_logic;
         full, empty    : out std_logic;
    w_address,r_address : out std_logic_vector (2 downto 0) );
end Fifo_control;

architecture struct of Fifo_control is
        signal reader_pointer : unsigned(3 downto 0);
        signal writer_pointer : unsigned(3 downto 0);
        -- signal reader_pointer : std_logic_vector(3 downto 0);
        -- signal writer_pointer : std_logic_vector(3 downto 0);
        signal full_fifo      : std_logic;
        signal empty_fifo     : std_logic;
    begin
        process(clk)
            begin
                if(reset = '1') then 
                        reader_pointer <= "0000";
                        writer_pointer <= "0000";
                        full_fifo      <= '0';
                        empty_fifo     <= '0';
                elsif(clk'event and clk ='1') then
                    if(wr = '1' and full_fifo = '1') then
                            full <= '1';
                    else
                            -- i don't know what todod
                            -- maybe send w_address
                            -- w_address <= std_logic_vector(writer_pointer(2 downto 0));
                            -- w_address <= writer_pointer(2 downto 0);
                    end if;
                    if(rd = '1' and empty_fifo = '1') then
                        empty <= '1';
                    else
                        -- i don't know what todod
                        -- maybe send r_address
                        -- r_address <= std_logic_vector(reader_pointer(2 downto 0));
                        -- r_address <= reader_pointer(2 downto 0);
                    end if;
                end if;
        end process;
        process(wr,rd)
            begin
                if(wr = '1')then
                    -- reader_pointer(0) = writer_pointer(0) & 
                    --     reader_pointer(1) = writer_pointer(1) & 
                    --     reader_pointer(2) = writer_pointer(2) & 
                    --     reader_pointer(3) /= writer_pointer(3) & 
                    if(reader_pointer(2 downto 0) = writer_pointer(2 downto 0))then
                            full_fifo <= '1';
                    elsif(writer_pointer = "1111") then
                        writer_pointer <= "0000";               
                    else
                        writer_pointer <= writer_pointer + 1;
                    end if;
                end if;
                if(rd = '1')then
                    if(reader_pointer = writer_pointer) then
                        empty_fifo <= '1';
                    elsif(reader_pointer = "1111") then
                        reader_pointer <= "0000";       
                    else
                        reader_pointer <= reader_pointer + 1;
                    end if;
                end if;
        end process;
end architecture;

