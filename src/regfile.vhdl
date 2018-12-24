library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- simple_dual_port_ram_single_clock
entity regfile is
  generic(ADDR_WIDTH: natural);
  port (
    clk, i_we : in std_logic;
    i_ra, i_wa : in std_logic_vector(ADDR_WIDTH-1 downto 0);
    i_wd : in std_logic_vector(31 downto 0);
    o_rd : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behavior of regfile is
  type ram_type is array(natural range<>) of std_logic_vector(31 downto 0);

  signal s_ram : ram_type(0 to 2**ADDR_WIDTH-1) := (others => (others => '0'));
begin
  process(clk, i_we, i_wa, i_wd)
  begin
    if rising_edge(clk) then
      if i_we = '1' then
        s_ram(to_integer(unsigned(i_wa))) <= i_wd;
      end if;
    end if;
  end process;
  -- register 0 hardwired to 0
  o_rd <= X"00000000" when to_integer(unsigned(i_ra)) = 0 else s_ram(to_integer(unsigned(i_ra)));
end architecture;
