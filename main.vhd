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
	
	-- display anodes and catodes
   DISPLAY    : out STD_LOGIC_VECTOR (0 to 15);
	
	-- diodes ports
	DIODE_X_R    : out STD_LOGIC;
	DIODE_X_G    : out STD_LOGIC;
	DIODE_Y_R    : out STD_LOGIC;
	DIODE_Y_G    : out STD_LOGIC;

   --SPI Interface Signals
   SCLK       : out STD_LOGIC;
   MOSI       : out STD_LOGIC;
   MISO       : in STD_LOGIC;
   SS         : out STD_LOGIC
);
end main;

architecture Behavioral of main is

	subtype axis is integer range 0 to 2047;

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
          NUM_L : in axis;
          NUM_R : in axis;
          Q : out STD_LOGIC_VECTOR (0 to 15));
	end component;
	
	component Indicator
	port ( Success : in STD_LOGIC;
	       R : out STD_LOGIC;
			 G : out STD_LOGIC );
	end component;


	function Deviation (A: axis) return axis is
	begin
		if A <= 1024 then
			return A;
		else
			return 2048 - A;
		end if;
	end;
	
	function isSuccess (DEV: axis) return std_logic is
	begin
		if DEV <= 30 then
			return '1';
		else
			return '0';
		end if;
	end;

	signal x_vec : std_logic_vector (11 downto 0);
	signal y_vec : std_logic_vector (11 downto 0);
	signal x : axis;
	signal y : axis;
	signal x_dev : axis;
	signal y_dev : axis;
	signal success_x : std_logic := '0';
	signal success_y : std_logic := '0';

begin

	accel: ADXL362Ctrl port map (
		SYSCLK => SYSCLK,
		RESET => RESET,
		ACCEL_X => x_vec,
		ACCEL_Y => y_vec,
		SCLK => SCLK,
		MOSI => MOSI,
		MISO => MISO,
		SS => SS
	);
	
	accel_converter: process (x_vec, y_vec)
	begin
		x <= to_integer(unsigned(x_vec));
		y <= to_integer(unsigned(y_vec));
	end process;
	
	deviation_calc: process (x, y)
	begin
		x_dev <= Deviation(x);
		y_dev <= Deviation(y);
	end process;
	
	displ: DisplayViewer port map (
		SYSCLK => SYSCLK,
		NUM_L => x_dev,
		NUM_R => y_dev,
		Q => DISPLAY
	);
	
	calc_success: process (x_dev, y_dev)
	begin
		success_x <= isSuccess(x_dev);
		success_y <= isSuccess(y_dev);
	end process;
	
	indicate_x: Indicator port map (
		Success => success_x,
		R => DIODE_X_R,
		G => DIODE_X_G
	);
		
	indicate_y: Indicator port map (
		Success => success_y,
		R => DIODE_Y_R,
		G => DIODE_Y_G
	);

end Behavioral;

