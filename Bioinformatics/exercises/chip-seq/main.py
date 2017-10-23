#!/usr/bin/env python
import pprint
import numpy
import operator
from matplotlib import pyplot

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
                    for i in xrange(start_position, end_position + 1):
                        forward[i] += 1
                if read_symbol == "-":
                    for i in xrange(start_position, end_position + 1):
                        reverse[i] += 1

    file.close()
    return forward, reverse


def smooth(p_strand):

    for strand in p_strand:
        for i in xrange(0, len(strand)):

            left_sum = 0
            right_sum = 0
            left_counter = 0
            right_counter = 0

            if i - K < 0:
                left_max = 0
            else:
                left_max = i - K

            if i + K > len(strand) - 1:
                right_max = len(strand)
            else:
                right_max = i + K + 1       # +1 because xrange ignores the last number

            for l in xrange(left_max, i):
                left_sum += strand[l]
                left_counter += 1

            for r in xrange(i + 1, right_max):
                right_sum += strand[r]
                right_counter += 1

            mean = (left_sum + right_sum + strand[i]) / (left_counter + right_counter + 1)
            strand[i] = mean


def get_local_maxima(p_strands):

    local_maximas = []
    for strand in p_strands:
        tmp_maxima = numpy.zeros(1000, dtype=numpy.int)
        for i in range(1, len(strand)):
            if strand[i - 1] <= strand[i] and (i + 1 < len(strand) and strand[i] > strand[i + 1]):
                tmp_maxima[i] = strand[i]

        filter_maxima(tmp_maxima)
        local_maximas.append(tmp_maxima)

    return local_maximas


def filter_maxima(p_maxima):
    for i in range(0, len(p_maxima)):
        if p_maxima[i] < 100:
            p_maxima[i] = 0


def get_result(p_maximas):

    forward = p_maximas[0]
    reverse = p_maximas[1]

    for i in range(0, len(forward)):
        if forward[i] > 0:
            pair = find_pair(reverse, i, 120)
            print "%d #### %d" % (pair[0], pair[1])


def find_pair(p_reverse, i, p_range):
    if i - p_range < 0:
        max_left = 0
    else:
        max_left = i - 120

    if i + p_range > len(p_reverse):
        max_right = len(p_reverse)
    else:
        max_right = i + p_range

    left_index, left_max = max(enumerate(p_reverse[max_left: i]), key=operator.itemgetter(1))
    right_index, right_max = max(enumerate(p_reverse[i: max_right]), key=operator.itemgetter(1))
    left_index += max_left
    right_index += right_max

    stats = {left_index:left_max, i:p_reverse[i], right_index:right_max}

    endpoint = max(stats.iteritems(), key=operator.itemgetter(1))[0]
    if endpoint == 0 and p_range == 120:
        find_pair(p_reverse, i, 200)

    return i, endpoint


def print_graph(p_strands):
    x = p_strands[0]
    y = p_strands[1]

    bins = numpy.linspace(0, len(p_strands[0]), 100)

    pyplot.hist(x, bins, alpha=0.5, label='forward')
    pyplot.hist(y, bins, alpha=0.5, label='reverse')
    pyplot.legend(loc='upper right')
    pyplot.show()


if __name__ == "__main__":
    # 0 - forward
    # 1 - reverse
    strands = read_file()
    smooth(strands)
    maximas = get_local_maxima(strands)
    get_result(maximas)
    # pprint.pprint(maximas)
