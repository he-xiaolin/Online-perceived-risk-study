
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
import sys 
sys.path.append("../") 
from modules.MC_Dropout_Model import MC_Dropout_Model
from modules.utils import *
from modules.MC_Dropout_Wrapper import MC_Dropout_Wrapper

def eval_field(event_nb, model_name, 
         event_len, data, 
         drop_prob, num_units, 
         learn_rate, weight_decay, 
         num_samples, dir_name_eval_fig,
         path_weights,
         train_index, test_index):
    
    in_dim = data.shape[1] - 1
    
    x_train, y_train = data[train_index, :in_dim], data[train_index, in_dim:]
    x_test, y_test = data[test_index, :in_dim], data[test_index, in_dim:]
    
    x_means, x_stds = x_train.mean(axis = 0), x_train.var(axis = 0)**0.5
    y_means, y_stds = y_train.mean(axis = 0), y_train.var(axis = 0)**0.5

    x_train = (x_train - x_means)/x_stds
    x_test = (x_test - x_means)/x_stds
    x_all, y_all =  data[:, :in_dim], data[:, in_dim:]
    x_all = (x_all - x_means)/x_stds
    y_stds[0] = 1
    print(x_train.shape, y_train.shape)

    batch_size = len(x_train)
    model = MC_Dropout_Model(input_dim=in_dim, output_dim=1, num_units=num_units, drop_prob=drop_prob)
    net = MC_Dropout_Wrapper(network=model,
                            learn_rate=learn_rate, 
                            batch_size=batch_size, 
                            weight_decay=weight_decay)

    net.network.load_state_dict(torch.load(path_weights))
    current_model = net.network
    i = 000
    eval = True

    event_idx = 0
    plot_one_event_field(eval, event_idx, 
                         event_len, data[:, :in_dim], 
                         x_means, x_stds, 
                         model_name, 
                         i, x_all, y_all, 
                         current_model = current_model,
                         dir_name_fig =dir_name_eval_fig)

    
    return net