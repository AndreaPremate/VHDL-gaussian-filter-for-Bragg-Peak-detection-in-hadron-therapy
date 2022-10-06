library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity convolution is 
	port(
		clk,enable : in std_logic;
		in_mask_conv : in t_matrix;
		in_img_conv : in img ;
		out_img_conv : out img :=  (others => (others => (others => '0')))
	);
end;

architecture convolution_BEHAVIOR of convolution is
	
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

	signal indx : integer :=0;
	signal padded_img : img_padding;
	signal output : row;
	signal img_reg : img;
	signal indx_o : integer;
	
	begin
	pad : add_padding port map(in_img_conv, padded_img);
	row_conv_inst: row_conv port map(indx, in_mask_conv, padded_img, output, indx_o ); 
	store_inst: store_row_img_register port map(clk, indx_o,output,img_reg,img_reg); 

   	process(clk)
    	variable count: integer := 0;
   	begin
		if clk'event and clk='1' then
       		if enable='1' or count > 0 then		-- enable abilita l'intera immagine
           		if count < c_img_dim12 then 
					count := count + 1;
                else 
                	count := 0;
					out_img_conv <= img_reg;
                end if;
    		else count := count;
        	end if; 
      	end if;
		if count < c_img_dim12 then
			indx <= count;
		end if;      

 	end process;

end architecture convolution_BEHAVIOR;
