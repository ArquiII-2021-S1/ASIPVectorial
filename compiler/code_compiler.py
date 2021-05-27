# Name of the instructions
NOP   = "NOP"
SAL   = "SAL"
SEQ   = "SEQ"
CRGE  = "CRGE"
CRGV  = "CRGV"
ALME  = "ALME"
ALMV  = "ALMV"
SUMVV = "SUMVV"
SUMEV = "SUMEV"
SUMEI = "SUMEI"
RESEE = "RESEE"
SRL   = "SRL"
SLL   = "SLL"

# Dictionary with the instruction's code
instructions = {
    NOP   : "0000",
    SAL   : "0001",
    SEQ   : "0010",
    CRGE  : "0011",
    CRGV  : "0100",
    ALME  : "0101",
    ALMV  : "0110",
    SUMVV : "0111",
    SUMEV : "1000",
    SUMEI : "1001",
    RESEE : "1010",
    SRL   : "1011",
    SLL   : "1100",
}

# Dictionary with the register's code
registers = {
    "RE0" : "0000",
    "RE1" : "0001",
    "RE2" : "0010",
    "RE3" : "0011",
    "RE4" : "0100",
    "RE5" : "0101",
    "RE6" : "0110",
    "RE7" : "0111",
    "RV0" : "1000",
    "RV1" : "1001",
    "RV2" : "1010",
    "RV3" : "1011",
    "RV4" : "1100",
    "RV5" : "1101",
    "RV6" : "1110",
    "RV7" : "1111"
}

labels = {}        # Dictionary where the labels are stored
program = []       # List where the encoded instructions are stored
lineCodeCount = 0  # Total of instructions
branch_instr = []  # List where the branch instructions are stored

"""
Compiles the code
filename: string with the filepath
"""
def compile(filename):
    # Opens the file in read mode
    fileObject = open(filename, "r")

    # Reads every line in the file
    lines = fileObject.read().split("\n") 

    # Compiles data processing and memory instructions
    for i in range(0, len(lines)):
        analyzeLine(lines[i])

    # Compiles branch instructions
    analyzeBranch()

    # Writes the binary code in files
    writeCodeMif()
    writeCode()

"""
Funcion para agregar un nuevo label en el diccionario, 
se hace una verificacion que no haya sido declarado antes
label: elemento que se desea agregar
"""
def addLabel(label):
    # Se verifica que el label no haya sido declarado antes
    if label in labels:
        error = ": Label '" + str(label) + "' ya ha sido declarado antes."
        raise Exception(error)
    else:
        # Se agrega el label apuntando a la siguiente instruccion
        labels[label] = lineCodeCount + 1 

"""
Funcion para obtener el codigo de una instruccion, se verificacion
que el nombre ingresado exista
opname: string con el nombre de la instruccion
"""
def getInstructionCode(opname):
    if opname not in instructions:
        raise Exception("Instruccion '" + opname + "' no existe")
    else:
        return instructions[opname]

