library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;


entity single_pixel_conv is 

	port(
		in_mask : in t_matrix;
		in_img_square : t_matrix;
		out_conv_pixel : out std_logic_vector(c_bit_pixel_depth - 1 downto 0)
	);
end;

architecture single_pixel_conv_BEHAVIOR of single_pixel_conv is

	component el_by_el_matrix_mult is
		port( 
			a_mat : in t_matrix;
			b_mat : in t_matrix;
			c_mat : out t_matrix_result
		);
	end component;

	component conv_out_pixel is
		port( 
			in_mat : in t_matrix_result;
			--pixel_out : out std_logic_vector(2*c_bit_pixel_depth + (c_mask_lenght*c_mask_lenght - 1) -1  downto 0)
			pixel_out : out std_logic_vector(2*c_bit_pixel_depth + max_value_conv - 1 downto 0)
		);
	end component;
	
	--signal output : std_logic_vector(2*c_bit_pixel_depth + (c_mask_lenght*c_mask_lenght - 1) -1  downto 0);
	signal output : std_logic_vector(2*c_bit_pixel_depth + max_value_conv - 1 downto 0);
	signal mult_mat : t_matrix_result;
	begin 
		comp1: el_by_el_matrix_mult port map(in_mask, in_img_square, mult_mat);
		comp2: conv_out_pixel port map(mult_mat, output);
		out_conv_pixel <= output(c_bit_pixel_depth - 1 downto 0);

end architecture single_pixel_conv_BEHAVIOR;
