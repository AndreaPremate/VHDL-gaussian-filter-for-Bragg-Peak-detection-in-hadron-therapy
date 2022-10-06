library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;


entity conv_out_pixel is 
	port(
		in_mat : in t_matrix_result;
		--pixel_out : out std_logic_vector(2*c_bit_pixel_depth + (c_mask_lenght*c_mask_lenght - 1) -1  downto 0)
		pixel_out : out std_logic_vector(2*c_bit_pixel_depth + max_value_conv - 1 downto 0)
	);
end;

architecture conv_out_pixel_BEHAVIOR of conv_out_pixel is
	begin 
	process (in_mat)
	--variable tmp2: std_logic_vector(2*c_bit_pixel_depth + (c_mask_lenght*c_mask_lenght - 1) -1 downto 0);
	variable tmp2: std_logic_vector(2*c_bit_pixel_depth + max_value_conv - 1 downto 0);
	begin
		tmp2 := (others => '0');
		rows: for i in 0 to c_mask_lenght-1 loop
			cols: for j in 0 to c_mask_lenght-1 loop
				tmp2 := std_logic_vector(unsigned(in_mat(i,j)) + unsigned(tmp2));
			end loop cols;
		end loop rows;
		tmp2 := std_logic_vector(unsigned(tmp2) / c_mask_elem_sum);		-- !! dipende dalla sum della maschera definito in my_package !!
		pixel_out <= tmp2;
	end process;

end architecture conv_out_pixel_BEHAVIOR;
