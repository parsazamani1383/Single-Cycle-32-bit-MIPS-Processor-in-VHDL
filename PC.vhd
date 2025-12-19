library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    port(
        clk   : in  std_logic;
        reset : in  std_logic;
        pc_in : in  std_logic_vector(31 downto 0);
        pc_out: out std_logic_vector(31 downto 0)
    );
end pc;

architecture rtl of pc is
    signal pc_reg : std_logic_vector(31 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            pc_reg <= pc_in;
        end if;
    end process;

    pc_out <= pc_reg;
end rtl;
