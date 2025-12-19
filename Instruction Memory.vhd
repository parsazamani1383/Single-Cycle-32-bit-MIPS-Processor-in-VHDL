library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity instr_mem is
    port (
        addr : in  std_logic_vector(31 downto 0);
        instr: out std_logic_vector(31 downto 0)
    );
end;

architecture rtl of instr_mem is
    type mem is array (0 to 255) of std_logic_vector(31 downto 0);
    signal rom : mem := (
        -- addi $t1, $zero, 100
        0 => x"20090064",
        -- lw $t0, 4($t1)
        1 => x"8D280004",
        others => (others => '0')
    );
begin
    instr <= rom(to_integer(unsigned(addr(9 downto 2))));
end rtl;
