library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flopr_en_tb is
end entity;

architecture testbench of flopr_en_tb is
  component flopr_en
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      i_en: in std_logic;
      i_a : in std_logic_vector(N-1 downto 0);
      o_y : out std_logic_vector(N-1 downto 0)
    );
  end component;

  signal clk, rst, s_en : std_logic;
  signal N : natural := 32;
  signal s_a, s_y : std_logic_vector(N-1 downto 0);
  constant CLK_PERIOD : time := 10 ns;
  signal s_stop : boolean;

begin
  uut : flopr_en generic map(N=>N)
  port map (
    clk => clk, rst => rst, i_en => s_en,
    i_a => s_a, o_y => s_y
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
    rst <= '1'; wait for 1 ns; rst <= '0'; assert s_y = X"00000000";
    s_a <= X"00000001"; wait for CLK_PERIOD/2; assert s_y = X"00000000";
    s_en <= '1'; wait for CLK_PERIOD; assert s_y = X"00000001";
    -- skip
    s_stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
