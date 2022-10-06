library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity complete_task is 
	port(
		clk,enable : in std_logic;
		in_img : in img;
		in_mask : in t_matrix;
		in_bin_threshold : in integer := 127;
		conv_img : out img;
		bin_conv_img : out img;
		bragg_peak_value : out integer;
		bragg_peak_i_index : out integer;
		bragg_peak_j_index : out integer;
		max_width_ellipsoid : out integer;
		max_height_ellipsoid : out integer
	);
end;

architecture complete_task_BEHAVIOR of complete_task is
	
	component convolution is port(
		clk,enable : in std_logic;
		in_mask_conv : in t_matrix;
		in_img_conv : in img;
		out_img_conv : out img
		);
	end component;
	
	component binarization is 
	port(
		in_img : in img;
		threshold : in integer := 127;
		out_img : out img
	);
	end component;

	component bragg_peak is port(
		in_img : in img;
		peak_value : out integer;
		i_index : out integer;
		j_index : out integer
	);
	end component;

		component extract_dimensions is 
	port(
		in_img : in img;
		max_width : out integer;
		max_height : out integer
	);
	end component;

	signal immagine_convolution : img;
	signal immagine_binarization : img;
	signal bp_peak_value : integer;
	signal bp_i_index : integer;
	signal bp_j_index : integer;
	signal ed_max_width : integer;
	signal ed_max_height : integer;

	begin 
	conv_inst : convolution port map(clk, enable, in_mask, in_img, immagine_convolution);
	conv_img <= immagine_convolution;
	binarization_inst : binarization port map(immagine_convolution, in_bin_threshold, immagine_binarization);
	bin_conv_img <= immagine_binarization;
	bragg_peak_inst : bragg_peak port map(immagine_convolution, bp_peak_value, bp_i_index, bp_j_index);
	bragg_peak_value <= bp_peak_value;
	bragg_peak_i_index <= bp_i_index;
	bragg_peak_j_index <= bp_j_index;
	extract_dimensions_inst : extract_dimensions port map(immagine_binarization, ed_max_width, ed_max_height);
	max_width_ellipsoid <= ed_max_width;
	max_height_ellipsoid <= ed_max_height;

end architecture complete_task_BEHAVIOR;
