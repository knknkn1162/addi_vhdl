library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity decoder is
  port (
    i_num : in std_logic_vector(3 downto 0);
    o_hex : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of decoder is
begin
  process(i_num)
  begin
    case (i_num) is
      when "0000" => o_hex <= "1000000";
      when "0001" => o_hex <= "1111001";
      when "0010" => o_hex <= "0100100";
      when "0011" => o_hex <= "0110000";
      when "0100" => o_hex <= "0011001";
      when "0101" => o_hex <= "0010010";
      when "0110" => o_hex <= "0000010";
      when "0111" => o_hex <= "1011000";
      when "1000" => o_hex <= "0000000";
      when "1001" => o_hex <= "0010000";
      when "1010" => o_hex <= "0001000";
      when "1011" => o_hex <= "0000011";
      when "1100" => o_hex <= "1000110";
      when "1101" => o_hex <= "0100001";
      when "1110" => o_hex <= "0000110";
      when "1111" => o_hex <= "0001110";
      when others => o_hex <= "1111111";
    end case;
  end process;
end architecture;
