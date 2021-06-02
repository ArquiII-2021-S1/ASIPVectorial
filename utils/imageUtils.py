
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import sys, getopt

from numpy.lib.arraysetops import unique
from numpy.lib.function_base import append


################################################## Populate ROM ################################################## 
# Obtiene un arreglo de datos dado un archivo de entrada.
def getDicFrom(filename):
    dic = {}
    with open(filename, "r") as fileInput:
        for line in fileInput:
            [address,value] = line.split(':')
            if(int(address) not in dic.keys()):
                dic[int(address)]=int(value)
    return dic

def getPixelArrayFromDumpFile(filename):
    with open(filename, "r") as fileInput:
        lines = []
        for line in fileInput:
            lines.append(int(line.split(':')[1]))
    return lines
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

def populateROM(imageFile, filename1,filename2):
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
    w, h = 200, 200
    data = np.zeros((h, w, 3), dtype=np.uint8)
    index = 0
    for h in range(0, height):
        for w in range(0,width):
            data[h,w]=[channelRed[index],channelGreen[index],channelBlue[index]]
            index = index +1
    image = Image.fromarray(data,"RGB")
    image.show()
    image.save("result.png")

def extractPixelArray(filename):
    array = getImagePixels(filename)
    channelRed = []
    channelGreen = []
    channelBlue = []
    for item in range(0, len(array) ):

        channelRed.append(array[item][0]) # channel red
        channelGreen.append(array[item][1])  # channel green
        channelBlue.append(array[item][2]) # channel blue
    createImage(channelRed, channelGreen, channelBlue, 200, 200)

# g generate ROM files
def main(argv):
    opts, args = getopt.getopt(argv, "g:s:h:", ["generate", "show" , "help"])
    for opt, arg in opts:
        if opt in ("-g", "--generate"):
            populateROM(arg,"./output/rom1.mif","./output/rom2.mif")
        elif opt in ("-s", "--show"):

            dic = getDicFrom(arg)
            pixels = []
            for i in range(0,300000):
                if(i in dic.keys()):
                    pixels.append(dic[i])
                else:
                    pixels.append(0)

            values = list(dic.values()) + list(np.zeros((91,), dtype=int))
            print(len(values))
            channelRed = pixels[131100:171100]
            channelGreen = pixels[171100:211100]
            channelBlue = pixels[211100:251100]


            print(len(channelRed),len(channelGreen), len(channelBlue))
            createImage(channelRed, channelGreen, channelBlue, 200, 200)
        elif opt in ("-h", "--help"):
            print("python3 imageUtils.py -g \"./input/test.png\"")
            print("python3 imageUtils.py -d \"./input/test-dump.txt\"")
if __name__ == "__main__":
   main(sys.argv[1:])



