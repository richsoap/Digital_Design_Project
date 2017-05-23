----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2017/05/21 13:50:39
-- Design Name: 
-- Module Name: project_door - Behavioral
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

entity project_door_mod0 is
    port(wav:in std_logic_vector(1 downto 0);
        reset_in,clk:in std_logic;
        reset_out:out std_logic;
        dir:out std_logic;
        enable:out std_logic
        );
end project_door_mod0;

architecture Behavioral of project_door_mod0 is
signal state1,state2:std_logic;--左声道-state1右声道-state2
signal before:std_logic_vector(1 downto 0);--判断是否是上升沿
begin
    process(wav,clk,reset_in)
        begin   
            if rising_edge(clk) then
                if reset_in = '1' then
                    state1 <= '0';
                    state2 <= '0';
                    before <= "00";
                else
                    if ((not before(0)) and wav(0)) = '1' then
                        state1<='1';
                    end if;
                    if ((not before(1)) and wav(1)) = '1' then
                        state2<='1';
                    end if;
                end if;
                before <= wav;
               end if;
              end process;
              reset_out<=not(state1 or state2);
              dir<=state1;
              enable<=state1 xor state2;
end Behavioral;
