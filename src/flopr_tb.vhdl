library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flopr_tb is
end entity;

architecture behavior of flopr_tb is
  component flopr
    generic(N : natural := 32);
    port (
      clk, rst: in std_logic;
      i_a : in std_logic_vector(N-1 downto 0);
      o_y : out std_logic_vector(N-1 downto 0)
  );
  end component;

  constant N : natural := 32;
  signal clk : std_logic;
  signal rst : std_logic;
  signal s_a : std_logic_vector(N-1 downto 0);
  signal s_y : std_logic_vector(N-1 downto 0);
  constant CLK_PERIOD : time := 10 ns;
  signal s_stop : boolean;

begin
  uut : flopr port map (
    clk => clk,
    rst => rst,
    i_a => s_a,
    o_y => s_y
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
    rst <= '1'; wait until rising_edge(clk); wait for 1 ns; rst <= '0';
    wait for 1 ns; assert s_y = X"00000000";
    s_a <= X"00000001";
    wait until rising_edge(clk); wait for 1 ns;
    assert s_y = X"00000001";
    s_a <= X"00000002";
    wait until rising_edge(clk); wait for 1 ns;
    assert s_y = X"00000002";
    s_stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;

end architecture;
