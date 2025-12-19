library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity cpu is
    port (
        clk   : in std_logic;
        reset : in std_logic
    );
end;

architecture rtl of cpu is
    signal RegDst, Jump, Branch, MemRead, MemToReg,
           MemWrite, ALUSrc, RegWrite : std_logic;
    signal ALUOp : std_logic_vector(1 downto 0);
    signal opcode: std_logic_vector(5 downto 0);
begin
    cu: entity work.control_unit
        port map(
            opcode, RegDst, Jump, Branch, MemRead,
            MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite
        );

    dp: entity work.datapath
        port map(
            clk, reset,
            RegDst, Jump, Branch, MemRead, MemToReg,
            MemWrite, ALUSrc, RegWrite,
            ALUOp, opcode
        );
end rtl;
