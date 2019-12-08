----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:07 12/07/2019 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
port (
   SYSCLK     : in STD_LOGIC; -- System Clock
   RESET      : in STD_LOGIC;

   -- Accelerometer data signals
   DISPLAY    : out STD_LOGIC_VECTOR (0 to 15);

   --SPI Interface Signals
   SCLK       : out STD_LOGIC;
   MOSI       : out STD_LOGIC;
   MISO       : in STD_LOGIC;
   SS         : out STD_LOGIC
);
end main;

architecture Behavioral of main is

	component ADXL362Ctrl
	port ( SYSCLK     : in STD_LOGIC; -- System Clock
			 RESET      : in STD_LOGIC;
			-- Accelerometer data signals
		    ACCEL_X    : out STD_LOGIC_VECTOR (11 downto 0);
			 ACCEL_Y    : out STD_LOGIC_VECTOR (11 downto 0);
			--SPI Interface Signals
			 SCLK       : out STD_LOGIC;
			 MOSI       : out STD_LOGIC;
			 MISO       : in STD_LOGIC;
			 SS         : out STD_LOGIC);
	end component;
	
	component DisplayViewer
   port ( SYSCLK : in STD_LOGIC;
          NUM_L : in STD_LOGIC_VECTOR (11 downto 0);
          NUM_R : in STD_LOGIC_VECTOR (11 downto 0);
          Q : out STD_LOGIC_VECTOR (0 to 15));
	end component;

	signal x : std_logic_vector (11 downto 0);
	signal nil : std_logic;
	
begin

	accel: ADXL362Ctrl port map (
		SYSCLK => SYSCLK,
		RESET => RESET,
		ACCEL_X => x,
		Data_Ready => nil,
		SCLK => SCLK,
		MOSI => MOSI,
		MISO => MISO,
		SS => SS
	);
	
	displ: DisplayViewer port map (
		SYSCLK => SYSCLK,
		NUM_L => "000000000000",
		NUM_R => x,
		Q => DISPLAY
	);	

end Behavioral;

