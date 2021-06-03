from simulator import simulate, RAM, registers


"""
Loads file's data into the memory, starting with an offset
"""
def loadData(filename, offset):
    file = open(filename, "r")      # Opens the file
    data = file.read().split(" ")   # Splits the text

    for i in range(len(data)):
        RAM[offset + i] = int(data[i])   # Stores the data


def load():
    loadData("../files/degraded-25.txt", 0)
    loadData("../files/degraded-75.txt", 200)
    loadData("../files/degraded-100.txt", 400)
    loadData("../files/custom-degraded-25.txt", 600)
    loadData("../files/custom-degraded-75.txt", 800)
    loadData("../files/custom-degraded-100.txt", 1000)
    loadData("../files/image.txt", 1200)


    RAM[261100] = 1  # Red channel intensity
    RAM[261101] = 1  # Green channel intensity
    RAM[261102] = 3  # Blue channel intensity
    RAM[261104] = 3  # Filter



load()
simulate()


# print("RE1: " + str(registers[1]))   # RE1
# print(registers[2])   # RE2
# print("RE3: " + str(registers[3]))   # RE3
# print(registers[5])   # RE5
# print("RE6:  " + str(registers[6]))   # RE6
# print("RE7:  " + str(registers[7]))   # RE7
# print(registers[8])   # RE8
# print("RE9:  " + str(registers[9]))   # RE9
# print("RE10: " + str(registers[10]))  # RE10
# print(registers[12])  # RE12
# print(registers[13])  # RE13
# print("RE14: " + str(registers[14]))  # RE14
# print("RE15: " + str(registers[15]))  # RE15

# print("RV1: " + str(registers[17]))  # RV1
# print(registers[18])  # RV2
# print(registers[19])  # RV3


heading = \
"""
# Created by Octave 6.2.0, Sat May 29 22:41:41 2021 GMT <unknown@DESKTOP-01LM6L0>
# name: vector
# type: matrix
# rows: 1
# columns: 40000

"""

# """
file = open("red.img", "w")
file.write(heading)
for i in range(0,200*200):
    file.write(str(RAM[131100 + i]) + " ")
file.close()


file = open("green.img", "w")
file.write(heading)
for i in range(0,200*200):
    file.write(str(RAM[171100 + i]) + " ")
file.close()


file = open("blue.img", "w")
file.write(heading)
for i in range(0,200*200):
    file.write(str(RAM[211100 + i]) + " ")
file.close()
# """


# print((RAM[131100:131420]))
# print((RAM[131300:131340]))
# print((RAM[170900:170940]))
