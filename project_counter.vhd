library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity project_counter is
port(putin,dir,clk,reset:in std_logic;
	enable:out std_logic;
	feedback:out std_logic;
	result:out integer range 0 to 3000);--输出两次触发的时间差
end project_counter;

architecture main of project_counter is
signal state:std_logic_vector(1 downto 0);
signal space:integer range 0 to 511;
signal holdtime:integer range 0 to 3000;
signal cache:integer range 0 to 3000;
signal sig:std_logic;
begin 
	process(clk,reset,putin,dir)
		begin
			if rising_edge(clk) then
				if reset = '1' then
				    holdtime<=0;
				    feedback<='0';
					state <= "00";--00表示等待，01表示计数，10表示输出，11表示计数无效
					space<=0;
					result<=0;
					--------------------------------
				elsif state = "00" then
					space <= 0;
					cache <= 0;
					holdtime<=0;
					if putin = '1' then
					   state <= "01";
					   sig<=dir;
					 end if;
					 -----------------------------
				elsif state = "01" then
				    if putin = '0' then
				        state <= "10";
				        holdtime <= 0;
	                   if sig = '1' then
	                   --   cache <= 1000;
                        result <= 1500 + space + space*8/10;-- (space *7/10);
                        else
                        result <= 1500 - space - space*8/10;--(space *7/10);
                        end if;
				    elsif space = 511 then
				        state <= "11" ;
				        holdtime <= 0;
				    else
				        space <= space + 1;
				     end if;
				     ---------------------------------
				 elsif state(1) = '1' then
				    if holdtime = 3000 then
				        state <= "00";
				    else
				        holdtime <= holdtime + 1;
				    end if;
                    ---------------------------------
				else
				    state <="00";
				end if;
			end if;
		end process;
	enable <= (not state(0)) and state(1);
	--result <= cache;
	feedback<=state(0) and state(1);
end main;
					
