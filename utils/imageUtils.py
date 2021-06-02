
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import sys, getopt

from numpy.lib.arraysetops import unique
# Obtiene un arreglo de datos dado un archivo de entrada.
def getPixelArrayFromDumpFile(filename):
    with open(filename, "r") as fileInput:
        lines = []
        for line in fileInput:
            lines.append(int(line.split(':')[1]))
    return lines



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

################################################## Populate ROM ################################################## 


# retorna un arreglo con los pixeles de la imagen [ [R, G, B] ]
def getImagePixels(imageFile):
    image = Image.open(imageFile, "r")
    width, height = image.size
    pixels = list(image.getdata())
    return pixels



# Escribe lineas de memoria
def writeArrayToMif(file, startIndex, endIndex, array):
    index = 0
    for i in range (startIndex , endIndex): # starIndex ---> endIndex-1
        file.write(str(i) + " : " + str(array[index]) + ";\n")
        index = index + 1

# Esta funcion es usada para tomar dump file y crear un arreglo de valores de pixeles.
def getArrayFromFile(filename):
    #fileInput = open(filename, "r")
    with open(filename, "r") as fileInput:
        lines = []
        for line in fileInput:
            #print(line.split(':')[0])
            lines.append(int(line))
    return lines


def populateROM(imageFile, gradientFilename, customGradientFileName, filename1,filename2):
    gradient25FileName = "./input/gradient-25.txt"
    gradient25Array = getArrayFromFile(gradient25FileName)

    gradient75FileName = "./input/gradient-75.txt"
    gradient75Array = getArrayFromFile(gradient75FileName)
    
    gradient100FileName = "./input/gradient-100.txt"
    gradient100Array = getArrayFromFile(gradient100FileName)


    customGradient25FileName = "./input/custom-gradient-25.txt"
    customGradient25Array = getArrayFromFile(customGradient25FileName)

    customGradient75FileName = "./input/custom-gradient-75.txt"
    customGradient75Array = getArrayFromFile(customGradient75FileName)

    customGradient100FileName = "./input/custom-gradient-100.txt"
    customGradient100Array = getArrayFromFile(customGradient100FileName)


    pixels = getImagePixels(imageFile)
    channelRed = []
    channelGreen = []
    channelBlue = []
    for item in range(0, len(pixels) ):
        channelRed.append(pixels[item][0]) # channel red
        channelGreen.append(pixels[item][1])  # channel green
        channelBlue.append(pixels[item][2]) # channel blue

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

    # degradado normal del 25% 
    writeArrayToMif(filePart1,0,200,gradient25Array)
    # degradado normal del 75% 
    writeArrayToMif(filePart1,200,400,gradient75Array)
    # degradado normal del 100% 
    writeArrayToMif(filePart1,400,600,gradient100Array)

    # degradado personalizado del 25% 
    writeArrayToMif(filePart1,600,800,customGradient25Array)
    # degradado personalizado del 75% 
    writeArrayToMif(filePart1,800,1000,customGradient75Array)
    # degradado personalizado del 100% 
    writeArrayToMif(filePart1,1000,1200,customGradient100Array)

    #canal red
    writeArrayToMif(filePart1,1200,41200,channelRed)
    
    #canal green parte 1
    writeArrayToMif(filePart1,41200,65536,channelGreen[:24336])

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
    offset = 0

    #canal green parte 2
    writeArrayToMif(filePart2,offset+0,offset+15664,channelGreen[24336:])
    
    #canal blue
    writeArrayToMif(filePart2,offset+15664,offset+55664,channelBlue)

    # empty mem
    writeArrayToMif(filePart2,offset+55664,offset+65536,np.zeros((9872,), dtype=int))

    filePart2.write("END;" + "\n")

def createImage( channelRed, channelGreen, channelBlue, width, height):
    pixels = []

    #data = np.zeros((height, width, 3), dtype=np.uint8)
    index = 0
    for h in range(0 , height):
        row = []
        for w in range(0 , width):
            row.append([channelRed[index],channelGreen[index],channelBlue[index]])
            index = index + 1
        pixels.append(row)    
    image = Image.fromarray(np.asarray(pixels), "RGB")
    image.show()



def extractPixelArray(filename):
    array = getImagePixels(filename)
    channelRed = []
    channelGreen = []
    channelBlue = []
    for item in range(0, len(array) ):

        channelRed.append(array[item][0]) # channel red
        channelGreen.append(array[item][1])  # channel green
        channelBlue.append(array[item][2]) # channel blue
    createImage(channelRed, channelGreen, channelBlue, 7, 7)




populateROM("./input/test.png", "./input/gradient.txt", "./input/customGradient.txt","./output/rom1.mif","./output/rom2.mif")
extractPixelArray("./input/btimap.png")

