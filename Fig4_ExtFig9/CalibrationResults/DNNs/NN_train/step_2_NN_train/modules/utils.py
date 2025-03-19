from torch.autograd import Variable
import torch
import numpy as np
import matplotlib.pyplot as plt
import datetime
import os
from scipy.io import savemat
from mpl_toolkits.mplot3d import Axes3D



def create_directory_with_timestamp(relative_path,index):
   
    # Create the path under ./figures
    dir_path = os.path.join(relative_path, index)
    dir_path_AMB = os.path.join(dir_path, 'AMB')
    dir_path_HB  = os.path.join(dir_path, 'HB')
    dir_path_MAL_1 = os.path.join(dir_path, 'MAL_1')
    dir_path_MAL_2 = os.path.join(dir_path, 'MAL_2')
    dir_path_MAL_3 = os.path.join(dir_path, 'MAL_3')
    dir_path_MB  = os.path.join(dir_path, 'MB')

    # Make the directory if it doesn't exist
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)
        os.makedirs(dir_path_AMB)
        os.makedirs(dir_path_HB)
        os.makedirs(dir_path_MAL_1)
        os.makedirs(dir_path_MAL_2)
        os.makedirs(dir_path_MAL_3)
        os.makedirs(dir_path_MB)
    return dir_path  # Return the full path of the directory

def to_variable(var=(), cuda=False, volatile=False):
    out = []
    for v in var:
        
        if isinstance(v, np.ndarray):
            v = torch.from_numpy(v).type(torch.FloatTensor)

        if not v.is_cuda and cuda:
            v = v.cuda()

        if not isinstance(v, Variable):
            v = Variable(v, volatile=volatile)

        out.append(v)
    return out


def log_gaussian_loss(output, target, sigma, no_dim):
    exponent = -0.5*(target - output)**2/sigma**2
    log_coeff = -no_dim*torch.log(sigma) - 0.5*no_dim*np.log(2*np.pi)
    DELTA_ =((target - output)**2).detach().numpy()
    exponent_ = exponent.detach().numpy()
    sigma_ = sigma.detach().numpy()
    sigma2_ = (sigma**2).detach().numpy()

    return - (log_coeff + exponent).sum()


def get_kl_divergence(weights, prior, varpost):
    prior_loglik = prior.loglik(weights)
    varpost_loglik = varpost.loglik(weights)
    varpost_lik = varpost_loglik.exp()
    return (varpost_lik*(varpost_loglik - prior_loglik)).sum()


class gaussian:
    def __init__(self, mu, sigma):
        self.mu = mu
        self.sigma = sigma
        
    def loglik(self, weights):
        exponent = -0.5*(weights - self.mu)**2/self.sigma**2
        log_coeff = -0.5*(np.log(2*np.pi) + 2*np.log(self.sigma))
        
        return (exponent + log_coeff).sum()


