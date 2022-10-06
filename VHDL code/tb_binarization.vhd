library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_binarization is
end tb_binarization;
    
architecture tb_binarization_behavior of tb_binarization is
		
	component binarization is 
	port(
		in_img : in img;
		threshold : in integer := 127;
		out_img : out img
	);
	end component;

	signal thrsld : integer := 100;
	signal imgbinar : img;
	
	begin 
	binarization_inst: binarization port map(immagine, thrsld, imgbinar); 
	
end tb_binarization_behavior;
