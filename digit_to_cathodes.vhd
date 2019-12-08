----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:49 12/08/2019 
-- Design Name: 
-- Module Name:    DigitToCathodes - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DigitToCathodes is
    Port ( D : in integer range 0 to 9;
           CA : out STD_LOGIC_VECTOR(0 to 7));
end DigitToCathodes;

architecture Behavioral of DigitToCathodes is
signal ca_sig : std_logic_vector(0 to 6);
begin
	mapping: process(D)
	begin
		case D is
			when 0 => 
				ca_sig <= "0000001";
			when 1 => 
				ca_sig <= "1001111";
			when 2 => 
				ca_sig <= "0010010";
			when 3 => 
				ca_sig <= "0000110";
			when 4 => 
				ca_sig <= "1001100";
			when 5 => 
				ca_sig <= "0100100";
			when 6 => 
				ca_sig <= "0100000";
			when 7 => 
				ca_sig <= "0001111";
			when 8 => 
				ca_sig <= "0000000";
			when 9 => 
				ca_sig <= "0000100";
		end case;
	end process;
	
	CA <= '1' & ca_sig;
end Behavioral;

