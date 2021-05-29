
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import sys, getopt

# Esta funcion es usada para tomar dump file y crear un arreglo de valores de pixeles.
def getPixelArrayFromFile(filename):
    #fileInput = open(filename, "r")
    with open(filename, "r") as fileInput:
        lines = []
        for line in fileInput:
            #print(line.split(':')[1])
            lines.append(int(line.split(':')[1]))
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

    plotImage(pixels, 200)

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


def plotImage(pixelArray, rows):
    matrix = np.resize(pixelArray, (rows, len(pixelArray) // rows))
    plt.subplot()
    plt.imshow(matrix)
    plt.savefig("./output/generated.png")
    plt.show()
    
def show():
    print("Mostrando el resultado")
    channelRed = getPixelArrayFromFile("./input/dumpRed.txt") 
    channelGreen = getPixelArrayFromFile("./input/dumpGreen.txt") 
    channelBlue = getPixelArrayFromFile("./input/dumpBlue.txt")
    unifiedImagePixels = []
    for i in range (0, (200*200) -1):
        unifiedImagePixels.append( [(channelRed[i],channelGreen[i],channelBlue[i])])
    plotImage(unifiedImagePixels,200)
    


def main(argv):
    opts, args = getopt.getopt(argv, "i:s:d:", ["inputFile", "show" , "debug"])
    for opt, arg in opts:
        if opt == '-i':
            # "inputImage.png"
            print(arg)
            generateMifChannels(arg)
        else:
            show()
    

if __name__ == "__main__":
   main(sys.argv[1:])


