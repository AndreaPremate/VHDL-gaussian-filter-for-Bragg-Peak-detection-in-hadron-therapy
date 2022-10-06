library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_convolution is
end tb_convolution;
    
architecture tb_convolution_behavior of tb_convolution is
		
	component convolution is port(
		clk,enable : in std_logic;
		in_mask_conv : in t_matrix;
		in_img_conv : in img;
		out_img_conv : out img
		);
	end component;

	signal clock_internal: std_logic;
	signal outputimg : img;
	
	begin 
	convolution_inst: convolution port map(clock_internal,'1', mask, immagine, outputimg ); 

	process begin 
		clock_internal <= '1'; wait for 10 ns;
		clock_internal <= '0'; wait for 10 ns;
 	end process;
	
end tb_convolution_behavior;
