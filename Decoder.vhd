library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.common.all;

entity Decoder is
	port ( 	instruction_in : in STD_LOGIC_VECTOR (15 downto 0);

		opcode_out : out opcode_type;

		Rd_addr_out : out STD_LOGIC_VECTOR (2 downto 0);
		Rs1_addr_out : out STD_LOGIC_VECTOR (2 downto 0);
		Rs2_addr_out : out STD_LOGIC_VECTOR (2 downto 0);

		immediate_out : out STD_LOGIC_VECTOR (13 downto 0)
	     );
end Decoder;

architecture Behavioral of Decoder is

--TODO add signals as needed
signal opcode_internal : opcode_type;
signal Rd_addr_internal : STD_LOGIC_VECTOR (2 downto 0);
signal Rs1_addr_internal : STD_LOGIC_VECTOR (2 downto 0);
signal Rs2_addr_internal : STD_LOGIC_VECTOR (2 downto 0);
signal tail_internal : STD_LOGIC_VECTOR (2 downto 0);
signal immediate_internal : STD_LOGIC_VECTOR (13 downto 0);

begin
			opcode_out <= opcode_internal;
			
			Rd_addr_out <= Rd_addr_internal;
			
			Rs1_addr_out <= Rs1_addr_internal; 
			
			Rs2_addr_out <= Rs2_addr_internal;
			immediate_out <= immediate_internal;

		
			opcode_internal <= std_logic_vector_to_opcode_type( instruction_in(15 downto 12) );
			
			Rd_addr_internal <= std_logic_vector( instruction_in(11 downto 9) );
			
			Rs1_addr_internal <= std_logic_vector( instruction_in(8 downto 6) );
			
			Rs2_addr_internal <= std_logic_vector( instruction_in(5 downto 3) );
			
			tail_internal <= std_logic_vector( instruction_in(2 downto 0) );
			
		process (opcode_internal)
		begin	
			case opcode_internal is
				when OP_ANDI =>
					immediate_internal <= (7 downto 0 => '1') & Rs2_addr_internal & tail_internal;
				
				when OP_ORI | OP_XORI =>
					immediate_internal <= (7 downto 0 => '0') & Rs2_addr_internal & tail_internal;
				
				when OP_SLL | OP_SRL =>
					immediate_internal <= (10 downto 0 => '0') & tail_internal;
			
				when OP_ADDI | OP_SUBI =>
					if (Rs2_addr_internal(2)='0') then
						immediate_internal <= (7 downto 0 => '0') & Rs2_addr_internal & tail_internal;
					elsif(Rs2_addr_internal(2)='1') then
						immediate_internal <= (7 downto 0 => '1') & Rs2_addr_internal & tail_internal;
					end if;
				when OP_BLT | OP_BE | OP_JMP =>
					if (Rd_addr_internal(2)='0') then
						immediate_internal <= (7 downto 0 => '0') & Rd_addr_internal & tail_internal;
					elsif(Rd_addr_internal(2)='1') then
						immediate_internal <= (7 downto 0 => '1') & Rd_addr_internal & tail_internal;
					end if;
					
				when others =>
					immediate_internal <= (13 downto 0 => '0');
			end case;
		end process;	
		



			--TODO implement extraction of remaining parts of the instruction

			--TODO derive immediate value, depending on opcode_internal

end Behavioral;
