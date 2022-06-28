package typedefs;

typedef enum 
{INST_ADDR=0,INST_FETCH,INST_LOAD,IDLE,OP_ADDR,OP_FETCH,ALU_OP,STORE}states_t;

typedef enum logic [2:0]
{HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP}opcode_t;
endpackage

