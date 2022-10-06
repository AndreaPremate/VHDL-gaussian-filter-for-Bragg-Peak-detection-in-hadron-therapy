library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity tb_extract_dimensions is
end tb_extract_dimensions;
    
architecture tb_extract_dimensions_behavior of tb_extract_dimensions is
		
	component extract_dimensions is 
	port(
		in_img : in img;
		max_width : out integer;
		max_height : out integer
	);
	end component;

	component binarization is 
	port(
		in_img : in img;
		threshold : integer := 127;
		out_img : out img
	);
	end component;

	signal max_w : integer;
	signal max_h : integer;
	signal thrsld : integer := 100;
	signal imgbinar : img;
	
	begin 
	binarization_inst: binarization port map(immagine, thrsld, imgbinar); 
	extract_dimensions_inst: extract_dimensions port map(imgbinar, max_w, max_h); 

end tb_extract_dimensions_behavior;
