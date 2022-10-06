library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;


entity row_conv is 
	port(
		row_index : in integer := 0;
		in_mask_r : in t_matrix;
		in_pad_img : in img_padding;
		out_conv_row : out row;
		o_row_index : out integer := 0
	);
end;

architecture row_conv_BEHAVIOR of row_conv is

	component single_pixel_conv is
		port(
		in_mask : in t_matrix;
		in_img_square : t_matrix;
		out_conv_pixel : out std_logic_vector(c_bit_pixel_depth - 1 downto 0)
	);
	end component;
	signal tmp_matrix_arr : t_matrix_array;
	
	begin 
		lab:for col_index in 0 to c_img_dim12 - 1 generate
			tmp_matrix_arr(col_index) <= extract_matrix_ij(in_pad_img, row_index , col_index);
   			comp1: single_pixel_conv port map(mask, tmp_matrix_arr(col_index), out_conv_row(col_index));
		end generate;
	
	o_row_index <= row_index; 
	
end architecture row_conv_BEHAVIOR;
