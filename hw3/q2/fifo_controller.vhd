library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.numeric_std.all;
-- use IEEE.STD_LOGIC_UNSIGNED.all;
entity fifo_controller is
    generic(
        address_width : integer:= 2
    );
    port (
        clk, reset  : in std_logic;
        wr,rd       : in std_logic;
        full, empty : out std_logic;
        w_address,r_address : out std_logic_vector (address_width-1 downto 0) );
end fifo_controller;

architecture rtl of fifo_controller is
        signal reader_pointer : unsigned(address_width downto 0) := "000";
        signal writer_pointer : unsigned(address_width downto 0) := "000";
        -- signal reader_pointer : std_logic_vector(3 downto 0);
        -- signal writer_pointer : std_logic_vector(3 downto 0);
        signal full_fifo      : std_logic;
        signal empty_fifo     : std_logic;

        
    begin 
       process(wr,clk,reset)
            begin
                if(reset = '1') then 
                        -- reader_pointer <= "0000";
                        writer_pointer <= (others => '0');
                        full_fifo      <= '0';
                        -- empty_fifo     <= '0';
                elsif(clk'event and clk ='1') then
                    if(wr = '1')then 
                            if((reader_pointer(1 downto 0) = writer_pointer(1 downto 0)) and (reader_pointer(2) /= writer_pointer(2)))then
                                    full_fifo <= '1';
                            elsif(writer_pointer = "111") then
                                writer_pointer <= "000";               
                            else
                                writer_pointer <= writer_pointer + 1;
                            end if;
                            if(full_fifo = '1') then
                                full <= '1';
                            else
                                -- i don't know what todod
                                -- maybe send w_address
                                w_address <= std_logic_vector(writer_pointer(address_width-1 downto 0));
                                -- w_address <= writer_pointer(2 downto 0);
                            end if;
                        end if;
                    end if;
            end process;

        process(rd,clk,reset)
            begin
                if(reset = '1') then 
                reader_pointer <= "000";
                -- writer_pointer <= "0000";
                -- full_fifo      <= '0';
                empty_fifo     <= '0';
                elsif(clk'event and clk ='1') then
                    if(rd = '1') then 
                        if(reader_pointer = writer_pointer) then
                            empty_fifo <= '1';
                        elsif(reader_pointer = "111") then
                            reader_pointer <= "000";       
                    else
                        reader_pointer <= reader_pointer + 1;
                    end if;
                    if(empty_fifo = '1') then
                        empty <= '1';
                    else
                        -- i don't know what todod
                        -- maybe send r_address
                        r_address <= std_logic_vector(reader_pointer(address_width-1 downto 0));
                        -- r_address <= reader_pointer(2 downto 0);
                    end if;
                end if;
            end if;
        end process;
    
          
           
end architecture;

