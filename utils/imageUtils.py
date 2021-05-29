
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import sys, getopt

from numpy.lib.arraysetops import unique

def getPixelArrayFromDumpFile(filename):
    #fileInput = open(filename, "r")
    with open(filename, "r") as fileInput:
        lines = []
        for line in fileInput:
            #print(line.split(':')[1])
            lines.append(int(line.split(':')[1]))
    return lines

# Esta funcion es usada para tomar dump file y crear un arreglo de valores de pixeles.
def getArrayFromFile(filename):
    #fileInput = open(filename, "r")
    with open(filename, "r") as fileInput:
        lines = []
        for line in fileInput:
            #print(line.split(':')[1])
            lines.append(int(line))
    return lines

def writeImageMif(fileName, pixels):
    # filename: "red.mif"
    # filename: "green.mif"
    # filename: "blue.mif"
    depth = 2 ** 16
    file = open(fileName, "w")
    header = """DEPTH = {}; -- The size of memory in words
    WIDTH = 8; -- The size of data in bits
    ADDRESS_RADIX = DEC; -- The radix for address values
    DATA_RADIX = DEC; -- The radix for data values
    CONTENT -- start of (address : data pairs)
    BEGIN \n""".format(
        depth
    )
    file.write(header + "\n")
    for i in range(0, depth):
        if i < len(pixels):
            file.write(str(i) + " : " + str(pixels[i]) + ";\n")
        else:
            file.write(str(i) + " : " + str(0) + ";\n")

    file.write("END;" + "\n")
    print(""" Archivo generado {filename}""".format(filename = fileName))



def generateMifChannels(filename):
    image = Image.open(filename, "r")
    width, height = image.size
    pixels = list(image.getdata())

    channelRed = []
    channelGreen = []
    channelBlue = []
    for item in range(0, len(pixels) ):
        channelRed.append(pixels[item][0]) # channel red
        channelGreen.append(pixels[item][1])  # channel green
        channelBlue.append(pixels[item][2]) # channel blue
    print("\033[91m")
    writeImageMif("./output/red.mif", channelRed)
    print("\033[92m")
    writeImageMif("./output/green.mif", channelGreen)
    print("\033[96m")
    writeImageMif("./output/blue.mif", channelBlue)
    print("\033[0m")


def plotImage(pixelArray, rows,cols):
    matrix = np.array(pixelArray).reshape(rows,cols)
    plt.subplot()
    plt.imshow(matrix)
    print(len(matrix[0]))
    print(matrix[0][0:10])
    plt.savefig("./output/generated.png")
    plt.show()
    
def show():
    print("Mostrando el resultado")
    channelRed = getPixelArrayFromFile("./input/dumpRed.txt") 
    channelGreen = getPixelArrayFromFile("./input/dumpGreen.txt") 
    channelBlue = getPixelArrayFromFile("./input/dumpBlue.txt")
    unifiedImagePixels = []
    for i in range (0, (200*200)):
        #channelRed[i]/255,channelGreen[i]/255,channelBlue[i]/255)
        pixel = (channelRed[i],channelGreen[i],channelBlue[i])
        unifiedImagePixels.append( pixel )
    print(unifiedImagePixels)
    plotImage(unifiedImagePixels,200,200)
    
def populateROM(imageFile, gradientFilename, customGradientFileName, filename1,filename2):
    image = Image.open(imageFile, "r")
    width, height = image.size
    pixels = list(image.getdata())

    channelRed = []
    channelGreen = []
    channelBlue = []
    for item in range(0, len(pixels) ):
        channelRed.append(pixels[item][0]) # channel red
        channelGreen.append(pixels[item][1])  # channel green
        channelBlue.append(pixels[item][2]) # channel blue
    print(width)
    print(height)


    gradientArray = getArrayFromFile(gradientFilename)
    customGradientArray =getArrayFromFile(customGradientFileName)

    depth = 2 ** 16
    filePart1 = open(filename1, "w")
    header = """DEPTH = {}; -- The size of memory in words
    WIDTH = 8; -- The size of data in bits
    ADDRESS_RADIX = DEC; -- The radix for address values
    DATA_RADIX = DEC; -- The radix for data values
    CONTENT -- start of (address : data pairs)
    BEGIN \n""".format(
        depth
    )
    filePart1.write(header + "\n")

    for i in range (0 , len(gradientArray)): # 0 - 199
        filePart1.write(str(i) + " : " + str(gradientArray[i]) + ";\n")
    
    for j in range (0 , len(customGradientArray)) : # 200 - 399 
        filePart1.write(str(j+200) + " : " + str(customGradientArray[j]) + ";\n")
    
    for r in range (0,len(channelRed)):
        filePart1.write(str(r+400) + " : " + str(channelRed[r]) + ";\n")

    for g in range (0,25136):
        filePart1.write(str(g+40400) + " : " + str(channelGreen[g]) + ";\n")
    filePart1.write("END;" + "\n")
    
    filePart2 = open(filename2, "w")
    header = """DEPTH = {}; -- The size of memory in words
    WIDTH = 8; -- The size of data in bits
    ADDRESS_RADIX = DEC; -- The radix for address values
    DATA_RADIX = DEC; -- The radix for data values
    CONTENT -- start of (address : data pairs)
    BEGIN \n""".format(
        depth
    )
    filePart2.write(header + "\n")

    print(len(channelGreen))
    for g in range (0,25136):
        filePart2.write(str(g) + " : " + str(channelGreen[g+14864]) + ";\n")
    
    for b in range (0,len(channelBlue)):
        filePart2.write(str(b+25136) + " : " + str(channelBlue[b]) + ";\n")
    filePart2.write("END;" + "\n")





populateROM("./input/test.png", "./input/gradient.txt", "./input/customGradient.txt","./output/rom1.mif","./output/rom2.mif")