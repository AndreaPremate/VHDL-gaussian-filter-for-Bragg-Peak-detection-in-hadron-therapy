library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_row_conv is
end tb_row_conv;
    
architecture tb_row_conv_behavior of tb_row_conv is
		
	component row_conv is
		port(
			row_index : in integer := 0;
			in_mask_r : in t_matrix;
			in_pad_img : img_padding;
			out_conv_row : out row;
			o_row_index : out integer
		);
	end component;

	component add_padding is 
	port(
		in_img : in img;
		out_img : out img_padding
		);
	end component;

	signal clock_internal: std_logic;
	signal indx : integer :=0;
	signal indx_out : integer;
	signal padded_img : img_padding;
	signal output : row;
	begin 
	
	pad : add_padding port map(immagine, padded_img);
	row_conv_inst: row_conv port map(indx, mask, padded_img, output,indx_out ); 

	process
		variable tmp: integer;
		begin
			for ntest in 0 to 5 loop
				indx <= ntest;
				wait until rising_edge(clock_internal);
			end loop;
	end process;

	process begin 
		clock_internal <= '0'; wait for 10 ns;
	    clock_internal <= '1'; wait for 10 ns;
    end process;

end tb_row_conv_behavior;
