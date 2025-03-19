
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

def train_mc_dropout(event_nb, model_name, event_len, data, drop_prob, 
                     n_splits, num_epochs, num_units, learn_rate, 
                     weight_decay, log_every, 
                     num_samples,dir_name_fig,dir_name_models):
    
    kf = KFold(n_splits=n_splits,shuffle=True)
    in_dim = data.shape[1] - 1


    best_loss_test = float('inf') 
    for j, idx in enumerate(kf.split(data)):
        print('FOLD %d:' % j)
        train_index, test_index = idx

        np.save(f'{dir_name_models}/{model_name}/train_index.npy', train_index)
        np.save(f'{dir_name_models}/{model_name}/test_index.npy', test_index)

        x_train, y_train = data[train_index, :in_dim], data[train_index, in_dim:]
        x_test, y_test = data[test_index, :in_dim], data[test_index, in_dim:]

        x_means, x_stds = x_train.mean(axis = 0), x_train.var(axis = 0)**0.5
        y_means, y_stds = y_train.mean(axis = 0), y_train.var(axis = 0)**0.5

        x_train = (x_train - x_means)/x_stds
        # y_train = (y_train - y_means)/y_stds
        x_test = (x_test - x_means)/x_stds
        # y_test = (y_test - y_means)/y_stds


        # for final plot
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


        train_losses = []
        train_rmses = []
        test_losses = []
        test_rmses = []
        fit_loss_train = np.zeros(num_epochs)
        best_model_epoch = 0
        for i in range(num_epochs):
            loss = net.fit(x_train, y_train)
            
            test_loss, test_rmse = net.get_loss_and_rmse(x_test, y_test, num_samples=num_samples)
            test_loss, test_rmse = test_loss.cpu().data.numpy(), test_rmse.cpu().data.numpy()

            if test_loss < best_loss_test:
                best_loss_test = test_loss
                torch.save(net.network.state_dict(), f'{dir_name_models}/{model_name}/best_model_{model_name}.pth')
                torch.save(net.network.state_dict(), f'{dir_name_models}/{model_name}/best_model_{model_name}_epoch_{i}.pth')
                current_model = net.network
                eval = False
                plot_all_events(eval, event_nb, 
                                event_len, 
                                model_name, 
                                i, x_all, y_all, 
                                current_model = current_model,
                                dir_name_fig =dir_name_fig)
                best_model_epoch = i
                # print('Epoch %3d is the best epoch' %(best_model_epoch))

            no_use, train_rmse = net.get_loss_and_rmse(x_train, y_train, num_samples=num_samples)
            train_rmse = train_rmse.cpu().data.numpy()

            print('Epoch: %4d, Best Epoch: %4d, Train loss: %6.3f Train RMSE: %.3f Test loss: %6.3f Test RMSE: %.3f' %
                    (i, 
                    best_model_epoch,
                    loss.cpu().data.numpy()/len(x_train),
                    train_rmse*y_stds[0],
                    test_loss/len(x_test), 
                    test_rmse*y_stds[0]))
            train_losses.append(loss.cpu().data.numpy()/len(x_train))
            train_rmses.append(train_rmse*y_stds[0])
            test_losses.append(test_loss/len(x_test))
            test_rmses.append(test_rmse*y_stds[0])
        
        train_losses = np.array(train_losses)
        train_rmses = np.array(train_rmses)
        test_losses = np.array(test_losses)
        test_rmses = np.array(test_rmses)
        data = {
                'train_loss': train_losses,
                'train_rmse': train_rmses,
                'test_loss': test_losses,
                'test_rmsey4': test_rmses
            }
        savemat(f'{dir_name_fig}/{model_name}_loss_rmse_curve.mat', data)
        break  # for K fold   only once
    return net