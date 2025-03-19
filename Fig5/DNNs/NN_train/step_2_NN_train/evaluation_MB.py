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

from torchvision import datasets, transforms
from torchvision.utils import make_grid
from tqdm import tqdm, trange
from modules.training_function import train_mc_dropout
from modules.utils import *
import argparse
from modules.evaluating_function import eval

parser = argparse.ArgumentParser(description='Train a neural network.')

parser.add_argument('--experiment_index', type=str,  default='202404-complete_data',
                        help='Index of the experiment.')
args = parser.parse_args()
index = args.experiment_index

# data = np.load('./data/MB_feature_reg_aug.npy')
data_right = np.load('./data/MB_feature_reg.npy')
data_left  = np.load('./data/MB_feature_reg_aug.npy')
data =  np.concatenate((data_right, data_left), axis=0)

model_name = 'MB'
print('Evaluating',model_name)
event_len = 301
# event_nb = 27
event_nb = 54
path_train_index = os.path.join('./models', index, model_name,'train_index.npy')
train_index = np.load(path_train_index)
path_test_index = os.path.join('./models', index, model_name,'test_index.npy')
test_index = np.load(path_test_index)

dir_name_eval_fig = os.path.join('./figures', index)
path_weights = os.path.join('./models', index, model_name,f'best_model_{model_name}.pth')


#num_units=500 
net = eval(event_nb, model_name, 
        event_len = event_len, data=data, 
        drop_prob=0.1, num_units=500, 
        learn_rate=1e-5, weight_decay=1e-1/len(data)**0.5, 
        num_samples=20, dir_name_eval_fig = dir_name_eval_fig,
        path_weights = path_weights,
        train_index = train_index, test_index = test_index)



