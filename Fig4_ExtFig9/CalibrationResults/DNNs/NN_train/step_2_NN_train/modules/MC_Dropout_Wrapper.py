import torch
from .MC_Dropout_Model import MC_Dropout_Model
from .utils import *
import os
import sys

class MC_Dropout_Wrapper:
    def __init__(self, network, learn_rate, batch_size, weight_decay):
        
        self.learn_rate = learn_rate
        self.batch_size = batch_size
        self.network = network
    
        self.optimizer = torch.optim.SGD(self.network.parameters(), lr=learn_rate, weight_decay=weight_decay)
        # self.optimizer = torch.optim.SGD(self.network.parameters(), lr=learn_rate)
        self.loss_func = log_gaussian_loss
    
    def fit(self, x, y):
        x, y = to_variable(var=(x, y), cuda=False)
        
        # reset gradient and total loss
        self.optimizer.zero_grad()
        
        output = self.network(x)
        # if np.isnan(output.detach().numpy()).any():
        #     print('BNN output have Nan')
        #     os._exit(0)
        var = output[:, 1:].detach().numpy()
        loss = self.loss_func(output[:, :1], y, output[:, 1:].exp(), 1)
        loss.backward()
        self.optimizer.step()

        return loss
    
    def get_loss_and_rmse(self, x, y, num_samples):
        x, y = to_variable(var=(x, y), cuda=False)
        
        means, stds = [], []
        for i in range(num_samples):
            output = self.network(x)
            means.append(output[:, :1])
            stds.append(output[:, 1:].exp())
        
        means, stds = torch.cat(means, dim=1), torch.cat(stds, dim=1)
        mean = means.mean(dim=-1)[:, None]
        std = ((means.var(dim=-1) + stds.mean(dim=-1)**2)**0.5)[:, None]
        loss = self.loss_func(mean, y, std, 1)
        
        rmse = ((mean - y)**2).mean()**0.5

        return loss.detach().cpu(), rmse.detach().cpu()