library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_conv_out_pixel is
end tb_conv_out_pixel;
    
architecture tb_conv_out_pixel_behavior of tb_conv_out_pixel is
		
	component conv_out_pixel is
		port(
			in_mat : in t_matrix_result;
			--pixel_out : out std_logic_vector(2*c_bit_pixel_depth + (c_mask_lenght*c_mask_lenght - 1) -1  downto 0)
			pixel_out : out std_logic_vector(2*c_bit_pixel_depth + max_value_conv - 1 downto 0)
		);
	end component;
	
	signal data_matrix_in: t_matrix_result;
	--signal o_pixel: std_logic_vector(2*c_bit_pixel_depth + (c_mask_lenght*c_mask_lenght - 1) -1  downto 0);
	signal o_pixel: std_logic_vector(2*c_bit_pixel_depth + max_value_conv - 1 downto 0);
	signal clock_internal: std_logic;
	signal one: std_logic_vector(2*c_bit_pixel_depth - 1 downto 0) := (0 => '1', others=>'0');
	
	begin
		conv_out_pixel_inst: conv_out_pixel port map(in_mat => data_matrix_in, pixel_out => o_pixel); 
		
  		process 
		variable tmp: std_logic_vector(2*c_bit_pixel_depth - 1 downto 0);
		begin
			tmp := (others => '0');
			for ntest in 0 to 10 loop
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

end tb_conv_out_pixel_behavior;
