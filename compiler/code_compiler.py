import sys


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
SUMEE = "SUMEE"
RESEE = "RESEE"
SRV   = "SRV"
SLV   = "SLV"
SLE   = "SLE"


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
    SUMEE : "1010",
    RESEE : "1011",
    SRV   : "1100",
    SLV   : "1101",
    SLE   : "1110",
}

# Dictionary with the register's code
registers = {
    "RE0"  : "00000",
    "RE1"  : "00001",
    "RE2"  : "00010",
    "RE3"  : "00011",
    "RE4"  : "00100",
    "RE5"  : "00101",
    "RE6"  : "00110",
    "RE7"  : "00111",
    "RE8"  : "01000",
    "RE9"  : "01001",
    "RE10" : "01010",
    "RE11" : "01011",
    "RE12" : "01100",
    "RE13" : "01101",
    "RE14" : "01110",
    "RE15" : "01111",
    "RV0"  : "10000",
    "RV1"  : "10001",
    "RV2"  : "10010",
    "RV3"  : "10011",
    "RV4"  : "10100",
    "RV5"  : "10101",
    "RV6"  : "10110",
    "RV7"  : "10111",
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
    | 31-28  |  27-23   |  22-18  | 17-13 |   12-0    |
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
    instr_reg_dest = "00000"
    instr_reg_src  = "00000"
    instr_reg      = "00000"
    instr_imm      = "0" * 13

    # Gets the operation code
    instr_opcode = getInstructionCode(opname)

    # Gets the register's code
    if reg_dest != None : instr_reg_dest = registers[reg_dest]
    if reg_src != None: instr_reg_src = registers[reg_src]
    if reg != None: instr_reg = registers[reg]
    
    # Get the binary equivalent for the immediate
    if imm != None: instr_imm = decimalToBinary(imm, 13)

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
            elif opname in (SUMEV, SUMVV, SUMEE, RESEE, SRV, SLV, SLE):
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
    header = """WIDTH=32;\nDEPTH=4096;\n\nADDRESS_RADIX=DEC;\nDATA_RADIX=BIN;\nCONTENT BEGIN"""
    file.write(header + "\n")
    for i in range(0, len(program)):
        file.write(str(i)+" : "+program[i] + ";\n")
    file.write("END;" + "\n")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Please enter code filepath")
    else:
        filepath = sys.argv[1]
        compile(filepath)