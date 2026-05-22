library ieee;
use ieee.std_logic_1164.all;

entity P14_cnt_up_down_mod60_vhdl is
	port(
		clk, z, ud, sst		: in  std_logic;	
		qu_7s, qd_7s       	: out std_logic_vector(6 downto 0);		
		clk_in, clk_out		: out std_logic							
);
end P14_cnt_up_down_mod60_vhdl;

architecture cnt_up_down_mod60_2_vhdl of P14_cnt_up_down_mod60_vhdl is
	signal q_up_m10, q_down_m10, qstate_up_m10, qstate_down_m10, qn_up_m10, qn_down_m10: std_logic_vector(3 downto 0);
	signal clk_up_m10, clk_down_m10, clkn_up_m10, clkn_down_m10, zn_m10, reset_m10, rst_alargador_m10, ff_rst_m10, clr_alargador_m10, clr_aux_m10, prs_rst_m10: std_logic;
	signal q_up_m6, q_down_m6, qstate_up_m6, qstate_down_m6, qn_up_m6, qn_down_m6: std_logic_vector(3 downto 0);
	signal clk_up_m6, clk_down_m6, clkn_up_m6, clkn_down_m6, zn_m6, reset_m6, rst_alargador_m6, ff_rst_m6, clr_alargador_m6, clr_aux_m6, prs_rst_m6: std_logic;
	signal qu, qd: std_logic_vector(3 downto 0);
	signal qo, ff_rst_in, ff_rst_out, reset_u, reset_d, clk_anti_repique, div_out, clk_div_debounce_out, ff_sst_q_out, ff_sst_qn_out, clk_debounce: std_logic;
	component dff_vhdl is				
		port
		(
			d, clk, prs, clr	: in  std_logic;	
			q, qn				: out std_logic 	
		);
	end component;
	component divider is
	port(
		clk_in					: in  std_logic;	
		clk_out_1, clk_out_2	: out std_logic	
	);
	end component;
	component debounce_v1 is
	port(
		clk, button	: in  std_logic;    
		result  	: out std_logic
	);
	end component;
