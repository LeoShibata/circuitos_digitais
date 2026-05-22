--------------------------------------------------------------------------------
-- UTFPR - Universidade Tecnol�gica Federal do Paran� - Curitiba - PR
-- Projeto  : Pr�tica 5 - Cron�metro
-- Circuito : Implementa��o de um FF tipo D
-- Arquivo  : dff_vhdl.vhd
-- Autor    : prof. Gortan
-- Data     : Maio 2022
--------------------------------------------------------------------------------
-- Descri��o :
-- Implementa um flip-flop tipo D para ser usado como componente em outros circ.
-- obs.: O Logisim-evolution 3.7.2 ir� armazenar esse componente
--       em uma biblioteca do Modelsim contida em:
-- 
--       C:\users\<nome_usu�rio>\AppData\Local\Temp\logisim\sim\comp\work 
--     
--       O Logisim-evolution criar� um componente nesse local com o nome
--       da entity seguido de underline, seguido do nome do r�tulo ou label
--       atribuido ao componente no circuito.
--
--       Neste projeto:
--       	a entity para o flip-flop tipo D ser�: dff
--          o r�tulo (label) usado para o componente no circuito ser�: vhdl
--       Consequentemente o logisim criar� um componente chamado dff_vhdl
--
--       � poss�vel verificar no diret�rio:
--       C:\users\<nome_usu�rio>\AppData\Local\Temp\logisim\sim\src
--       que o Logisim-evolution realmente modificou o nome
--       do arquivo para dff_vhdl.vhdl e da entity para dff_vhdl
--
--       Esse ser� portanto o nome do componente referenciado em todos os
--       demais circuitos que fizerem uso desse componente.
--
--       Ao exportar este arquivo para o Quartus lembrar de renomear a entity
--       para dff_vhdl para que possa ser referenciada pelos outros circuitos.
--
--       Aten��o: O Logisim-evolution n�o apaga o conte�do da biblioteca "work"
--                citada acima. 
--				  Isso pode tanto ajudar como atrapalhar novos projetos
--                (dependendo do conte�do de projetos anteriores estar
--                ou n�o de acordo com as necessidades do projeto atual)
--                Por esse motivo � sempre aconselh�vel apagar essa bibioteca
--                "work" antes de iniciar um novo projeto e tamb�m apagar a
--                pasta    C:\users\<nome_usu�rio>\AppData\Local\Temp\work
--                usada pelo Logisim-evolution como uma especie de cache.
--       O professor apagar� sempre essas duas pastas antes de iniciar a 
--       valida��o de trabalhos submetidos por alunos. N�o deixe de fazer isso
--       tamb�m antes de realizar uma �ltima verifica��o para postar seus trabalhos
--------------------------------------------------------------------------------

--============================= M�dulo comps: ==================================
library ieee;
  use ieee.std_logic_1164.all;

entity dff_vhdl is								-- nome da entity ser� alterado
  port(
    d, clk, prs, clr	: in  std_logic;	-- entradas: dado, clk, preset e clear
    q, qn				: out std_logic	-- sa�das:   q e q invertido
 );
end dff_vhdl;

architecture ff_d of dff_vhdl is

	signal qstate: std_logic;

begin
	process(clk, clr, prs)
	begin
		if clr = '1' then qstate <= '0';	 -- clr tem prioridade
		elsif prs = '1' then qstate <= '1'; -- sobre prs
		elsif clk = '1' and clk' event then qstate <= d;
		end if;
	end process;
	q <= qstate;
	qn <= not qstate;
end ff_d;

