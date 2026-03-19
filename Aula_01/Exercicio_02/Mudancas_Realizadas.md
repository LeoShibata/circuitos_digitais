# Relatório de Correções - Exercício 02 (Conversor Binário para Gray)

Este documento descreve as modificações realizadas nos arquivos do projeto para garantir o funcionamento correto na placa de desenvolvimento **MAX II (EPM240T100C5)** e a consistência entre a simulação Logisim e a implementação VHDL.

## 1. Mapeamento de Pinos (Quartus - `.qsf`)
**Problema:** Os pinos de entrada `bin_i[1]` e `bin_i[2]` estavam invertidos fisicamente nas atribuições do Quartus, o que causava uma leitura errada da ordem das chaves na placa.

**Ação:** Reordenamos os pinos para que as chaves físicas sigam a ordem lógica correta (do Bit 3 ao Bit 0).
- `PIN_53` -> `bin_i[3]` (MSB)
- `PIN_52` -> `bin_i[2]`
- `PIN_51` -> `bin_i[1]`
- `PIN_50` -> `bin_i[0]` (LSB)

## 2. Tratamento de Lógica Inversa (VHDL - `.vhd`)
**Problema:** Na placa física, os LEDs e as chaves operam em **Active Low** (lógica inversa). Isso fazia com que os LEDs ficassem acesos quando deveriam estar apagados, e as chaves enviassem `1` quando não pressionadas.

**Ação:** Modificamos a arquitetura VHDL para normalizar a lógica:
- **Entradas:** Invertemos o sinal de entrada (`bin <= NOT bin_i`) para que o sistema entenda "chave solta" como `0` e "chave pressionada" como `1`.
- **Saídas:** Invertemos o resultado final (`gray_o <= NOT gray`) para que o LED acenda apenas quando o bit de saída for `1`.

```vhdl
-- Trecho da correção no VHDL
bin <= NOT bin_i; -- Inversão para chaves Active-Low
...
gray_o <= NOT gray; -- Inversão para LEDs Active-Low
```

## 3. Sincronização de Bits (Logisim - `.circ`)
**Problema:** No esquema de portas lógicas do Logisim, o bit que não sofria alteração (MSB) era o bit 0, enquanto no código VHDL e no padrão de código Gray, o MSB é o bit 3. Isso gerava divergência entre o "circuito de portas" e o "componente VHDL".

**Ação:** Refizemos as conexões no Logisim:
- O bit 3 (`B3`) agora passa direto para o bit 3 de saída (`G3`).
- As portas XOR agora comparam corretamente os pares descendentes: `G2 = B3 ⊕ B2`, `G1 = B2 ⊕ B1` e `G0 = B1 ⊕ B0`.

## 4. Resumo da Lógica Implementada
A lógica de conversão agora segue rigorosamente o padrão MSB (Most Significant Bit):
1.  $G_3 = B_3$
2.  $G_2 = B_3 \oplus B_2$
3.  $G_1 = B_2 \oplus B_1$
4.  $G_0 = B_1 \oplus B_0$

---
**Status Final:** O projeto está pronto para síntese no Quartus e simulação no Logisim, com comportamento visual idêntico em ambos.
