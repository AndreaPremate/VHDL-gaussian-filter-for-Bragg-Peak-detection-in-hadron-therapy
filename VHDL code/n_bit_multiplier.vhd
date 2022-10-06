library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity n_bit_multiplier is 
	generic ( 
		Nb : integer);
	port(
		a : in std_logic_vector(Nb - 1 downto 0);
		b : in std_logic_vector(Nb - 1 downto 0);
		c : out std_logic_vector(2*Nb -1  downto 0)
	);
end;

architecture n_bit_multiplier_BEHAVIOR of n_bit_multiplier is
	begin						
		c <= std_logic_vector(unsigned(a) * unsigned(b));
end architecture n_bit_multiplier_BEHAVIOR;
