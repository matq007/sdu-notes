#!/usr/bin/env python
import numpy
import pprint

INPUT = "bioinformatics_intro_class_de_novo_sequence_logo_discovery_upstreams.fas"
DEBUG_INPUT = "our_data.fas"
sequences = []
ALPHABET = 4
BS_LENGTH = 4
BACKGROUND = {}
FOREGROUND = {}
MODEL = {}
LIKELIHOOD = {}

def read_file():
    counter = 1
    with open(DEBUG_INPUT, 'r') as file:
        for sequence in file:
            if counter % 2 == 0:
                sequence = sequence.rstrip()
                if len(sequence) > 1:
                    sequences.append(sequence.lower())
            counter += 1
    file.close()


def guess_random_point():
    # return random.randint(0, len(sequences[0]) - BS_LENGTH - 1)
    return 4


def calculate_background(init_position):
    total_count = len(sequences) * len(sequences[0])
    for sequence in sequences:
        for c in sequence:
            if BACKGROUND.has_key(c):
                BACKGROUND[c] += 1
            else:
                BACKGROUND[c] = 1

    for key in BACKGROUND.keys():
        BACKGROUND[key] = round(BACKGROUND[key] / float(total_count), 2)


def calculate_foreground():
    for i in xrange(0, len(sequences[0])):
        for j in xrange(0, len(sequences)):
            letter = sequences[j][i]
            if FOREGROUND.has_key(letter):
                FOREGROUND[letter][i] += 1
            else:
                FOREGROUND[letter] = numpy.zeros(len(sequences[0]))
                FOREGROUND[letter][i] = 1

    for key in FOREGROUND.keys():
        for i in xrange(0, len(FOREGROUND[key])):
            FOREGROUND[key][i] = round(FOREGROUND[key][i] / float(len(sequences)), 2)


def build_model(init_position):
    for key in FOREGROUND.keys():
        MODEL[key] = FOREGROUND[key][init_position: init_position + BS_LENGTH]


def calculate_motif(sequence, start, end):
    motif = 1
    index = 0

    for i in xrange(start, end):
        letter = sequence[i]
        motif = MODEL[letter][index] * motif
        index += 1

    return motif


def calculate_after_motif(sequence, start, end):
    after_motif = 1

    for i in xrange(0, len(sequence)):
        if i not in range(start, end):
            after_motif = BACKGROUND[sequence[i]] * after_motif

    return after_motif


def calculate_likelihood():
    matrix = numpy.zeros(shape=(len(sequences), len(sequences[0]) - BS_LENGTH + 1))
    sequence_counter = 0

    for sequence in sequences:

        motif = 0
        after_motif = 0

        for i in xrange(0, len(sequence) - BS_LENGTH + 1):
            motif = calculate_motif(sequence, i, i + BS_LENGTH)
            after_motif = calculate_after_motif(sequence, i, i + BS_LENGTH)
            matrix[sequence_counter][i] = motif * after_motif

        sequence_counter += 1

    return matrix


def normalize(matrix):

    j = 0
    for row in matrix:
        matrix[j] = [round(float(i)/sum(row), 2) for i in row]
        j += 1


if __name__ == "__main__":
    read_file()
    init_position = guess_random_point()
    calculate_background(init_position)
    calculate_foreground()
    build_model(init_position)
    matrix = calculate_likelihood()
    normalize(matrix)
    pprint.pprint(matrix)





