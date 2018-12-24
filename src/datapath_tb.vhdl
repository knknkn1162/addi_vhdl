library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_tb is
end entity;

architecture testbench of datapath_tb is
  component datapath
    generic(RAM_ADDR_WIDTH: natural);
    port (
      clk, rst, i_en : in std_logic;
      -- scan
      o_wa : out std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
      o_wd : out std_logic_vector(31 downto 0)
    );
  end component;

  constant RAM_ADDR_WIDTH : natural := 3;
  signal clk, rst : std_logic;
  signal s_en : std_logic;
  signal s_wa : std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
  signal s_wd : std_logic_vector(31 downto 0);
  constant CLK_PERIOD : time := 10 ns;
  signal s_stop : boolean;

begin
  uut : datapath generic map(RAM_ADDR_WIDTH=>RAM_ADDR_WIDTH)
  port map (
    clk => clk, rst => rst, i_en => s_en,
    o_wa => s_wa,
    o_wd => s_wd
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
    -- skip
    rst <= '1'; wait until rising_edge(clk); wait for 1 ns; rst <= '0';
    s_en <= '1';
    wait for 5 ns;
    assert s_wa = "001"; assert s_wd = X"00000008";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "010"; assert s_wd = X"00000010";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "011"; assert s_wd = X"00000018";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "100"; assert s_wd = X"00000020";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "101"; assert s_wd = X"00000028";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "110"; assert s_wd = X"00000030";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "111"; assert s_wd = X"00000038";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "000"; assert s_wd = X"00000040";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "001"; assert s_wd = X"00000008";
    wait until rising_edge(clk); wait for 5 ns;
    assert s_wa = "010"; assert s_wd = X"00000010";

    s_stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
