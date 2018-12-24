library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity enable_generator is
  generic(N : natural);
  port (
    clk, rst : in std_logic;
    o_ena : out std_logic
  );
end entity;

architecture behavior of enable_generator is
  component flopr
    generic(N : natural);
    port (
      clk, rst: in std_logic;
      i_a : in std_logic_vector(N-1 downto 0);
      o_y : out std_logic_vector(N-1 downto 0)
  );

  end component;
  constant MAX : natural := 26;
  constant CONST_N_VEC : std_logic_vector(MAX-1 downto 0) := std_logic_vector(to_unsigned(N-1, MAX));
  constant ZERO : std_logic_vector(MAX-1 downto 0) := (others => '0');
  signal s_anxt, s_a : std_logic_vector(MAX-1 downto 0);

begin
  flopr0 : flopr generic map(N=>MAX)
  port map (
    clk => clk, rst => rst,
    i_a => s_anxt,
    o_y => s_a
  );
  o_ena <= '1' when s_a = CONST_N_VEC else '0';
  s_anxt <= ZERO when s_a = CONST_N_VEC else std_logic_vector(unsigned(s_a) + 1);
end architecture;
