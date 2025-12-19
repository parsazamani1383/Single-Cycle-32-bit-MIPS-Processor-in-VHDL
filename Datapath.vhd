library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity datapath is
    port (
        clk, reset : in std_logic;

        RegDst, Jump, Branch, MemRead, MemToReg,
        MemWrite, ALUSrc, RegWrite : in std_logic;
        ALUOp : in std_logic_vector(1 downto 0);

        opcode : out std_logic_vector(5 downto 0)
    );
end;

architecture rtl of datapath is
    signal pc, pc_next, pc_plus4 : std_logic_vector(31 downto 0);
    signal instr : std_logic_vector(31 downto 0);

    signal rd1, rd2, alu_b, alu_res, mem_data, wb_data : std_logic_vector(31 downto 0);
    signal sign_imm : std_logic_vector(31 downto 0);

    signal write_reg : std_logic_vector(4 downto 0);
    signal alu_ctrl  : std_logic_vector(3 downto 0);
    signal zero      : std_logic;
begin
    opcode <= instr(31 downto 26);

    -- PC
    pc_reg: entity work.pc
        port map(clk, reset, pc_next, pc);

    pc_plus4 <= std_logic_vector(unsigned(pc) + 4);

    -- Instruction memory
    im: entity work.instr_mem
        port map(pc, instr);

    -- Register file
    write_reg <= instr(15 downto 11) when RegDst='1' else instr(20 downto 16);

    rf: entity work.reg_file
        port map(
            clk, RegWrite,
            instr(25 downto 21), instr(20 downto 16),
            write_reg, wb_data,
            rd1, rd2
        );

    -- Sign extend
    sign_imm <= std_logic_vector(resize(signed(instr(15 downto 0)), 32));

    -- ALU control
    ac: entity work.alu_control
        port map(ALUOp, instr(5 downto 0), alu_ctrl);

    alu_b <= sign_imm when ALUSrc='1' else rd2;

    alu1: entity work.alu
        port map(rd1, alu_b, alu_ctrl, alu_res, zero);

    -- Data memory
    dm: entity work.data_mem
        port map(clk, alu_res, rd2, MemRead, MemWrite, mem_data);

    wb_data <= mem_data when MemToReg='1' else alu_res;

    -- Branch + Jump
    pc_next <= pc_plus4 when Jump='0' else
               pc_plus4(31 downto 28) & instr(25 downto 0) & "00";
end rtl;
