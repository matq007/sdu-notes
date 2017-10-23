#!/usr/bin/env python
import pprint
import numpy

INPUT = "input.txt"
K = 5


def read_file():
    forward = numpy.zeros(1000, dtype=numpy.int)
    reverse = numpy.zeros(1000, dtype=numpy.int)

    with open(INPUT, 'r') as file:
        for line in file:
            line = line.rstrip()
            line = line.split(" ")

            start_position = int(line[0])
            end_position = int(line[1])
            read_symbol = line[2]

            if len(line) > 1:
                if read_symbol == "+":
                    forward[start_position] += 1
                    forward[end_position] += 1
                if read_symbol == "-":
                    reverse[start_position] += 1
                    reverse[end_position] += 1

    file.close()
    return forward, reverse


def smooth(p_strand):
    for i in xrange(0, len(p_strand)):

        left_sum = 0
        right_sum = 0
        left_counter = 0
        right_counter = 0

        if i - K < 0:
            left_max = 0
        else:
            left_max = i - K

        if i + K > len(p_strand) - 1:
            right_max = len(p_strand)
        else:
            right_max = i + K + 1   # +1 because xrange ignores the last number

        for l in xrange(left_max, i):
            left_sum += p_strand[l]
            left_counter += 1

        for r in xrange(i + 1, right_max):
            right_sum += p_strand[r]
            right_counter += 1

        mean = (left_sum + right_sum + p_strand[i]) / (left_counter + right_counter + 1)
        p_strand[i] = mean

    return 0


if __name__ == "__main__":
    # 0 - forward
    # 1 - reverse
    strands = read_file()
    smooth(strands[0])
    smooth(strands[1])
    pprint.pprint(strands)
