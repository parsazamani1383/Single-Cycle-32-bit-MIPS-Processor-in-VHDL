library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity data_mem is
    port (
        clk      : in  std_logic;
        addr     : in  std_logic_vector(31 downto 0);
        wd       : in  std_logic_vector(31 downto 0);
        MemRead  : in  std_logic;
        MemWrite : in  std_logic;
        rd       : out std_logic_vector(31 downto 0)
    );
end;

architecture rtl of data_mem is
    type mem is array (0 to 255) of std_logic_vector(31 downto 0);
    signal ram : mem := (
        26 => x"0000002A", -- address = 104 → 42
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                ram(to_integer(unsigned(addr(9 downto 2)))) <= wd;
            end if;
        end if;
    end process;

    rd <= ram(to_integer(unsigned(addr(9 downto 2)))) when MemRead = '1'
          else (others => '0');
end rtl;
