----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2017/05/21 15:30:01
-- Design Name: 
-- Module Name: project_barkdog - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_barkdog is
  generic(M,N:integer:=50000);
 port(clk,enable:in std_logic;
      reset:out std_logic);
end project_barkdog;

architecture Behavioral of project_barkdog is
signal state:std_logic_vector(1 downto 0);
signal runcounter:integer range 0 to N;--eat
signal waitcounter:integer range 0 to M;--bark
begin
    process(clk,enable) 
        begin 
            if rising_edge(clk) then
                if state = "00" then
                    runcounter <= 0;
                    waitcounter <= 0;
                    if enable = '1' then
                        state <= "01";
                     end if;
                elsif state = "01" then
                    if runcounter = N then
                        state <= "10";
                    else
                        runcounter <= runcounter + 1;
                     end if;
                 elsif state = "10" then
                    if waitcounter = M then
                        state <= "00";
                    else 
                        waitcounter <= waitcounter + 1;
                    end if;
                 else
                    state <= "00";
                 end if;
              end if;
          end process;
         reset<=state(1);           

end Behavioral;
