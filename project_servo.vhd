library ieee;
use ieee.std_logic_1164.all;

entity project_servo is
port(clk,enable:in std_logic;
	space:in integer range 0 to 3000;
	moto:out std_logic);
end project_servo;

architecture main of project_servo is
signal count:integer range 0 to 3000;
signal remember:integer range 0 to 3000;
signal spacecount:integer range 0 to 20000;
signal times:integer range 0 to 50;
signal state:std_logic_vector (1 downto 0);
begin
	process(clk,enable,space)
		begin
			if rising_edge(clk) then
			 if state(0) = '0' then
			     if enable = '1' then--输入开始信号，就输出指定个数脉冲
			         remember <= space;
			         state(0)<='1';
			         times<=50;
			         spacecount<=0;
			     end if;
			 elsif spacecount = 0 then--大循环
			     if times = 0 then
			         state(0) <= '0';
			     else
			         spacecount<=20000;
			         count<=remember;--小循环
			         times<=times-1;
			     end if;
			  else
			     spacecount <= spacecount - 1;
			 end if;
			 if count = 0 then
			     state(1) <= '0';
			  else
			     count <= count - 1;
			     state(1) <= '1';
			  end if;
			end if;
		end process;
	moto <= state(1);
end main;
