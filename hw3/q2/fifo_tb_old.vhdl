library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_tb is
end entity;

architecture sim of fifo_tb is
    constant address_width: integer := 2;
    constant data_width: integer := 8;

    signal wr : std_logic := '0';
    signal rd : std_logic := '0';
    signal full: std_logic := '0';
    signal empty : std_logic := '1';
    signal w_address,r_address : std_logic_vector(address_width-1 downto 0) := (others => '0');
    signal w_data : std_logic_vector(data_width-1 downto 0) := (others => '0');
    signal r_data : std_logic_vector(data_width-1 downto 0);
    signal clk : std_logic := '1';
    signal reset : std_logic := '1';

    begin
        uut : entity work.fifo_controller(rtl)
        generic map(address_width => address_width)
        port map(
            wr    => wr,
            rd    => rd,
            full  => full,
            empty => empty,
            w_address => w_address,
            r_address => r_address,
            clk => clk,
            reset => reset
        );

        uut : entity work.fifo_buffer(rtl)
        generic map(
            data_width => data_width,
            address_width => address_width
        )
        port map(
            wr_en => full and wr,
            w_address => w_address,
            r_address => r_address,
            w_data => w_data,
            r_data => r_data,
            clk => clk,
            reset => reset        
        );
        -- clock and data process
        process is 
        begin
            wait for 20 ns ;
            clk <= '0';
            w_data <=  "00000001" ;
            wait for 20 ns;
            clk <= '1';
            w_data <=  "00000001" ;

        end process;
        
        --res
        process is 
        begin 
            reset <= '1';
            wait for 8 * 20 ns;
        end process;

        process is 
        begin
              wait for 20 ns;
              wr <= '1';
              rd <= '0';
              wait for 20 ns;
              wr <= '0';
              rd <= '1'; 
        end process;


end architecture;