library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enable_generator_tb is
end entity;

architecture behavior of enable_generator_tb is
  component enable_generator is
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      o_ena : out std_logic
    );
  end component;

  constant N : natural := 3;
  signal clk, rst, s_ena : std_logic;
  constant CLK_PERIOD : time := 10 ns;
  signal s_stop : boolean;

begin
  uut : enable_generator generic map(N=>N) port map (
    clk => clk, rst => rst, o_ena => s_ena
  );

  clk_process: process
  begin
    while not s_stop loop
      clk <= '0'; wait for CLK_PERIOD/2;
      clk <= '1'; wait for CLK_PERIOD/2;
    end loop;
    wait;
  end process;

  stim_proc : process
  begin
    wait for CLK_PERIOD;
    rst <= '1'; wait until rising_edge(clk); wait for 1 ns; rst <= '0';
    assert s_ena = '0'; -- 0
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '0'; -- 1
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '1'; -- 2
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '0'; -- 0
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '0'; -- 1
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '1'; -- 2
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '0'; -- 0
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '0'; -- 1
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '1'; -- 2
    wait until rising_edge(clk); wait for 1 ns;
    assert s_ena = '0'; -- 0
    -- skip
    s_stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
