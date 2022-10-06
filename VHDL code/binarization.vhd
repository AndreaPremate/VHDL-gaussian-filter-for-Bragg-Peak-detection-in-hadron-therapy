library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity binarization is 
	port(
		in_img : in img;
		threshold : in integer := 127;
		out_img : out img
	);
end;

architecture binarization_BEHAVIOR of binarization is
	begin
	process (in_img)
		variable tmp: integer;
		variable maxValue: std_logic_vector(c_bit_pixel_depth-1 downto 0);
		variable minValue: std_logic_vector(c_bit_pixel_depth-1 downto 0);
		begin
			tmp := 0;
			maxValue := (others=>'1');
			minValue := (others=>'0');
			for i in 0 to c_img_dim12 - 1 loop
				for j in 0 to c_img_dim12 - 1 loop
					tmp := to_integer(unsigned(in_img(i,j)));
					if (tmp > threshold) then
						out_img(i,j) <= maxValue;
					else
						out_img(i,j) <= minValue;
					end if;
				end loop;
			end loop;
	end process;

end architecture binarization_BEHAVIOR;
