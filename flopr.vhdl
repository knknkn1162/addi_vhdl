library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flopr is
  generic(N : natural);
  port (
    clk, rst: in std_logic;
    i_a : in std_logic_vector(N-1 downto 0);
    o_y : out std_logic_vector(N-1 downto 0)
  );
end entity;

architecture behavior of flopr is
begin
  process(clk, rst) begin
    if rising_edge(clk) then
      if rst = '1' then
        o_y <= (others => '0');
      else
        o_y <= i_a;
      end if;
    end if;
  end process;
end architecture;
