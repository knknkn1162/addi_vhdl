library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity disp is
  port (
    i_num : in std_logic_vector(23 downto 0);
    o_hex0 : out std_logic_vector(6 downto 0);
    o_hex1 : out std_logic_vector(6 downto 0);
    o_hex2 : out std_logic_vector(6 downto 0);
    o_hex3 : out std_logic_vector(6 downto 0);
    o_hex4 : out std_logic_vector(6 downto 0);
    o_hex5 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of disp is
  component decoder
    port (
      i_num : in std_logic_vector(3 downto 0);
      o_hex : out std_logic_vector(6 downto 0)
    );
  end component;

  signal s_hex : std_logic_vector(41 downto 0);
begin
  gen_decoder : for i in 0 to 5 generate
    decoder0 : decoder port map (
      i_num => i_num(i*4+3 downto i*4),
      o_hex => s_hex(i*7+6 downto i*7)
    );
  end generate;

  o_hex0 <= s_hex(6 downto 0);
  o_hex1 <= s_hex(13 downto 7);
  o_hex2 <= s_hex(20 downto 14);
  o_hex3 <= s_hex(27 downto 21);
  o_hex4 <= s_hex(34 downto 28);
  o_hex5 <= s_hex(41 downto 35);
end architecture;
