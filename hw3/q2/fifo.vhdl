library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
    generic(
        address_width : integer :=2;
        data_width : integer := 8
    );
    port(
        clk,reset : in std_logic;
        w_data : in std_logic_vector(data_width-1  downto 0);
        wr,rd       : in std_logic;
        r_data : out std_logic_vector(data_width-1 downto 0)
        full, empty : out std_logic
    );
end fifo;

architecture rtl of fifo is
    signal w_address : std_logic_vector(address_width-1 downto 0);
    signal r_address : std_logic_vector(address_width-1 downto 0);
    signal full_storage : std_logic ;
    begin
        controller : entity work.fifo_controller(rtl)
        generic map(address_width => address_width)
        port map(
            wr    => wr,
            rd    => rd,
            full  => full_storage,
            empty => empty,
            w_address => w_address,
            r_address => r_address,
            clk => clk,
            reset => reset
        );

        buffer_storage : entity work.fifo_buffer(rtl)
        generic map(
            data_width => data_width,
            address_width => address_width
        )
        port map(
            wr_en => full_storage and wr,
            w_address => w_address,
            r_address => r_address,
            w_data => w_data,
            r_data => r_data,
            clk => clk,
            reset => reset        
        );
end architecture;