begin
	clk_out <= div_out;
	clk_in <= not div_out;
	div : divider port map(clk_in => clk, clk_out_1 => clk_debounce, clk_out_2 => div_out);
	deb : debounce_v1 port map(clk => clk_debounce, button => sst, result => clk_anti_repique);
	ff_sst: dff_vhdl port map(d => ff_sst_qn_out, prs => '0', clr => zn_m10, clk => clk_anti_repique, q => ff_sst_q_out, qn => ff_sst_qn_out);
	clk_div_debounce_out <= div_out and ff_sst_q_out;
	qu(0) <= q_up_m10(0) when ud = '0' else q_down_m10(0);
	qu(1) <= q_up_m10(1) when ud = '0' else q_down_m10(1);
	qu(2) <= q_up_m10(2) when ud = '0' else q_down_m10(2);
	qu(3) <= q_up_m10(3) when ud = '0' else q_down_m10(3);
	zn_m10 <= not z;
	clk_up_m10 <= clk_div_debounce_out when ud = '0';
	clk_down_m10 <= clk_div_debounce_out when ud = '1';
	clkn_up_m10 <= not clk_up_m10;
	clkn_down_m10 <= not clk_down_m10;
	prs_rst_m10 <= (zn_m10 or (qstate_up_m10(1) and qstate_up_m10(3)));
	ff_d0_up_m10: dff_vhdl port map(d => qn_up_m10(0), prs => '0', clr => clr_aux_m10, clk => clk_up_m10,   q => qstate_up_m10(0), qn => qn_up_m10(0));
	ff_d1_up_m10: dff_vhdl port map(d => qn_up_m10(1), prs => '0', clr => clr_aux_m10, clk => qn_up_m10(0), q => qstate_up_m10(1), qn => qn_up_m10(1));
	ff_d2_up_m10: dff_vhdl port map(d => qn_up_m10(2), prs => '0', clr => clr_aux_m10, clk => qn_up_m10(1), q => qstate_up_m10(2), qn => qn_up_m10(2));
	ff_d3_up_m10: dff_vhdl port map(d => qn_up_m10(3), prs => '0', clr => clr_aux_m10, clk => qn_up_m10(2), q => qstate_up_m10(3), qn => qn_up_m10(3));
	ff_reset_up_m10: dff_vhdl port map(d => '0', prs => prs_rst_m10, clr => clkn_up_m10, clk => '0', q => clr_aux_m10);
	q_up_m10(0) <= qstate_up_m10(0);
	q_up_m10(1) <= qstate_up_m10(1);
	q_up_m10(2) <= qstate_up_m10(2);
	q_up_m10(3) <= qstate_up_m10(3);
	reset_m10 <= ff_rst_out and (qstate_down_m10(0) and (qstate_down_m10(1) and (qstate_down_m10(2) and qstate_down_m10(3))));
	ff_rst_in <= not (qstate_down_m10(0) or (qstate_down_m10(1) or (qstate_down_m10(2) or qstate_down_m10(3))));
	rst_alargador_m10 <= reset_m10 or zn_m10;
	ff_d0_down_m10: dff_vhdl port map(d => qn_down_m10(0), prs => reset_u, clr => '0', clk => clk_down_m10, q => qstate_down_m10(0), qn => qn_down_m10(0));
	ff_d1_down_m10: dff_vhdl port map(d => qn_down_m10(1), prs => '0', clr => ff_rst_m10, clk => qstate_down_m10(0), q => qstate_down_m10(1), qn => qn_down_m10(1));
	ff_d2_down_m10: dff_vhdl port map(d => qn_down_m10(2), prs => '0', clr => ff_rst_m10, clk => qstate_down_m10(1), q => qstate_down_m10(2), qn => qn_down_m10(2));
	ff_d3_down_m10: dff_vhdl port map(d => qn_down_m10(3), prs => reset_u, clr => '0', clk => qstate_down_m10(2), q => qstate_down_m10(3), qn => qn_down_m10(3));
	ff_reset_down_m10: dff_vhdl port map(d => '0', prs => ff_rst_in, clr => ff_rst_m10, clk => '0', q => ff_rst_out);
	ff_reset_alargador_down_m10: dff_vhdl port map(d => '0', prs => rst_alargador_m10, clr => clkn_down_m10, clk => '0', q => ff_rst_m10);
	reset_u <= '1' when ff_rst_m10 = '1' else '0';
	q_down_m10(0) <= qstate_down_m10(0);
	q_down_m10(1) <= qstate_down_m10(1);
	q_down_m10(2) <= qstate_down_m10(2);
	q_down_m10(3) <= qstate_down_m10(3);
	qo <= clr_aux_m10 when ud = '0' else ff_rst_m10;
	qd(0) <= q_up_m6(0) when ud = '0' else q_down_m6(0);
	qd(1) <= q_up_m6(1) when ud = '0' else q_down_m6(1);
	qd(2) <= q_up_m6(2) when ud = '0' else q_down_m6(2);
	qd(3) <= q_up_m6(3) when ud = '0' else q_down_m6(3);
	zn_m6 <= not z;
	clk_up_m6 <= qo when ud = '0';
	clk_down_m6 <= qo when ud = '1';
	clkn_up_m6 <= not clk_up_m6;
	clkn_down_m6 <= not clk_down_m6;
	prs_rst_m6 <= (zn_m6 or (qstate_up_m6(1) and qstate_up_m6(2)));
	ff_d0_up_m6: dff_vhdl port map(d => qn_up_m6(0), prs => '0', clr => clr_aux_m6, clk => clk_up_m6,   q => qstate_up_m6(0), qn => qn_up_m6(0));
	ff_d1_up_m6: dff_vhdl port map(d => qn_up_m6(1), prs => '0', clr => clr_aux_m6, clk => qn_up_m6(0), q => qstate_up_m6(1), qn => qn_up_m6(1));
	ff_d2_up_m6: dff_vhdl port map(d => qn_up_m6(2), prs => '0', clr => clr_aux_m6, clk => qn_up_m6(1), q => qstate_up_m6(2), qn => qn_up_m6(2));
	ff_d3_up_m6: dff_vhdl port map(d => qn_up_m6(3), prs => '0', clr => clr_aux_m6, clk => qn_up_m6(2), q => qstate_up_m6(3), qn => qn_up_m6(3));
	ff_reset_up_m6: dff_vhdl port map(d => '0', prs => prs_rst_m6, clr => clkn_up_m6, clk => '0', q => clr_aux_m6);
	q_up_m6(0) <= qstate_up_m6(0);
	q_up_m6(1) <= qstate_up_m6(1);
	q_up_m6(2) <= qstate_up_m6(2);
	q_up_m6(3) <= qstate_up_m6(3);
	reset_m6 <= qstate_down_m6(0) and (qstate_down_m6(1) and (qstate_down_m6(2) and qstate_down_m6(3)));
	rst_alargador_m6 <= reset_m6 or zn_m6;
	ff_d0_down_m6: dff_vhdl port map(d => qn_down_m6(0), prs => reset_d, clr => '0', clk => clk_down_m6, q => qstate_down_m6(0), qn => qn_down_m6(0));
	ff_d1_down_m6: dff_vhdl port map(d => qn_down_m6(1), prs => '0', clr => ff_rst_m6, clk => qstate_down_m6(0), q => qstate_down_m6(1), qn => qn_down_m6(1));
	ff_d2_down_m6: dff_vhdl port map(d => qn_down_m6(2), prs => reset_d, clr => '0', clk => qstate_down_m6(1), q => qstate_down_m6(2), qn => qn_down_m6(2));
	ff_d3_down_m6: dff_vhdl port map(d => qn_down_m6(3), prs => '0', clr => ff_rst_m6, clk => qstate_down_m6(2), q => qstate_down_m6(3), qn => qn_down_m6(3));
	ff_reset_alargador_down_m6: dff_vhdl port map(d => '0', prs => rst_alargador_m6, clr => clkn_down_m6, clk => '0', q => ff_rst_m6);
	reset_d <= '1' when ff_rst_m6 = '1' else '0';
	q_down_m6(0) <= qstate_down_m6(0);
	q_down_m6(1) <= qstate_down_m6(1);
	q_down_m6(2) <= qstate_down_m6(2);
	q_down_m6(3) <= qstate_down_m6(3);
	with qu select
		qu_7s <=    "1111110" when "0000",
                    "0110000" when "0001",
                    "1101101" when "0010",
                    "1111001" when "0011",
                    "0110011" when "0100",
                    "1011011" when "0101",
                    "1011111" when "0110",
                    "1110000" when "0111",
                    "1111111" when "1000",
                    "1110011" when "1001",
                    "1110111" when "1010",
                    "0011111" when "1011",
                    "1001110" when "1100",
                    "0111101" when "1101",
                    "1111001" when "1110",
                    "0111100" when "1111",
                    "0000000" when others;
	with qd select
		qd_7s <=    "1111110" when "0000",
                    "0110000" when "0001",
                    "1101101" when "0010",
                    "1111001" when "0011",
                    "0110011" when "0100",
                    "1011011" when "0101",
                    "1011111" when "0110",
                    "1110000" when "0111",
                    "1111111" when "1000",
                    "1110011" when "1001",
                    "1110111" when "1010",
                    "0011111" when "1011",
                    "1001110" when "1100",
                    "0111101" when "1101",
                    "1111001" when "1110",
                    "0111100" when "1111",
                    "0000000" when others;
end cnt_up_down_mod60_2_vhdl;