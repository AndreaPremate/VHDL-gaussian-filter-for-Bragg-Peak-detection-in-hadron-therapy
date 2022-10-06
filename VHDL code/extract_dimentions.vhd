library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;

entity extract_dimensions is 
	port(
		in_img : in img;
		max_width : out integer;
		max_height : out integer
	);
end;

architecture extract_dimensions_BEHAVIOR of extract_dimensions is
	begin
	process (in_img)
		variable tmp_w: integer;
		variable max_w: integer;
		variable tmp_h: integer;
		variable max_h: integer;

		variable tmp_tmp_w : integer;
		variable tmp_tmp_h : integer;

		
		variable maxValue: std_logic_vector(c_bit_pixel_depth-1 downto 0);
		begin
			max_w := 0;
			tmp_w := 0;
			max_h := 0;
			tmp_h := 0;

			tmp_tmp_w := 0;
			tmp_tmp_h := 0;

			maxValue := (others=>'1');
			for i in 0 to c_img_dim12 - 1 loop
				for j in 0 to c_img_dim12 - 1 loop

					if (in_img(i,j) = maxValue) then
						tmp_tmp_w := tmp_tmp_w + 1;
					else
						if (tmp_w < tmp_tmp_w) then
						tmp_w := tmp_tmp_w;
						end if;
						tmp_tmp_w := 0;
					end if;

					if (in_img(j,i) = maxValue) then
						tmp_tmp_h := tmp_tmp_h + 1;
					else
						if (tmp_h < tmp_tmp_h) then
						tmp_h := tmp_tmp_h;
						end if;
						tmp_tmp_h := 0;
					end if;

				end loop;

				if (tmp_w > max_w) then
					max_w := tmp_w;
				end if;

				if (tmp_h > max_h) then
					max_h := tmp_h;
				end if;
				
				--tmp_w := 0;
				--tmp_h := 0;

			end loop;
			max_width <= max_w;
			max_height <= max_h;
	end process;

end architecture extract_dimensions_BEHAVIOR;
