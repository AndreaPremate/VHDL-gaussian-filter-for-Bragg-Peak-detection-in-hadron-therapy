library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.my_package.all;

entity tb_el_by_el_matrix_mult is
end tb_el_by_el_matrix_mult;
    
architecture tb_el_by_el_matrix_mult_behavior of tb_el_by_el_matrix_mult is
		
	component el_by_el_matrix_mult is
		port(
			a_mat : in t_matrix;
			b_mat : in t_matrix;
			c_mat : out t_matrix_result
		);
	end component;
	
	component counter is
		generic ( Nb : integer) ;
		port( 
			T           :in std_logic;
			clk         :in std_logic; 
			OUT_COUNT   :out std_logic_vector(Nb-1 downto 0)
		);
	end component;
    
	signal data_matrix1, data_matrix2: t_matrix;
	signal out_matrix: t_matrix_result;

	signal datatot: std_logic_vector(c_bit_pixel_depth-1 downto 0);
	signal clock_internal: std_logic;
	
	begin
		counter_inst: counter generic map (Nb => c_bit_pixel_depth) port map('1', clock_internal, datatot);
		el_by_el_matrix_mult_inst: el_by_el_matrix_mult port map(a_mat => data_matrix1, b_mat => data_matrix2, c_mat => out_matrix);   
	
   	 	process begin
			for i in 0 to c_mask_lenght-1 loop
				for j in 0 to c_mask_lenght-1 loop
					data_matrix1(i,j) <=  datatot;
					data_matrix2(i,j) <=  datatot;
				end loop;
			end loop;

			clock_internal <= '0'; wait for 10 ns;
	    	clock_internal <= '1'; wait for 10 ns;
    	end process;

end tb_el_by_el_matrix_mult_behavior;