library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;


entity el_by_el_matrix_mult is 

	port(
		a_mat : in t_matrix;
		b_mat : in t_matrix;
		c_mat : out t_matrix_result
	);
end;

architecture el_by_el_matrix_mult_BEHAVIOR of el_by_el_matrix_mult is
	component n_bit_multiplier is 
		generic ( 
			Nb : integer 
		);
		port(
			a, b : in std_logic_vector(Nb - 1 downto 0);
			c : out std_logic_vector(2*Nb -1  downto 0)
		);
	end component;


	begin						
		rows: for i in 0 to c_mask_lenght-1 generate
			cols: for j in 0 to c_mask_lenght-1 generate
				comp: n_bit_multiplier 
					generic map(Nb => c_bit_pixel_depth)
					port map(a_mat(i,j), b_mat(i,j), c_mat(i,j));
				end generate;
		end generate;

end architecture el_by_el_matrix_mult_BEHAVIOR;
