library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_multiplier is
    end tb_multiplier;
    
architecture tb_multiplier_behavior of tb_multiplier is
	
	component n_bit_multiplier is
		generic ( Nb : integer ) ;
		port(
		a, b :in  std_logic_vector(Nb-1 downto 0);
		c    :out std_logic_vector(2*Nb - 1 downto 0)
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
    
 	constant numb1: integer := 4;    
	constant numbtot: integer := 2*numb1;
	signal data1, data2: std_logic_vector(numb1-1 downto 0);
	signal out_multiplier: std_logic_vector(2*numb1 - 1 downto 0);
	signal datatot: std_logic_vector(numbtot-1 downto 0);
	signal clock_internal: std_logic;
	
	begin
	data1 <= datatot(numb1-1 downto 0);
	data2 <= datatot(numbtot-1 downto numb1);
	cmpt_siggen1: counter generic map (Nb => numbtot) port map('1', clock_internal, datatot);
	cmpt2: n_bit_multiplier generic map (Nb => numb1) port map(data1, data2, out_multiplier);   

    process 
		begin
        	clock_internal <= '0'; wait for 10 ns;
	    	clock_internal <= '1'; wait for 10 ns;
    end process;

end tb_multiplier_behavior;
