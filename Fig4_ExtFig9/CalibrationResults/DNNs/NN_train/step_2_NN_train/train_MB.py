# regression model for debug


import pandas as pd
import zipfile
import urllib.request
import os
import GPy
import time
import copy
import math
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.autograd import Variable
from torch.optim import Optimizer
from torch.optim.sgd import SGD
from sklearn.model_selection import KFold
import torch.nn.functional as F
from torchvision import datasets, transforms
from torchvision.utils import make_grid
from tqdm import tqdm, trange
from modules.training_function import train_mc_dropout
from modules.utils import *
import argparse

parser = argparse.ArgumentParser(description='Train a neural network.')
parser.add_argument('--num_epochs', type=int, default=500,
                    help='Number of epochs for training.')
parser.add_argument('--experiment_index', type=str, default='202404-complete_data',
                        help='Index of the experiment.')
args = parser.parse_args()
num_epochs = args.num_epochs
index = args.experiment_index

# np.random.seed(0)
# data = np.load('./data/MB_feature_reg_aug.npy')
data_right = np.load('./data/MB_feature_reg.npy')
data_left  = np.load('./data/MB_feature_reg_aug.npy')
data =  np.concatenate((data_right, data_left), axis=0)


model_name = 'MB'
print(model_name)
event_len = 301

# event_nb = 27
event_nb = 54

print(model_name)
relative_path_fig = './figures'
dir_name_fig = create_directory_with_timestamp(relative_path_fig,index)
print(f"Fig Directory '{dir_name_fig}' created!")

relative_path_models = './models'
dir_name_models = create_directory_with_timestamp(relative_path_models,index)
print(f"Models Directory '{dir_name_models}' created!")

#  num_units=500
net = train_mc_dropout(event_nb, model_name, event_len = event_len, data=data, drop_prob=0.1, 
                       num_epochs=num_epochs, n_splits=4, num_units=500, learn_rate=1e-5,
                       weight_decay=1e-1/len(data)**0.5, num_samples=20, log_every=1,
                       dir_name_fig = dir_name_fig,
                       dir_name_models =dir_name_models)

