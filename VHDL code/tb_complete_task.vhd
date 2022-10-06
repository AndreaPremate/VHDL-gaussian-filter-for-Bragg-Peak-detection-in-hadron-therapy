library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;
use work.my_package.all;

entity tb_complete_task is
end tb_complete_task;
    
architecture tb_complete_task_behavior of tb_complete_task is
		
	component complete_task is port(
		clk,enable : in std_logic;
		in_img : in img;
		in_mask : in t_matrix;
		in_bin_threshold : in integer := 127;
		conv_img : out img;
		bin_conv_img : out img;
		bragg_peak_value : out integer;
		bragg_peak_i_index : out integer;
		bragg_peak_j_index : out integer;
		max_width_ellipsoid : out integer;
		max_height_ellipsoid : out integer
		);
	end component;

	signal tb_clk,tb_enable : std_logic := '0';
	signal tb_in_bin_threshold : integer := 127;
	signal tb_conv_img : img :=  (others => (others => (others => '0')));
	signal tb_bin_conv_img : img :=  (others => (others => (others => '0')));
	signal tb_bragg_peak_value : integer;
	signal tb_bragg_peak_i_index : integer;
	signal tb_bragg_peak_j_index : integer;
	signal tb_max_width_ellipsoid : integer;
	signal tb_max_height_ellipsoid : integer;
	signal tb_check20_20_conv : std_logic_vector(c_bit_pixel_depth - 1 downto 0); 
	signal tb_check20_20_original : std_logic_vector(c_bit_pixel_depth - 1 downto 0); 

	begin 
	tb_check20_20_conv <= tb_conv_img(25,25);
	tb_check20_20_original <= immagine(25,25);
	complete_task_inst: complete_task port map(tb_clk,tb_enable, immagine, mask, tb_in_bin_threshold, tb_conv_img,
												tb_bin_conv_img, tb_bragg_peak_value,tb_bragg_peak_i_index,tb_bragg_peak_j_index,
												tb_max_width_ellipsoid, tb_max_height_ellipsoid); 

	process begin 
		tb_clk <= '1'; wait for 10 ns;
	    tb_clk <= '0'; wait for 10 ns;
    end process;

	process begin 
		tb_enable <= '0'; wait for 100 ns;
	    tb_enable <= '1'; wait for 40 ns;
		tb_enable <= '0'; wait for 1500 ns;
		immagine(25,25) <= "11111111";
    end process;

	process (tb_conv_img) 
		file file_test_conv_img : text open write_mode is "output_file_conv_img.txt";
		variable my_line : line;    
		variable zerozero : std_logic_vector(c_bit_pixel_depth-1 downto 0) := (others => 'U');
		begin
			if tb_conv_img(c_img_dim12-1,c_img_dim12-1) /= zerozero then
			
			write(my_line, string'("Immagine dopo la convoluzione ["));
			for i in 0 to c_img_dim12 - 1 loop
				for j in 0 to c_img_dim12 - 1  loop
					write(my_line, to_integer(unsigned(tb_conv_img(i,j))));
					write(my_line, string'(" "));
				end loop;
				if i /= c_img_dim12 - 1 then 
					write(my_line, string'(";"));
				end if;
			end loop;
			write(my_line, string'("];"));
			writeline(file_test_conv_img, my_line);
			end if;
	end process;

	process (tb_bin_conv_img) 
		file file_test_conv_bin_img : text open write_mode is "output_file_conv_bin_img.txt";
		variable my_line : line;   
		variable zerozero : std_logic_vector(c_bit_pixel_depth-1 downto 0) := (others => 'U'); 
		begin
			if tb_bin_conv_img(c_img_dim12-1,c_img_dim12-1)  /= zerozero then
			write(my_line, string'("Immagine dopo convoluzione e binarizzazione ["));
			for i in 0 to c_img_dim12 - 1 loop
				for j in 0 to c_img_dim12 - 1  loop
					write(my_line, to_integer(unsigned(tb_bin_conv_img(i,j))));
					write(my_line, string'(" "));
				end loop;
				if i /= c_img_dim12 - 1 then 
					write(my_line, string'(";"));
				end if;
			end loop;
			write(my_line, string'("];"));
			writeline(file_test_conv_bin_img, my_line);
			end if;
	end process;

	process 
		file file_test_original_img : text open write_mode is "output_file_original_img.txt";
		variable my_line : line;   
		variable zerozero : std_logic_vector(c_bit_pixel_depth-1 downto 0) := (others => 'U'); 
		begin
			write(my_line, string'("Immagine originale ["));
			for i in 0 to c_img_dim12 - 1 loop
				for j in 0 to c_img_dim12 - 1  loop
					write(my_line, to_integer(unsigned(immagine(i,j))));
					write(my_line, string'(" "));
				end loop;
				if i /= c_img_dim12 - 1 then 
					write(my_line, string'(";"));
				end if;
			end loop;
			write(my_line, string'("];"));
			writeline(file_test_original_img, my_line);
		wait;
	end process;

end tb_complete_task_behavior;
