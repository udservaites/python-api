'''numpy module docstring'''
import numpy as np


def array_add(array1, array2):
    '''arrary add function docstring'''
    np_array1 = list(map(int, array1.split(" ")))
    np_array2 = list(map(int, array2.split(" ")))
    sums = np.add(np_array1, np_array2)
    result = ",".join(str(x) for x in sums)
    return result


def hello_world():
    '''hello world api function docstring'''
    return "Hello, World! This is your new project!"
