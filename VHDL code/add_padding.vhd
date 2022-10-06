library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;


entity add_padding is 
	port(
		in_img : in img;
		out_img : out img_padding
	);
end;

architecture add_padding_BEHAVIOR of add_padding is
	signal myzero: std_logic_vector(c_bit_pixel_depth -1 downto 0) := (others => '0');
	begin
		
		rows: for i in 0 to c_img_dim12 - 1 + (c_mask_lenght - 1) generate
			cols: for j in 0 to c_img_dim12 - 1 + (c_mask_lenght - 1) generate

				esterno : if (i < (c_mask_lenght - 1)/2 or i > c_img_dim12 - 1 + (c_mask_lenght - 1)/2 or
					j < (c_mask_lenght - 1)/2 or j > c_img_dim12 - 1 + (c_mask_lenght - 1)/2) generate
					out_img(i,j) <= myzero;
				end generate;

				interno : if (not(i < (c_mask_lenght - 1)/2 or i > c_img_dim12 - 1 + (c_mask_lenght - 1)/2 or
					j < (c_mask_lenght - 1)/2 or j > c_img_dim12 - 1 + (c_mask_lenght - 1)/2)) generate
					out_img(i,j) <= in_img(i - (c_mask_lenght - 1)/2, j - (c_mask_lenght - 1)/2);
				end generate;

			end generate;
		end generate;

end architecture add_padding_BEHAVIOR;
