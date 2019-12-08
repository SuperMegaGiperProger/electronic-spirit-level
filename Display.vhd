----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:52 12/08/2019 
-- Design Name: 
-- Module Name:    DisplayViewer - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DisplayViewer is
   Port ( SYSCLK : in STD_LOGIC;
          NUM_L : in STD_LOGIC_VECTOR (11 downto 0);
          NUM_R : in STD_LOGIC_VECTOR (11 downto 0);
          Q : out STD_LOGIC_VECTOR (0 to 15));
end DisplayViewer;

architecture Behavioral of DisplayViewer is

	component DigitToCathodes
	port ( D : in integer;
	  	    CA : out STD_LOGIC_VECTOR(0 to 7));
	end component;
	
	component CLK_DIV
	generic (N: integer := 16);
	port (
		CLK: in STD_LOGIC;
		Q: out STD_LOGIC
	);
	end component;
	
	type digits_arr is array (0 to 3) of integer range 0 to 9;
	
	signal clk: std_logic := '0';
	signal disp_anode: std_logic_vector (0 to 7) := "11111111";
	signal disp_cathod: std_logic_vector (0 to 7) := "11111111";
	signal curr_digit: integer range 0 to 9 := 0;
	signal curr_digit_index: integer range 0 to 3 := 0;
	signal digits: digits_arr := (8, 7, 6, 5);

begin

	clk_div_proc: CLK_DIV port map (
		CLK => SYSCLK,
		Q => clk
	);

	convert_to_digits: process(NUM_R)
	variable x_int : integer range 0 to 2047;
	variable x_digits : digits_arr;
	begin
		x_int := to_integer(unsigned(NUM_R));

		for i in 0 to 3 loop
			x_digits(i) := x_int mod 10;
			
			x_int := x_int / 10;
		end loop;
		
		digits <= x_digits;
	end process;
	
	cathodes: DigitToCathodes port map (
		D => curr_digit,
		CA => disp_cathod
	);
	
	anodes: process(curr_digit_index, clk)
	begin
		if rising_edge(clk) then
			disp_anode <= (others => '1');
			disp_anode(curr_digit_index) <= '0';
		else
			disp_anode <= (others => '1');
		end if;
	end process;
	
	clk_proc: process(clk)
	variable next_index: integer range 0 to 3;
	begin
		if rising_edge(clk) then
			next_index := (curr_digit_index + 1) mod 4;
			
			curr_digit <= digits(next_index);
			curr_digit_index <= next_index;
		end if;
	end process;
	
	Q <= disp_anode & disp_cathod;

end Behavioral;

