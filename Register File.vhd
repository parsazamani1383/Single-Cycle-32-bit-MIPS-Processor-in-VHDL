library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
    port (
        clk        : in  std_logic;
        we         : in  std_logic;
        ra1, ra2   : in  std_logic_vector(4 downto 0);
        wa         : in  std_logic_vector(4 downto 0);
        wd         : in  std_logic_vector(31 downto 0);
        rd1, rd2   : out std_logic_vector(31 downto 0)
    );
end;

architecture rtl of reg_file is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin
    rd1 <= regs(to_integer(unsigned(ra1)));
    rd2 <= regs(to_integer(unsigned(ra2)));

    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' and wa /= "00000" then
                regs(to_integer(unsigned(wa))) <= wd;
            end if;
        end if;
    end process;
end rtl;
