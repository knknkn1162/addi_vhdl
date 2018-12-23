library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regfile_tb is
end entity;

architecture testbench of regfile_tb is
  component regfile
    generic(ADDR_WIDTH: natural);
    port (
      clk, i_we : in std_logic;
      i_ra, i_wa : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      i_wd : in std_logic_vector(31 downto 0);
      o_rd : out std_logic_vector(31 downto 0)
    );
  end component;

  constant ADDR_WIDTH : natural := 5;
  signal clk, s_we : std_logic;
  signal s_ra, s_wa : std_logic_vector(ADDR_WIDTH-1 downto 0);
  signal s_wd, s_rd : std_logic_vector(31 downto 0);
  constant CLK_PERIOD : time := 10 ns;
  signal s_stop : boolean;

begin
  uut : regfile generic map(ADDR_WIDTH=>ADDR_WIDTH)
  port map (
    clk => clk, i_we => s_we,
    i_ra => s_ra, i_wa => s_wa,
    i_wd => s_wd,
    o_rd => s_rd
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
    s_wa <= "00010"; s_wd <= X"0000000F"; s_we <= '1';
    wait until rising_edge(clk); wait for 1 ns;
    s_ra <= "00010"; wait for 1 ns; assert s_rd = X"0000000F";

    -- $0 is exceptional register value that is always the value of 0.
    s_wa <= "00000"; s_wd <= X"0000000E";
    wait until rising_edge(clk); wait for 1 ns;
    s_ra <= "00000"; wait for 1 ns; assert s_rd = X"00000000";

    s_stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
