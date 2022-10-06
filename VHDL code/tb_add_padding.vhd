library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
library work;
use work.my_package.all;


entity tb_add_padding is
end tb_add_padding;
    
architecture tb_add_padding_behavior of tb_add_padding is
		
	component add_padding is
		port(
			in_img : in img;
			out_img : out img_padding
		);
	end component;
	
	signal initial_image : img;
	signal output_image : img_padding;
	
	begin
		initial_image <= immagine;
		addpadd: add_padding port map(initial_image, out_img => output_image);

	process 
		variable my_line : line;    
		begin 
			wait for 20 ns;
			for i in 0 to c_img_dim12 - 1 + (c_mask_lenght - 1) loop
				for j in 0 to c_img_dim12 - 1 + (c_mask_lenght - 1) loop
					write(my_line, to_integer(unsigned(output_image(i,j))));
					write(my_line, string'("_"));
				end loop;
				writeline(output, my_line);
			end loop;
			wait;
	end process;
		
end tb_add_padding_behavior;
