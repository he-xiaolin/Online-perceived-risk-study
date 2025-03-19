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

parser.add_argument('--experiment_index', type=str, default='20230920_2121',
                        help='Index of the experiment.')
args = parser.parse_args()
index = args.experiment_index
data = np.load('./data/MAL_feature_reg_2.npy')
model_name = 'MAL_2'
print('Evaluating',model_name)
event_len = 361
event_nb = 6

path_train_index = os.path.join('./models', index, model_name,'train_index.npy')
train_index = np.load(path_train_index)
path_test_index = os.path.join('./models', index, model_name,'test_index.npy')
test_index = np.load(path_test_index)

dir_name_eval_fig = os.path.join('./figures', index)
path_weights = os.path.join('./models', index, model_name,f'best_model_{model_name}.pth')

net = eval(event_nb, model_name, 
        event_len = event_len, data=data, 
        drop_prob=0.1, num_units=500, 
        learn_rate=1e-5, weight_decay=1e-1/len(data)**0.5, 
        num_samples=20, dir_name_eval_fig = dir_name_eval_fig,
        path_weights = path_weights,
        train_index = train_index, test_index = test_index)



