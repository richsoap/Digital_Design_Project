----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2017/05/23 12:43:50
-- Design Name: 
-- Module Name: project_location_mod0 - Behavioral
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

entity project_location_mod0 is
    port(enable_in,mainclk:in std_logic;
        wav:in std_logic_vector(1 downto 0);
        enable_speaker,enable_out,servo:out std_logic
    );
end project_location_mod0;

architecture Behavioral of project_location_mod0 is

component project_door_mod0 is
    port(wav:in std_logic_vector(1 downto 0);
        reset_in,clk:in std_logic;
        reset_out:out std_logic;
        dir:out std_logic;
        enable:out std_logic
        );
end component;

component lab3_fre is
generic(N:integer);--参变量控制分频器的频率
port(clkin,reset:in std_logic;
	clkout:out std_logic);
end component;

component project_barkdog is
  generic(M,N:integer:=50000);--
 port(clk,enable:in std_logic;
      reset:out std_logic);
end component;

component project_counter is
port(putin,dir,clk,reset:in std_logic;
	enable:out std_logic;
	feedback:out std_logic;
	result:out integer range 0 to 3000);--输出两次触发的时间差
end component;

component project_servo is
port(clk,enable:in std_logic;
	space:in integer range 0 to 3000;
	moto:out std_logic);
end component;

signal clk1u:std_logic;
signal result:integer range 0 to 3000;
signal reset_counter,enable_servo,start_counter,dir_counter:std_logic;
signal feed_counter,feed_barkdog,reset_door:std_logic;

begin
    fre1u:lab3_fre generic map(50) port map(mainclk,'0',clk1u);
    maindoor:project_door_mod0 port map(wav,reset_door,clk1u,reset_counter,dir=>dir_counter,enable=>start_counter);
    wavcounter:project_counter port map(start_counter,dir_counter,clk1u,reset_counter,enable_servo,feed_counter,result);
    barkdog:project_barkdog generic map(M=>30000000,N=>500) port map(clk1u,enable_servo,feed_barkdog);
    myservo:project_servo port map(clk1u,enable_servo,result,servo);
    reset_door<=feed_counter or feed_barkdog or (not enable_in);
end Behavioral;
