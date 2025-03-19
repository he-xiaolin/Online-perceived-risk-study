import torch
import torch.nn as nn
import torch.nn.functional as F


class MC_Dropout_Model(nn.Module):
    def __init__(self, input_dim, output_dim, num_units, drop_prob):
        super(MC_Dropout_Model, self).__init__()
        

        self.input_dim = input_dim
        self.output_dim = output_dim
        self.drop_prob = drop_prob
        
        # network with two hidden and one output layer
        self.layer1 = nn.Linear(input_dim, num_units)
        self.layer2 = nn.Linear(num_units, num_units)
        self.layer3 = nn.Linear(num_units, 2*output_dim)
        
        self.activation = nn.ReLU(inplace = True)

    
    def forward(self, x):
        
        x = x.view(-1, self.input_dim)
        x_1 = self.layer1(x)
        x_2 = self.activation(x_1)
        x_3 = F.dropout(x_2, p=self.drop_prob, training=True)
        x_4 = self.layer2(x_3)
        x_5 = self.activation(x_4)
        x_6 = F.dropout(x_5, p=self.drop_prob, training=True)
        x_7 = self.layer3(x_6)   # 
        x_8 = 10*torch.sigmoid(x_7[:, :1])
        output = torch.concat((x_8,x_7[:,1:]),1 )
        return output