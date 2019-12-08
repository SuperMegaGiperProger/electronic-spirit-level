----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:58:18 12/08/2019 
-- Design Name: 
-- Module Name:    Indicator - Behavioral 
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

entity Indicator is
    Port ( Success : in  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC);
end Indicator;

architecture Behavioral of Indicator is
begin
	R <= '1' when Success='0' else '0';
	G <= '1' when Success='1' else '0';
end Behavioral;