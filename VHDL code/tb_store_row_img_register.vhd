library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_store_row_img_register is
end tb_store_row_img_register;
    
architecture tb_store_row_img_register_behavior of tb_store_row_img_register is
		
	component row_conv is
		port(
			row_index : in integer := 0;
			in_mask_r : in t_matrix;
			in_pad_img : img_padding;
			out_conv_row : out row;
			o_row_index : out integer
		);
	end component;

	component store_row_img_register is
		port(
			clk:in std_logic;
			row_index : in integer := 0;
			in_row : in row;
			in_img : img;
			out_img : out img
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
	signal padded_img : img_padding;
	signal output : row;
	signal img_reg : img;
	signal indx_o : integer;
	
	begin 
	pad : add_padding port map(immagine, padded_img);
	row_conv_inst: row_conv port map(indx, mask, padded_img, output, indx_o ); 
	store_inst: store_row_img_register port map(clock_internal, indx_o,output,img_reg,img_reg); 

	process
		variable tmp: integer;
		begin
			tmp := 0;
			for ntest in 0 to 5 loop
				indx <= tmp;
				
				wait until rising_edge(clock_internal);
				tmp := tmp + 1;
			end loop;
	end process;

	process begin 
		clock_internal <= '1'; wait for 10 ns;
	    clock_internal <= '0'; wait for 10 ns;
    end process;

end tb_store_row_img_register_behavior;
