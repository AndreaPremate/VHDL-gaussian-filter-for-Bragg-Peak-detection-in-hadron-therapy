library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.my_package.all;


entity store_row_img_register is 

	port(
		clk : in std_logic;
		row_index : in integer := 0;
		in_row : in row;
		in_img : in img;
		out_img : out img
	);
end;

architecture store_row_img_register_BEHAVIOR of store_row_img_register is

	begin 
	process (clk) 
		variable tmp_img: img;
		begin
			if (clk'event and clk='1' ) then
				out_img <= in_img;
				cols: for j in 0 to c_img_dim12-1 loop
					out_img(row_index, j) <= in_row(j);
				end loop cols;
			end if;
	end process;

end architecture store_row_img_register_BEHAVIOR; 
