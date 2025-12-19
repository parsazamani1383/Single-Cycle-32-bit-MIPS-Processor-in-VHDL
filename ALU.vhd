library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port (
        a, b  : in  std_logic_vector(31 downto 0);
        alu_c : in  std_logic_vector(3 downto 0);
        res   : out std_logic_vector(31 downto 0);
        zero  : out std_logic
    );
end alu;

architecture rtl of alu is
    signal r : signed(31 downto 0);
begin
    process(a, b, alu_c)
    begin
        case alu_c is
            when "0010" => r <= signed(a) + signed(b); -- ADD
            when "0110" => r <= signed(a) - signed(b); -- SUB
            when "0000" => r <= signed(a) and signed(b);
            when "0001" => r <= signed(a) or  signed(b);
            when "0111" => 
                if signed(a) < signed(b) then
                    r <= (others => '1');
                else
                    r <= (others => '0');
                end if;
            when others => r <= (others => '0');
        end case;
    end process;

    res  <= std_logic_vector(r);
    zero <= '1' when r = 0 else '0';
end rtl;
