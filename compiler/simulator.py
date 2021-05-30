from bitstring import BitArray

# Memoria de uso general
RAM = [0] * 262144

# Registros
registers = [0 for x in range(16)] + [ [0] * 20 for x in range(8)]

# Memoria de instrucciones
instr_mem = []

# PC y PC+1
pc = 0
pcPlus1 = 2


def loadVector(base_address):
    result = []

    for i in range(0,20):
        result.append(RAM[base_address + i])
    
    return result

def storeVector(base_address, data):
    for i in range(0,20):
        RAM[base_address + i] = data[i]


def updatePC():
    global pc, pcPlus1
    pc += 1
    pcPlus1 = pc + 2

def NOP():
    updatePC() # Actualizar PC

def bin2int(number):
    return BitArray(bin=number).int

def SAL(label):
    global pc, pcPlus1
    pc = pcPlus1 + bin2int(label)
    pcPlus1 = pc + 2

def SEQ(reg1, reg2, label):
    global pc, pcPlus1

    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Si el valor de los registros es igual, hace el salto
    if(registers[reg1] == registers[reg2]): 
        pc = pcPlus1 + bin2int(label)
        pcPlus1 = pc + 2
    else:
        updatePC()

"""
Funcion para cargar el valor de una direccion en un registro
reg1: registro destino
reg2: registro con la direccion
"""
def CRGE(reg1, reg2):
    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    addr = registers[reg2] # Obtener direccion

    # print(addr)

    registers[reg1] = RAM[addr] # Cargar valor

    updatePC() # Actualizar PC


"""
Funcion para cargar el valor de una direccion en un registro
reg1: registro destino
reg2: registro con la direccion
"""
def CRGV(reg1, reg2):
    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    addr = registers[reg2] # Obtener direccion

    # print("addr: " + str(addr))

    registers[reg1] = loadVector(addr) # Cargar valor

    updatePC() # Update PC

"""
reg1: address
reg2: source
"""
def ALME(reg1, reg2):
    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    addr = registers[reg1] # Obtener direccion

    RAM[addr] = registers[reg2] # Guardar valor

    updatePC() # Update PC


"""
reg1: address
reg2: source
"""
def ALMV(reg1, reg2):
    # Conversion de binario a entero
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    base_addr = registers[reg1]   # Get direction
    data = registers[reg2]        # Get data

    storeVector(base_addr, data)  # Store data 

    updatePC() # Update PC


def SUMEV(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Sum
    op1 = registers[reg1]
    op2 = registers[reg2]
    registers[reg_result] = [ op1[x] + op2 for x in range (len (op1))]

    updatePC() # Actualizar PC

def SUMVV(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Suma de los valores en los registros reg1 y reg2
    op1 = registers[reg1]
    op2 = registers[reg2]
    result = [ op1[x] + op2[x] for x in range (len (op1))]
    registers[reg_result] = result

    updatePC() # Actualizar PC

def SUMEI(reg_result, reg1, imm):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    imm = bin2int(imm)

    # op1 = registers[reg1]
    # registers[reg_result] = [ op1[x] + imm for x in range (len (op1))]
    registers[reg_result] = registers[reg1] + imm

    updatePC() # Actualizar PC

def RESEE(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Suma de los valores en los registros reg1 y reg2
    registers[reg_result] = registers[reg1] - registers[reg2]

    updatePC() # Actualizar PC

def SLV(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Left shift del valor en reg1 un total de imm veces
    op1 = registers[reg1]
    op2 = registers[reg2]
    registers[reg_result] = [ op1[x] << op2 for x in range (len (op1))]

    updatePC() # Actualizar PC


def SRV(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Rigth shift del valor en reg1 un total de imm veces
    op1 = registers[reg1]
    op2 = registers[reg2]
    registers[reg_result] = [ op1[x] >> op2 for x in range (len (op1))]

    updatePC() # Actualizar PC


def SLE(reg_result, reg1, reg2):
    # Conversion de binario a entero
    reg_result = bin2int(reg_result)
    reg1 = bin2int(reg1)
    reg2 = bin2int(reg2)

    # Left shift del valor en reg1 un total de imm veces
    registers[reg_result] = registers[reg1] << registers[reg2]

    updatePC() # Actualizar PC


instructions = {
    "0000" : NOP,
    "0001" : SAL,
    "0010" : SEQ,
    "0011" : CRGE,
    "0100" : CRGV,
    "0101" : ALME,
    "0110" : ALMV,
    "0111" : SUMVV,
    "1000" : SUMEV,
    "1001" : SUMEI,
    "1010" : RESEE,
    "1011" : SRV,
    "1100" : SLV,
    "1101" : SLE,
}

def readInstruction(filename):
    # Apertura del archivo en modo lectura
    fileObject = open(filename, "r")

    # Lectura de cada linea en el archivo
    global instr_mem
    instr_mem = fileObject.read().split("\n")


opNOP   = "0000"
opSAL   = "0001"
opSEQ   = "0010"
opCRGE  = "0011"
opCRGV  = "0100"
opALME  = "0101"
opALMV  = "0110"
opSUMVV = "0111"
opSUMEV = "1000"
opSUMEI = "1001"
opRESEE = "1010"
opSRV   = "1011"
opSLV   = "1100"
opSLE   = "1101"

cycles = 0


def simulate():
    global pc
    readInstruction("instructions.txt")
    lenm = len(instr_mem)-1
    while pc < lenm:
        instr = instr_mem[pc]  # Se obtiene la instruccion

        global registers
        reg = registers

        # Instrucciones generales
        opcode  = instr[0:4]
        reg_des = "0" + instr[4:9]
        reg_src = "0" + instr[9:14]
        reg     = "0" + instr[14:19]

        # Saltos
        imm = instr[19:32]

        global cycles
        cycles += 1

        # Instrucciones de cargar memoria
        if opcode in (opCRGE, opCRGV):
            instructions[opcode](reg_des, reg_src)

        # Instrucciones de almacenar en memoria
        elif opcode in (opALME, opALMV):
            instructions[opcode](reg_src, reg)
        
        # Instrucciones de procesamiento de datos
        elif opcode in (opSUMEV, opSUMVV, opRESEE, opSRV, opSLV, opSLE):
            instructions[opcode](reg_des, reg_src, reg)
        
        # Instrucciones de procesamiento de datos con inmediato
        elif opcode in (opSUMEI):
            instructions[opcode](reg_des, reg_src, imm)
        
        # Instruccion de salto no condicional
        elif opcode in (opSAL):
            instructions[opcode](imm)
        
        # Instrucciones de salto condicional
        elif opcode in (opSEQ):
            instructions[opcode](reg_src, reg, imm)        

        # Instruccion NOP
        else:
            instructions[opcode]()
