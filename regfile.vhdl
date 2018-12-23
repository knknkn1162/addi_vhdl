library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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

  function init_ram return ram_type is
    variable tmp : ram_type(0 to 2**ADDR_WIDTH-1) := (others => (others => '0'));
  begin
    for addr_pos in 0 to 2**ADDR_WIDTH - 1 loop
      -- Initialize each address with the address itself
      tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 32));
    end loop;
    return tmp;
  end function;

  -- Declare the RAM signal and specify a default value. Quartus Prime
  -- will create a memory initialization file (.mif) based on the 
  -- default value.
  signal s_ram : ram_type(0 to 2**ADDR_WIDTH-1) := init_ram;
  signal CONST_ZERO : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
begin
  process(clk, i_we, i_wa, i_wd)
    variable idx : natural range 0 to 2**ADDR_WIDTH-1 := 0;
  begin
    if rising_edge(clk) then
      if i_we = '1' then
        idx := to_integer(unsigned(i_wa));
        if idx /= 0 then
          s_ram(idx) <= i_wd;
        end if;
      end if;
    end if;
  end process;
  o_rd <= s_ram(to_integer(unsigned(i_ra)));
end architecture;
