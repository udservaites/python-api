'''Unit tests'''
import unittest
import numpy as np

from python_api.utils import array_add, hello_world


class Testing(unittest.TestCase):

    def test_array_add(self):
        nums1 = "2345 5454"
        nums2 = "546546 45654"
        answer = "548891,51108"
        assert array_add(nums1, nums2) == answer


    def test_hello_world(self):
        assert hello_world() == "Hello, World! This is your new project!"


if __name__ == '__main__':
    unittest.main(verbosity=10)