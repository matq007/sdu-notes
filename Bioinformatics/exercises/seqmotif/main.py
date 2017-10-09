#!/usr/bin/env python
import numpy
import pprint

INPUT = "bioinformatics_intro_class_de_novo_sequence_logo_discovery_upstreams.fas"
DEBUG_INPUT = "our_data.fas"
lines = []
ALPHABET = 4
BS_LENGTH = 19
BACKGROUND = {}
FOREGROUND = {}


def guess_random_point():
    # return random.randint(0, len(lines[0]) - BS_LENGTH - 1)
    return 4


def calculate_background(init_position):
    total_count = len(lines) * len(lines[0])
    for line in lines:
        for c in line:
            if BACKGROUND.has_key(c):
                BACKGROUND[c] += 1
            else:
                BACKGROUND[c] = 1

    for key in BACKGROUND.keys():
        BACKGROUND[key] = BACKGROUND[key] / float(total_count)


def calculate_foreground():
    for i in xrange(0, len(lines[0])):
        for j in xrange(0, len(lines)):
            letter = lines[j][i]
            if FOREGROUND.has_key(letter):
                FOREGROUND[letter][i] += 1
            else:
                FOREGROUND[letter] = numpy.zeros(len(lines[0]))
                FOREGROUND[letter][i] = 1

    for key in FOREGROUND.keys():
        for i in xrange(0, len(FOREGROUND[key])):
            FOREGROUND[key][i] = round(FOREGROUND[key][i] / float(len(lines)), 2)


def read_file():
    counter = 1
    with open(DEBUG_INPUT, 'r') as file:
        for line in file:
            if counter % 2 == 0:
                line = line.rstrip()
                if len(line) > 1:
                    lines.append(line.lower())
            counter += 1
    file.close()


if __name__ == "__main__":
    read_file()
    init_position = guess_random_point()
    calculate_background(init_position)
    calculate_foreground()
    pprint.pprint(FOREGROUND)