"""
Funcion para convertir un numero decimal a binario, utilizando una cantidad 
definida de bits, extendiendo las posiciones restantes segun el signo
bits: numero de bits en el que debe ser representado el numero binario
number: string con el numero que se debe convertir
"""
def decimalToBinary(number, bits):
    s = bin(int(number) & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

"""
This function encodes an instruction using the general structure
    | 31-28  |  27-24   |  23-20  | 19-16 |   15-0    |
    | OpCode | REG_DEST | REG_SRC |  REG  | Label/Imm |

opname:     string with the operation
reg_dest:   destiny register 
reg_src:    first operand
reg:        second operand
imm:        immediate

return:     encoded instruction
"""
def enconde_instr(opname, reg_dest, reg_src, reg, imm):
    # Default values
    instr_reg_dest = "0000"
    instr_reg_src  = "0000"
    instr_reg      = "0000"
    instr_imm      = "0" * 16

    # Gets the operation code
    instr_opcode = getInstructionCode(opname)

    # Gets the register's code
    if reg_dest != None : instr_reg_dest = registers[reg_dest]
    if reg_src != None: instr_reg_src = registers[reg_src]
    if reg != None: instr_reg = registers[reg]
    
    # Get the binary equivalent for the immediate
    if imm != None: instr_imm = decimalToBinary(imm, 16)

    instr = instr_opcode + \
            instr_reg_dest + \
            instr_reg_src + \
            instr_reg + \
            instr_imm

    return instr

"""
Funcion para analizar cada linea del codigo, se compila a lenguaje maquina
si es posible, si se trata de un branch se guarda para compilarlo al final
line: linea que debe ser analizada
"""
def analyzeLine(line):
    # Se divide la linea utilizando espacios como delimitador
    content = line.split(" ")

    # Se eliminan los strings vacios de la lista
    content = list(filter(lambda a: a != '', content))

    if len(content) > 0:
        # Se verifica si el primer elemento es un label
        if content[0] not in instructions and len(content) == 1:
            # Se agrega el label al diccionario
            addLabel(content[0])

        else: # Se trata de una instruccion
            global lineCodeCount
            lineCodeCount += 1
            opname = content[0] # Se obtiene la instruccion
            
            # Load instructions
            if opname in (CRGE, CRGV):
                reg_dest = content[1]
                reg_src  = content[2]
                instr = enconde_instr(opname, reg_dest, reg_src, None, None)
                program.append(instr)
            
            # Store instructions
            elif opname in (ALME, ALMV):
                reg_t    = content[1]
                reg_src  = content[2]
                instr = enconde_instr(opname, None, reg_t, reg_src, None)
                program.append(instr)

            # Data processing instructions
            elif opname in (SUMEV, SUMVV, RESEE, SRL, SLL):
                reg_dest = content[1]
                reg_src  = content[2]
                reg      = content[3]
                instr = enconde_instr(opname, reg_dest, reg_src, reg, None)
                program.append(instr)

            # Add with immediate
            elif opname in (SUMEI):
                reg_dest = content[1]
                reg_src  = content[2]
                imm      = content[3]
                instr = enconde_instr(opname, reg_dest, reg_src, None, imm)
                program.append(instr)

            # Branch instructions are encoded at the end
            elif opname in (SAL, SEQ):
                # Adds the instruction to the branch list
                branch_instr.append([content, lineCodeCount])

            # NOP instruction
            elif opname == NOP:
                instr = enconde_instr(opname, None, None, None, None)
                program.append(instr)

            else:
                raise Exception("Instruccion '" + opname + "' no existe")

"""
Funcion que se ejecuta al final del analisis para compilar las instrucciones de salto
"""
def analyzeBranch():
    for i in range(0,len(branch_instr)):
        instr = branch_instr[i][0]      # Se obtiene la instruccion sin codificar
        lineNum = branch_instr[i][1]    # Se obtiene el numero de linea de la instruccion
        opname = instr[0]               # Nombre de la operacion
        label = instr[-1]               # Direccion de salto
        codedInstr = ""

        # Verificacion que el label exista
        if label not in labels:
            raise Exception("Label '" + label + "' no declarado")
        
        labelLine = labels[label] # Obtener linea donde apunta el label
        branchDirection = labelLine - (lineNum+2) # Obtener cantidad de saltos 
        
        if opname == SAL:
            # Codificacion de branch no condicional
            codedInstr = enconde_instr(opname, None, None, None, branchDirection)

        else:
            # Codificacion de branch condicional
            reg1 = instr[1]
            reg2 = instr[2]
            codedInstr = enconde_instr(opname, None, reg1, reg2, branchDirection)
        
        # Se inserta la instruccion en la posicion que le corresponde
        program.insert(lineNum-1, codedInstr)

"""
Escribe el codigo compilado en un archivo de texto
"""
def writeCode():
    file = open("instructions.txt", "w")
    for i in range(0, len(program)):
        file.write(program[i] + "\n")

"""
Escribe el codigo compilado en un archivo .mif
"""
def writeCodeMif():
    file = open("instructions.mif", "w")
    header = """DEPTH = 4096; -- The size of memory in words
    WIDTH = 32; -- The size of data in bits 
    ADDRESEES_RADIX = DEC; -- The radix for addRESEEs values 
    DATA_RADIX = BIN; -- The radix for data values 
    CONTENT -- start of (addRESEEs : data pairs) 
    BEGIN"""
    file.write(header + "\n")
    for i in range(0, len(program)):
        file.write(str(i)+" : "+program[i] + ";\n")
    file.write("END;" + "\n")
