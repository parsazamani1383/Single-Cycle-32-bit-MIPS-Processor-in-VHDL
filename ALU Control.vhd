library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu_control is
    port (
        alu_op : in  std_logic_vector(1 downto 0);
        funct  : in  std_logic_vector(5 downto 0);
        alu_c  : out std_logic_vector(3 downto 0)
    );
end;

architecture rtl of alu_control is
begin
    process(alu_op, funct)
    begin
        case alu_op is
            when "00" => alu_c <= "0010"; -- ADD
            when "01" => alu_c <= "0110"; -- SUB
            when "10" =>
                case funct is
                    when "100000" => alu_c <= "0010"; -- add
                    when "100010" => alu_c <= "0110"; -- sub
                    when "100100" => alu_c <= "0000"; -- and
                    when "100101" => alu_c <= "0001"; -- or
                    when "101010" => alu_c <= "0111"; -- slt
                    when others   => alu_c <= "0000";
                end case;
            when others => alu_c <= "0000";
        end case;
    end process;
end rtl;
