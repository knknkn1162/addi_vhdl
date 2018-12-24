library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addi is
  generic(N : natural := 50000000);
  port (
    clk, rst : in std_logic;
    o_hex0 : out std_logic_vector(6 downto 0);
    o_hex1 : out std_logic_vector(6 downto 0);
    o_hex2 : out std_logic_vector(6 downto 0);
    o_hex3 : out std_logic_vector(6 downto 0);
    o_hex4 : out std_logic_vector(6 downto 0);
    o_hex5 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of addi is
  component enable_generator
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      o_ena : out std_logic
    );
  end component;

  component datapath
    generic(RAM_ADDR_WIDTH: natural);
    port (
      clk, rst, i_en : in std_logic;
      -- scan
      o_wa : out std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
      o_wd : out std_logic_vector(31 downto 0)
    );
  end component;

  component disp
    port (
      i_num : in std_logic_vector(23 downto 0);
      o_hex0 : out std_logic_vector(6 downto 0);
      o_hex1 : out std_logic_vector(6 downto 0);
      o_hex2 : out std_logic_vector(6 downto 0);
      o_hex3 : out std_logic_vector(6 downto 0);
      o_hex4 : out std_logic_vector(6 downto 0);
      o_hex5 : out std_logic_vector(6 downto 0)
    );
  end component;


  constant RAM_ADDR_WIDTH : natural := 5;
  signal s_wa : std_logic_vector(RAM_ADDR_WIDTH-1 downto 0);
  signal s_ena : std_logic;
  signal s_num : std_logic_vector(23 downto 0);
  signal s_wd : std_logic_vector(31 downto 0);

begin
  enable_generator0 : enable_generator generic map (N=>N)
  port map (
    clk => clk, rst => rst,
    o_ena => s_ena
  );

  datapath0 : datapath generic map(RAM_ADDR_WIDTH=>RAM_ADDR_WIDTH)
  port map (
    clk => clk, rst => rst, i_en => s_ena,
    o_wa => s_wa, o_wd => s_wd
  );

  -- Output pins are stuck at VCC or GND
  s_num(23 downto 16) <= "000" & s_wa;
  s_num(15 downto 0) <= s_wd(15 downto 0);

  disp0 : disp port map (
    i_num => s_num,
    o_hex0 => o_hex0,
    o_hex1 => o_hex1,
    o_hex2 => o_hex2,
    o_hex3 => o_hex3,
    o_hex4 => o_hex4,
    o_hex5 => o_hex5
  );
end architecture;
