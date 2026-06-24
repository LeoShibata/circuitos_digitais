library ieee;
use ieee.std_logic_1164.all;

-- responsável por traduzir os números para os displays. 

entity bin_to_7seg is
    port(
        bin : in  std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0)
    );
end bin_to_7seg;

architecture comportamento of bin_to_7seg is
begin
    with bin select
        seg <= "1111110" when "0000", -- 0
               "0110000" when "0001", -- 1
               "1101101" when "0010", -- 2
               "1111001" when "0011", -- 3
               "0110011" when "0100", -- 4
               "1011011" when "0101", -- 5
               "1011111" when "0110", -- 6
               "1110000" when "0111", -- 7
               "1111111" when "1000", -- 8
               "1110011" when "1001", -- 9
               "0000000" when others;
end comportamento;