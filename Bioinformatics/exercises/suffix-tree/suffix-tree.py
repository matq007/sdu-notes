#!/usr/bin/env python

WORDS = ["banana"]

def strcmp(word1, word2):
    if word1 == word2:
        return 0

    a = ""
    if len(word1) > word2:
        a = word1
    else:
        a = word2

    for i in xrange(len(word2)):
        if a[i] != word2[i]:
            return i

    return -1

def build_tree(tree, word):

    if (len(word)) == 0:
        tree["$"] = []
        return tree

    print word

    """
    if (len(tree)) == 0:
        tree[word] = {}
    else:
        for item in tree.keys():
            position = strcmp(word, item)
            if position == 0:
                continue
            if position == -1:
    """

    return build_tree(tree, word[1:])


if __name__ == "__main__":
    for word in WORDS:
        print "Building suffix-tree for \"%s\"" % word
        tree = {}
        build_tree(tree, word)