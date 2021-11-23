# -*-coding:utf-8 -*-
"""
@File    :   process_data.py
@Time    :   2021/11/15 07:44:25
@Author  :   Yujie He
@Version :   1.0
@Contact :   yujie.he@epfl.ch
@State   :   Dev
"""


import numpy as np
import contextlib


#%% split train and test dataset
@contextlib.contextmanager
def temp_seed(seed):
    state = np.random.get_state()
    np.random.seed(seed)
    try:
        yield
    finally:
        np.random.set_state(state)


def train_test_split(data, labels, train_size=0.8, random_seed=0):
    with temp_seed(random_seed):
        indices = np.random.permutation(data.shape[0])
        train_num = round(np.shape(data)[0] * train_size)
        train_idx, test_idx = indices[:train_num], indices[train_num:]
        # data_train, data_test, labels_train, labels_test
        return (
            data[train_idx, :],
            data[test_idx, :],
            labels[train_idx],
            labels[test_idx],
        )


"""
- reference links
    - https://stackoverflow.com/questions/3674409/how-to-split-partition-a-dataset-into-training-and-test-datasets-for-e-g-cros
    - https://stackoverflow.com/questions/49555991/can-i-create-a-local-numpy-random-seed
    - https://towardsdatascience.com/stop-using-numpy-random-seed-581a9972805f
"""
