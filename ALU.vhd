library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.common.all;

entity ALU is
	port ( 	operand_1 : in STD_LOGIC_VECTOR (13 downto 0);
	 	operand_2 : in STD_LOGIC_VECTOR (13 downto 0);

	 	opcode : in opcode_type;

		result : out STD_LOGIC_VECTOR (13 downto 0);
		overflow : out STD_LOGIC

	     );
end ALU;

architecture Behavioral of ALU is

signal result_internal: STD_LOGIC_VECTOR (13 downto 0);

begin

result <= result_internal;

calculate : process (operand_1, operand_2, opcode)
begin
	-- signed ADD operations
	-- TODO consider remaining cases
	
	if ((opcode = OP_AND)) then

		result_internal <= operand_1 and operand_2;
		
	elsif ((opcode = OP_ANDI)) then

		result_internal <= operand_1 and operand_2;
	
	elsif ((opcode = OP_OR)) then

		result_internal <= operand_1 or operand_2;
		
	elsif ((opcode = OP_ORI)) then

		result_internal <= operand_1 or operand_2;

	elsif ((opcode = OP_XOR)) then
 
		result_internal <= operand_1 xor operand_2;
		
	elsif ((opcode = OP_XORI)) then

		result_internal <= operand_1 xor operand_2;
		
	-- SLL operation
	elsif (opcode = OP_SLL) then

		result_internal <= std_logic_vector( shift_left(unsigned(operand_1), to_integer(unsigned(operand_2))) );
		
	elsif ((opcode = OP_SRL)) then

		result_internal <= std_logic_vector( shift_right(unsigned(operand_1), to_integer(unsigned(operand_2))) );
		
	elsif ((opcode = OP_ADD)) then

		result_internal <= std_logic_vector( signed(operand_1) + signed(operand_2) );
		
	elsif ((opcode = OP_ADDI)) then

		result_internal <= std_logic_vector( signed(operand_1) + signed(operand_2) );
		
	elsif ((opcode = OP_SUB)) then

		result_internal <= std_logic_vector( signed(operand_1) - signed(operand_2) );
		
	elsif ((opcode = OP_SUBI)) then

		result_internal <= std_logic_vector( signed(operand_1) - signed(operand_2) );
		
	elsif ((opcode = OP_BLT)) then

		result_internal <= std_logic_vector( unsigned(operand_1) + unsigned(operand_2));
		
	elsif ((opcode = OP_BE)) then

		result_internal <= std_logic_vector( unsigned(operand_1) + unsigned(operand_2));
		
	elsif ((opcode = OP_JMP)) then

		result_internal <= std_logic_vector( unsigned(operand_1) + unsigned(operand_2));
		
	-- TODO implement remaining operations
			
	-- only OP_HALT should remain
	else
		result_internal <= (13 downto 0 => 'X');

	end if;

end process;

-- TODO implement detection of overflow for all signed arithmetic operations
ofl : process (operand_1, operand_2, result_internal, opcode)
begin

	if ((opcode=OP_ADD) or (opcode=OP_ADDI)) then
		
		if ((operand_1(13)='0' and operand_2(13)='0' and result_internal(13)='1') or ((operand_1(13)='1' and operand_2(13)='1' and result_internal(13)='0'))) then
			
			overflow <= '1';		
		
		end if;
	
	elsif ((opcode=OP_SUB) or (opcode=OP_SUBI)) then
	
		if ((operand_1(13)='1' and operand_2(13)='0' and result_internal(13)='0') or ((operand_1(13)='0' and operand_2(13)='1' and result_internal(13)='1'))) then
			
			overflow <= '1';		
		
		end if;
	
	else
	
		overflow <= '0';	
	
	end if;
end process;

end Behavioral;

