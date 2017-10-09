#!/usr/bin/env python
import numpy
import pprint
import random

INPUT = "bioinformatics_intro_class_de_novo_sequence_logo_discovery_upstreams.fas"
DEBUG_INPUT = "our_data.fas"
sequences = []
BS_LENGTH = 19


def read_file(input_file):
    counter = 1
    with open(input_file, 'r') as file:
        for sequence in file:
            if counter % 2 == 0:
                sequence = sequence.rstrip()
                if len(sequence) > 1:
                    sequences.append(sequence.lower())
            counter += 1
    file.close()


def guess_random_point():
    # return random.randint(0, len(sequences[0]) - BS_LENGTH - 1)
    return 0


def calculate_background(init_position):
    BACKGROUND = {}
    total_count = len(sequences) * len(sequences[0])
    for sequence in sequences:
        for c in sequence:
            if BACKGROUND.has_key(c):
                BACKGROUND[c] += 1
            else:
                BACKGROUND[c] = 1

    for key in BACKGROUND.keys():
        BACKGROUND[key] = round(BACKGROUND[key] / float(total_count), 2)

    return BACKGROUND


def calculate_foreground():
    FOREGROUND = {}
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

    return FOREGROUND


def build_model(init_position, foreground):
    MODEL = {}
    for key in foreground.keys():
        MODEL[key] = foreground[key][init_position: init_position + BS_LENGTH]

    return MODEL


def calculate_motif(sequence, model, start, end):
    motif = 1
    index = 0

    for i in xrange(start, end):
        letter = sequence[i]
        motif = model[letter][index] * motif
        index += 1

    return motif


def calculate_after_motif(background, sequence, start, end):
    after_motif = 1

    for i in xrange(0, len(sequence)):
        if i not in range(start, end):
            after_motif = background[sequence[i]] * after_motif

    return after_motif


def calculate_likelihood(background, model):
    matrix = numpy.zeros(shape=(len(sequences), len(sequences[0]) - BS_LENGTH + 1))
    sequence_counter = 0

    for sequence in sequences:

        for i in xrange(0, len(sequence) - BS_LENGTH + 1):
            motif = calculate_motif(sequence, model, i, i + BS_LENGTH)
            after_motif = calculate_after_motif(background, sequence, i, i + BS_LENGTH)
            matrix[sequence_counter][i] = motif * after_motif

        sequence_counter += 1

    normalize(matrix)

    return matrix


def normalize(matrix):

    j = 0
    for row in matrix:
        matrix[j] = [round(float(i)/sum(row), 2) for i in row]
        j += 1


def recalculate_model(matrix):
    RECALCULATED_SEQ_PROB = []
    RECALCULATED_SEQ = []

    for i in xrange(0, len(matrix)):
        for j in xrange(0, len(matrix[0])):
            if matrix[i][j] > 0:
                RECALCULATED_SEQ_PROB.append(round(matrix[i][j], 2))
                RECALCULATED_SEQ.append(sequences[i][j: j + BS_LENGTH])

    MODEL = {}
    for i in xrange(0, len(RECALCULATED_SEQ[0])):
        for j in xrange(0, len(RECALCULATED_SEQ)):
            letter = RECALCULATED_SEQ[j][i]
            if letter not in MODEL:
                MODEL[letter] = numpy.zeros(BS_LENGTH)

            MODEL[letter][i] += RECALCULATED_SEQ_PROB[j]

    for key in MODEL.keys():
        MODEL.update({key: list(map((lambda x: round(x / len(sequences), 2)), MODEL[key]))})

    return MODEL


def verify_model(prev, model):
    return prev == model


def consensus_sequence(model):
    result = ""

    values = model.values()
    for i in xrange(0, len(values[0])):
        for j in xrange(0, len(values)):
            if values[j][i] == 1.0:
                result += model.keys()[j]

    return result


if __name__ == "__main__":
    read_file(INPUT)
    init_position = guess_random_point()
    background = calculate_background(init_position)
    foreground = calculate_foreground()
    model = build_model(init_position, foreground)

    not_good = True
    prev = {}
    while not_good:
        matrix = calculate_likelihood(background, model)
        model = recalculate_model(matrix)

        if verify_model(prev, model):
            not_good = False

        prev = model

    pprint.pprint(model)
    # print consensus_sequence(model)