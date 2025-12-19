library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity control_unit is
    port (
        opcode    : in  std_logic_vector(5 downto 0);
        RegDst    : out std_logic;
        Jump      : out std_logic;
        Branch    : out std_logic;
        MemRead   : out std_logic;
        MemToReg  : out std_logic;
        ALUOp     : out std_logic_vector(1 downto 0);
        MemWrite  : out std_logic;
        ALUSrc    : out std_logic;
        RegWrite  : out std_logic
    );
end;

architecture rtl of control_unit is
begin
    process(opcode)
    begin
        case opcode is
            when "000000" => -- R-type
                RegDst   <= '1';
                ALUSrc   <= '0';
                MemToReg <= '0';
                RegWrite <= '1';
                MemRead  <= '0';
                MemWrite <= '0';
                Branch   <= '0';
                Jump     <= '0';
                ALUOp    <= "10";

            when "100011" => -- lw
                RegDst   <= '0';
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                MemRead  <= '1';
                MemWrite <= '0';
                Branch   <= '0';
                Jump     <= '0';
                ALUOp    <= "00";

            when "101011" => -- sw
                RegDst   <= '0';
                ALUSrc   <= '1';
                MemToReg <= '0';
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '1';
                Branch   <= '0';
                Jump     <= '0';
                ALUOp    <= "00";

            when "000100" => -- beq
                RegDst   <= '0';
                ALUSrc   <= '0';
                MemToReg <= '0';
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                Branch   <= '1';
                Jump     <= '0';
                ALUOp    <= "01";

            when "001000" => -- addi
                RegDst   <= '0';
                ALUSrc   <= '1';
                MemToReg <= '0';
                RegWrite <= '1';
                MemRead  <= '0';
                MemWrite <= '0';
                Branch   <= '0';
                Jump     <= '0';
                ALUOp    <= "00";

            when "000010" => -- j
                RegDst   <= '0';
                ALUSrc   <= '0';
                MemToReg <= '0';
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                Branch   <= '0';
                Jump     <= '1';
                ALUOp    <= "00";

            when others =>
                RegDst   <= '0';
                ALUSrc   <= '0';
                MemToReg <= '0';
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                Branch   <= '0';
                Jump     <= '0';
                ALUOp    <= "00";
        end case;
    end process;
end rtl;
