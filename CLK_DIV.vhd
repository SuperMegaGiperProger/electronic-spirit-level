----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:29:42 12/08/2019 
-- Design Name: 
-- Module Name:    CLK_DIV - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLK_DIV is
	Generic (N: integer := 4);
	Port (
		CLK: in STD_LOGIC;
		Q: out STD_LOGIC
	);
end CLK_DIV;

architecture Behavioral of CLK_DIV is
signal counter: std_logic_vector(N-1 downto 0) := (others=>'0');
begin
	Main: process(CLK)
	begin
		if rising_edge(CLK) then
			counter <= std_logic_vector(unsigned(counter) + 1);
		end if;
	end process;
	
	Q <= counter(N-1);
end Behavioral;