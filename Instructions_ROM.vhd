library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.common.all;

entity Instructions_ROM is
	port (	address_in : in STD_LOGIC_VECTOR (6 downto 0);
		data_out : out STD_LOGIC_VECTOR (15 downto 0)
	     );
end Instructions_ROM;

architecture Behavioral of Instructions_ROM is

type ROM_type is array (0 to 127) of STD_LOGIC_VECTOR (15 downto 0);
signal rom : ROM_type;

begin
	data_out <= rom ( to_integer(unsigned(address_in)) );

	rom_process : process (address_in)
	begin
		-- LEAVE AS IS
		--
		-- reset ROM content completely with HLT operations; note that loop will be unrolled during synthesis
		for i in 0 to 127 loop 
			rom(i) <= opcode_type_to_std_logic_vector(OP_HALT) & (11 downto 0 => 'X'); 
		end loop;

		-- initialize ROM with binary code
		--
		
		-- TODO comment out and replace with your own binary code here
		--	
		---- Task 2
		rom(0) <= opcode_type_to_std_logic_vector(OP_ADDI) & b"001" & b"000" & b"000_000"; -- R1: R0 + 0 = 0
		rom(1) <= opcode_type_to_std_logic_vector(OP_ADDI) & b"001" & b"001" & b"000_010"; -- R1: R1 + 2 = 2
		rom(2) <= opcode_type_to_std_logic_vector(OP_ADDI) & b"001" & b"001" & b"000_010"; -- R1: R1 + 2 = 4
		rom(3) <= opcode_type_to_std_logic_vector(OP_ADDI) & b"001" & b"001" & b"000_010"; -- R1: R1 + 2 = 6
		rom(4) <= opcode_type_to_std_logic_vector(OP_ADDI) & b"001" & b"001" & b"000_010"; -- R1: R1 + 2 = 8
		rom(5) <= opcode_type_to_std_logic_vector(OP_BE) & b"111" & b"000" & b"000_100"; -- R1: R1 + 2 = 4
		

		-- LEAVE AS IS
		--
		-- This dummy code below helps to infer all 7 registers (R1--R7) in the register file, without short-cuts into combinatorial
		-- logic due to tool optimization; that is important to ensure the same baseline hardware configuration for all
		rom(121) <= opcode_type_to_std_logic_vector(OP_ADD) & b"001_001_000_000";
		rom(122) <= opcode_type_to_std_logic_vector(OP_ADD) & b"010_010_001_000";
		rom(123) <= opcode_type_to_std_logic_vector(OP_ADD) & b"011_011_010_000";
		rom(124) <= opcode_type_to_std_logic_vector(OP_ADD) & b"100_100_011_000";
		rom(125) <= opcode_type_to_std_logic_vector(OP_ADD) & b"101_101_100_000";
		rom(126) <= opcode_type_to_std_logic_vector(OP_ADD) & b"110_110_101_000";
		rom(127) <= opcode_type_to_std_logic_vector(OP_ADD) & b"111_111_110_000";
 
	end process;

end Behavioral;

