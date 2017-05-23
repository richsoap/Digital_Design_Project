library ieee;
use ieee.std_logic_1164.all;

entity	lab3_fre is
generic(N:integer:=2);--参变量控制分频器的频率
port(clkin,reset:in std_logic;
	clkout:out std_logic);
end;

architecture counter of lab3_fre is 
signal count:integer range 1 to N-1;
signal clk:std_logic;
signal innercount:integer range 0 to 7;
begin
	process(clkin,reset)
	begin
		if rising_edge(clkin) then
			if reset = '1' then--出现复位信号后，输出7个100MHZ的信号，保证计数器能够同步复位，然后再让输出口保持为0
			 if innercount = 7 then
				count <= 1;
				clk <= '0';
			 else
			      innercount<=innercount + 1;
			      clk<=not clk;
			 end if;
			elsif count = N - 1 then
				count <= 1;
				clk <= not clk;
				innercount <=0;
			else
			     innercount<=0;
				count <= count +1;
			end if;
		end if;
	end process;
	clkout<=clk;
end counter;