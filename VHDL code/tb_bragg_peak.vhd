library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_bragg_peak is
end tb_bragg_peak;
    
architecture tb_bragg_peak_behavior of tb_bragg_peak is
		
	component bragg_peak is port(
		in_img : in img;
		peak_value : out integer;
		i_index : out integer;
		j_index : out integer
	);
	end component;

	signal pv : integer;
	signal i : integer;
	signal j : integer;
	
	begin 
	bragg_peak_inst: bragg_peak port map(immagine, pv,i,j ); 
	
end tb_bragg_peak_behavior;
