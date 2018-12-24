library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
  generic(RAM_ADDR_WIDTH: natural);
  port (
    clk, rst, i_en : in std_logic;
    -- scan
    o_wa : out std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
    o_wd : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behavior of datapath is
  component flopr_en
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      i_en: in std_logic;
      i_a : in std_logic_vector(N-1 downto 0);
      o_y : out std_logic_vector(N-1 downto 0)
    );
  end component;

  component regfile
    generic(ADDR_WIDTH: natural);
    port (
      clk, i_we : in std_logic;
      i_ra, i_wa : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      i_wd : in std_logic_vector(31 downto 0);
      o_rd : out std_logic_vector(31 downto 0)
    );
  end component;

  signal s_addr0, s_addr_next : std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
  signal s_regrd0 : std_logic_vector(31 downto 0);
  signal s_aluout0, s_wd : std_logic_vector(31 downto 0);
  signal s_wa : std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
begin

  -- scan
  o_wa <= s_wa; o_wd <= s_wd;

  flopr_addr : flopr_en generic map(N=>RAM_ADDR_WIDTH)
  port map (
    clk => clk, rst => rst, i_en => i_en,
    i_a => s_addr_next,
    o_y => s_addr0
  );

  s_addr_next <= std_logic_vector(unsigned(s_addr0) + 1);

  regfile0 : regfile generic map(ADDR_WIDTH=>RAM_ADDR_WIDTH)
  port map (
    clk => clk, i_we => '1',
    i_ra => s_addr0,
    i_wa => s_wa,
    i_wd => s_wd,
    o_rd => s_regrd0
  );
  s_aluout0 <= std_logic_vector(unsigned(s_regrd0) + 8);
  s_wa <= std_logic_vector(unsigned(s_addr0) + 1);
  s_wd <= s_aluout0;
end architecture;
