library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end tb;

architecture sim of tb is
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
begin

    -- Clock generation: 10 ns period
    clk <= not clk after 5 ns;

    -- CPU instance
    uut: entity work.cpu
        port map (
            clk   => clk,
            reset => reset
        );

    -- Stimulus process
    process
    begin
        -- Apply reset
        reset <= '1';
        wait for 20 ns;   -- 2 clock cycles
        reset <= '0';

        -- Let CPU run
        wait for 200 ns;

        -- End simulation cleanly
        assert false
            report "Simulation finished successfully"
            severity failure;
    end process;

end sim;
