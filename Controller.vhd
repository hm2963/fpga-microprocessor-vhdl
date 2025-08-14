library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.common.all;

entity Controller is
	port ( 	opcode : in opcode_type;

	 	operand_1 : out STD_LOGIC_VECTOR (13 downto 0);
	 	operand_2 : out STD_LOGIC_VECTOR (13 downto 0);

	 	result : in STD_LOGIC_VECTOR (13 downto 0);

		curr_PC : in STD_LOGIC_VECTOR (6 downto 0);

		new_PC : out STD_LOGIC_VECTOR (6 downto 0);
		PC_we : out STD_LOGIC;
		PC_incr : out STD_LOGIC;

		Rs1_data : in STD_LOGIC_VECTOR (13 downto 0);
		Rs2_data : in STD_LOGIC_VECTOR (13 downto 0);
		immediate : in STD_LOGIC_VECTOR (13 downto 0);

		Rd_we : out STD_LOGIC;
		Rd_data : out STD_LOGIC_VECTOR (13 downto 0)
	     );
end Controller;

architecture Behavioral of Controller is

begin

control : process (opcode, Rs1_data, Rs2_data, result, immediate, curr_PC)
begin
	-- default assignments, can be overwritten below
	operand_1 <= Rs1_data;
	operand_2 <= Rs2_data;

	Rd_we <= '0';
	Rd_data <= result;

	PC_we <= '0';
	new_PC <= (6 downto 0 => 'X');

	PC_incr <= '0';

	-- regular operations with Rs1, Rs2, Rd
	-- TODO consider remaining cases
	case opcode is
	when OP_ADDI | OP_ANDI | OP_ORI | OP_XORI | OP_SLL | OP_SRL | OP_SUBI =>
			operand_1 <= Rs1_data;
			operand_2 <= immediate;
			Rd_data <= result;
			Rd_we <= '1';
			PC_incr <= '1';
			
		when OP_ADD | OP_AND | OP_OR | OP_XOR | OP_SUB =>
			Rd_we <= '1';
			PC_incr <= '1';
	
		when OP_BLT =>
		
			if (Rs1_data < Rs2_data) then
				PC_we <= '1';
				operand_1 <= (6 downto 0 => '0') & curr_PC;
				operand_2 <= immediate;
				new_PC <= std_logic_vector( result(6 downto 0) ); --std_logic_vector(unsigned(curr_PC) + unsigned(immediate));
			else 
				--PC_we <= '1';
				PC_incr <= '1';
			end if;
	
		when OP_BE =>
			Rd_we <= '0';
			if (Rs1_data = Rs2_data) then
				PC_we <= '1';
				operand_1 <= (6 downto 0 => '0') & curr_PC;
				operand_2 <= immediate;
				new_PC <= std_logic_vector( result(6 downto 0) ); --std_logic_vector(unsigned(curr_PC) + unsigned(immediate));
			else 
				PC_we <= '0';
				PC_incr <= '1';
			end if;
		 
		when OP_JMP =>
				PC_we <= '1';
				operand_1 <= (6 downto 0 => '0') & curr_PC;
				operand_2 <= immediate;
				new_PC <= std_logic_vector( result(6 downto 0) ); --std_logic_vector(unsigned(curr_PC) + unsigned(immediate));
		-- TODO implement remaining cases
	 
		-- only OP_HALT should remain
		when others =>
			operand_1 <= (13 downto 0 => 'X');
			operand_2 <= (13 downto 0 => 'X');

			Rd_data <= (13 downto 0 => 'X');
	end case;
end process;

end Behavioral;

