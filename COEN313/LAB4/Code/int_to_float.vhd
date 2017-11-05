library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity  int_to_float   is

port( fp : out std_logic_vector(7 downto 0);
      uf_out : out std_logic ; 		      -- underflow output
      int : in std_logic_vector(3 downto 0)); -- input value
end;


architecture arch of int_to_float is
begin
	
	process (int) begin
		uf_out <= '1';

		case int is 
		when "0000" =>
			uf_out <= '0';
			fp <= "11111111";
		when "0001" =>			
			fp <= "10110111";		
		when "0010" =>
			fp <= "10100111";
		when "0011" =>
			fp <= "10100011";
		when "0100" =>
			fp <= "10010111";
		when "0101" =>
			fp <= "10010101";
		when "0110" =>
			fp <= "10010011";
		when "0111" =>
			fp <= "10010001";
		when "1000" =>
			fp <= "00000111";
		when "1001" =>
			fp <= "00010001";
		when "1010" =>
			fp <= "00010011";
		when "1011" =>
			fp <= "00010101";
		when "1100" =>
			fp <= "00010111";
		when "1101" =>
			fp <= "00100011";
		when "1110" =>
			fp <= "00100111";
		when "1111" =>
			fp <= "00110111";
		when others =>
			fp <= "11111111";
			uf_out <= '0';

		end case;
	end process;

end arch;

