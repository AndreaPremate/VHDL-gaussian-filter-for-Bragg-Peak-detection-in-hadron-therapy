library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_single_pixel_conv is
end tb_single_pixel_conv;
    
architecture tb_single_pixel_conv_behavior of tb_single_pixel_conv is
		
	component single_pixel_conv is
		port(
			in_mask : in t_matrix;
			in_img_square : t_matrix;
			out_conv_pixel : out std_logic_vector(c_bit_pixel_depth - 1 downto 0)
		);
	end component;

    signal data_matrix_in: t_matrix;
	signal clock_internal: std_logic;
	signal one: std_logic_vector(c_bit_pixel_depth - 1 downto 0) := (0 => '1', others=>'0');
	signal o_pixel: std_logic_vector(c_bit_pixel_depth - 1 downto 0);
	
	begin 
	single_pixel_conv_inst: single_pixel_conv port map(in_mask => mask, in_img_square => data_matrix_in, out_conv_pixel => o_pixel); 
	process 
		variable tmp: std_logic_vector(c_bit_pixel_depth - 1 downto 0);
		begin
			tmp := (others => '0');
			for ntest in 0 to 5 loop
				for i in 0 to c_mask_lenght-1 loop
					for j in 0 to c_mask_lenght-1 loop
						data_matrix_in(i,j) <=  tmp;
						tmp := std_logic_vector(unsigned(tmp) + unsigned(one));
					end loop;
				end loop;
				wait until rising_edge(clock_internal);
			end loop;
	end process;

	process begin 
		clock_internal <= '0'; wait for 10 ns;
	    clock_internal <= '1'; wait for 10 ns;
    end process;

end tb_single_pixel_conv_behavior;