def plot_all_events(eval, event_nb, event_len, model_name, epoch, x_all, y_all, current_model,dir_name_fig):
    plt.figure(figsize=(20, 15))  # control size

    uncertain_input = x_all
    uncertain_output = y_all
    uncertain_input,uncertain_output = to_variable(var=(uncertain_input,uncertain_output), cuda=False)
    samples = []
    noises = []
    for i in range(50):
        preds = current_model.forward(uncertain_input).cpu().data.numpy()
        samples.append(preds[:, 0])
        noises.append(np.exp(preds[:, 1]))
    
    samples = np.array(samples)
    noises = np.array(noises)
    means_ = (samples.mean(axis = 0)).reshape(-1)

    aleatoric_ = (noises**2).mean(axis = 0)**0.5
    epistemic_ = (samples.var(axis = 0)**0.5).reshape(-1)
    
    

    for ind in range(event_nb):

        # x_train = x_all[ind*event_len:(ind+1)*event_len,:]
        means = means_[ind*event_len:(ind+1)*event_len]
        y_train = y_all[ind*event_len:(ind+1)*event_len,:]

        aleatoric = aleatoric_[ind*event_len:(ind+1)*event_len]
        epistemic = epistemic_[ind*event_len:(ind+1)*event_len]
        total_unc = (aleatoric**2 + epistemic**2)**0.5



        c = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd',
                '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf']
        
        time_ = means.shape[0]
        time_inds = np.linspace(0, time_, time_,endpoint = False)
       
        # plt.subplot(5, 6, ind+1)
        plt.subplot(6, 9, ind+1)
        if ind==0:
            plt.plot(time_inds, y_train,label = 'label',color = 'black', alpha = 0.5)
            plt.fill_between( time_inds, means + aleatoric, means + total_unc, color = c[0], alpha = 0.3, label = 'Epistemic + Aleatoric')
            plt.fill_between( time_inds, means - total_unc, means - aleatoric, color = c[0], alpha = 0.3)
            plt.fill_between( time_inds, means - aleatoric, means + aleatoric, color = c[1], alpha = 0.4, label = 'Aleatoric')
            plt.plot( time_inds, means, label = 'Prediction',color = 'red', linewidth = 1)
            plt.ylim([0, 10])
            plt.xlabel('Times')
            # plt.title('MC dropout', fontsize=40)
            plt.legend(fontsize=10) 
        else:
            plt.plot(time_inds, y_train,label = 'label',color = 'black', alpha = 0.5)
            plt.fill_between( time_inds, means + aleatoric, means + total_unc, color = c[0], alpha = 0.3, label = 'Epistemic + Aleatoric')
            plt.fill_between( time_inds, means - total_unc, means - aleatoric, color = c[0], alpha = 0.3)
            plt.fill_between( time_inds, means - aleatoric, means + aleatoric, color = c[1], alpha = 0.4, label = 'Aleatoric')
            plt.plot( time_inds, means, label = 'Prediction',color = 'red', linewidth = 1)
            plt.ylim([0, 10])
            plt.xlabel('Times')
    if eval:
        plt.savefig(f'{dir_name_fig}/{model_name}_Best.png', dpi=300)  # control dpi
        mean_temp = means_.reshape(-1, 1)
        EU_temp = epistemic_.reshape(-1, 1)
        AU_temp = aleatoric_.reshape(-1, 1)

        data = {
        'prediction': mean_temp,
        'epistemic': EU_temp,
        'aleatoric': AU_temp,
        'label': y_all,
            }
        savemat(f'{dir_name_fig}/{model_name}.mat', data)
    else:
        plt.savefig(f'{dir_name_fig}/{model_name}/epoch_{epoch}.png', dpi=300)  # control dpi
    plt.close()



def plot_one_event_field(eval, event_idx, event_len, x_all_original, x_means, x_stds,  model_name, epoch, x_all, y_all, current_model,dir_name_fig):


    
    for ts in np.arange(150,event_len):
        plt.figure(figsize=(20, 15))  # control size
        predicted_risk = []
        for delta_lateral in np.arange(-20, 0, 1):
            for delta_longitu in np.arange(3, 20, 1):

                input_event_1_ts = x_all_original[[event_idx*event_len + ts], :]
                input_event_1_ts[:,7] = delta_longitu
                input_event_1_ts[:,8] = delta_lateral
                input_event_1_ts[:,-5] = 0
                input_event_1_ts = (input_event_1_ts - x_means)/x_stds

                tensor_input_event_1_ts, tensor_input_event_1_ts = to_variable(var=(input_event_1_ts, input_event_1_ts), cuda=False)
                preds = current_model.forward(tensor_input_event_1_ts).cpu().data.numpy()
                predicted_risk.append(preds[:, 0])


        X, Y = np.meshgrid(np.arange(-20, 0, 1), np.arange(3, 20, 1))
        Z = np.array(predicted_risk).reshape(X.shape)
        
        fig = plt.figure()
        ax = fig.add_subplot(111, projection='3d')  # Add a 3D subplot

        # Scatter plot
        sc = ax.scatter(X.flatten(), Y.flatten(), Z.flatten(), c=Z.flatten(), cmap='viridis', marker='o')

        # Setting the labels
        ax.set_ylabel('Delta Longitudinal')
        ax.set_xlabel('Delta Lateral')
        ax.set_zlabel('Predicted Risk')
        # Adding a color bar
        plt.colorbar(sc, ax=ax, label='Predicted Risk')
        dir_field = f'{dir_name_fig}/field/{event_idx}/'
        if not os.path.exists(dir_field):
            os.makedirs(dir_field, exist_ok=True)

        ax.view_init(elev=0, azim=0) # first dim view
        file_path = f'{dir_field}field_{ts}_view_1.png'
        plt.savefig(file_path, dpi=100)  # control dpi

        ax.view_init(elev=0, azim=90) #  second dim view
        file_path = f'{dir_field}field_{ts}_view_2.png'
        plt.savefig(file_path, dpi=100)  # control dpi

        ax.view_init(elev=90, azim=-90) # top view
        file_path = f'{dir_field}field_{ts}_view_3.png'
        plt.savefig(file_path, dpi=100)  # control dpi


        ax.view_init(elev=20, azim=-30)  # side view
        file_path = f'{dir_field}field_{ts}_view_4.png'
        plt.savefig(file_path, dpi=100)  # control dpi



        plt.close()
