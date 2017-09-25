#!/usr/bin/env python
import numpy
from weblogolib import *

INPUT = "data.txt"
CAPITAL_A = 65
ALPHABET_LENGTH = 26

lines = []  # lines read from the file
data = []   # "matrix in our case"


def read_file():
    with open(INPUT, 'r') as file:
        for line in file:
            line = line.rstrip()
            if len(line) > 1:
                lines.append(line)
    file.close()


def print_data():
    i = 0
    header = []
    for a in xrange(CAPITAL_A, CAPITAL_A + ALPHABET_LENGTH):
        header.append(chr(a))
    print '[  ]\t' + '\t'.join(header)

    for row in data:
        print '[' + str(i).zfill(2) + ']\t' + '\t'.join(map(str, row))
        i += 1


def calculate_occurrence():
    for i in xrange(len(lines[0])):
        row = numpy.zeros(ALPHABET_LENGTH)
        for j in xrange(len(lines)):
            index = ord(lines[j][i]) - CAPITAL_A
            row[index] += 1
        data.append(row)


def most_likely_word():
    the_word = ''

    for i in xrange(len(data)):
        max_index = 0
        max_value = 0
        for j in xrange(ALPHABET_LENGTH):
            if max_value < data[i][j]:
                max_value = data[i][j]
                max_index = j
        the_word += chr(CAPITAL_A + max_index)
    return the_word


def generate_png():
    print 'Generating sequence logo'
    input = open(INPUT)
    sequence = read_seq_data(input)
    data = LogoData.from_seqs(sequence)
    l_format = LogoFormat(data, None)
    with open("sequence.png", 'wb') as fout:
        fout.write(png_formatter(data, l_format))


if __name__ == "__main__":
    read_file()
    calculate_occurrence()
    print_data()
    print '\n'
    print 'A) Most likely word is: ' + most_likely_word()
    generate_png()
