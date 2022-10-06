library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity bragg_peak is 

	port(
		in_img : in img;
		peak_value : out integer;
		i_index : out integer;
		j_index : out integer
	);
end;

architecture bragg_peak_BEHAVIOR of bragg_peak is
	begin
	process (in_img)
		variable ii,jj: integer;
		variable peak,tmp: integer;
		begin
			ii := 0;
			jj := 0;
			peak := 0;
			tmp := 0;
			for i in 0 to c_img_dim12 - 1 loop
				for j in 0 to c_img_dim12 - 1 loop
					tmp := to_integer(unsigned(in_img(i,j)));
					if (tmp > peak) then
						peak := tmp;
						ii := i;
						jj := j;
					end if;
				end loop;
			end loop;
			
			peak_value <= peak;
			i_index <= ii;
			j_index <= jj;
	end process;

end architecture bragg_peak_BEHAVIOR;
