
import os
import numpy as np
import pandas as pd
import pickle
import torch
import shap
import sys 
sys.path.append("../4-BNN_prediction/") 
from modules.MC_Dropout_Model import MC_Dropout_Model
from modules.utils import *
from modules.MC_Dropout_Wrapper import MC_Dropout_Wrapper
import matplotlib.pyplot as plt
from scipy.io import savemat


def generate_prediction(input):
    input_tensor = torch.tensor(input, dtype=torch.float)
    # input_tensor = torch.FloatTensor(input)
    global best_model
    with torch.no_grad():
        predictions = best_model(input_tensor)
    # Depending on your needs, you can return predictions or uncertainties
    # predictin mean: predictions[:, :1].numpy()
    output = predictions[:, :1].numpy()
    return output


def shap_cal(model_name, data, K, event_id, event_duration, event_numb, feature_names):
    in_dim = data.shape[1] - 1   # input dimension
    x_all, y_all =  data[:, :in_dim], data[:, in_dim:]
    x_all_means, x_all_stds = x_all.mean(axis = 0), x_all.var(axis = 0)**0.5
    x_all = (x_all - x_all_means)/x_all_stds  # standard by means nad stds
    samples_selected = shap.sample(x_all, K) 

    # explainer = shap.KernelExplainer(generate_prediction, samples_selected)
    # test_instance = samples_selected  
    # shap_values = explainer.shap_values(test_instance)
    # shap.initjs()

    # shap_data_all_random = {
    # "samples_selected": samples_selected,
    # "explainer": explainer,
    # "test_instance": test_instance,
    # "shap_values": shap_values
    # }

    # file_path = f'{model_name}/shap_data_all_random.pkl'
    # with open(file_path, 'wb') as file:
    #     pickle.dump(shap_data_all_random, file)

    with open('AMB/shap_data_all_random.pkl', 'rb') as file:
        shap_data_all_random = pickle.load(file)

    samples_selected = shap_data_all_random["samples_selected"]
    explainer = shap_data_all_random["explainer"]
    test_instance = shap_data_all_random["test_instance"]
    shap_values = shap_data_all_random["shap_values"]
    shap.initjs()


# #  selected events results
#     for event_id in range(1, event_numb + 1):  
#         start = (event_id - 1) * event_duration
#         end = event_id * event_duration
#         event_samples = x_all[start:end]
#         # test for instance order
#         order_test_output = generate_prediction(event_samples)
#         plt.plot(order_test_output)
#         file_name = f"{model_name}/shap_ts_heatmap_{event_id}_prediction.pdf" 
#         plt.savefig(file_name, dpi=600, bbox_inches='tight')
#         plt.close()
#         # Compute SHAP values for the current event samples
#         shap_values_event = explainer.shap_values(event_samples)
#         shap_data_event = { "event_samples": event_samples,
#                             "explainer": explainer,
#                             "shap_values_event": shap_values_event
#                             }
#         file_name = f"{model_name}/shap_data_event_{event_id}.pkl" 
#         with open(file_name, 'wb') as file:
#             pickle.dump(shap_data_event, file)

#         expl = shap.Explanation(values=shap_values_event[0], feature_names=feature_names)
#         plt.figure(figsize=(10, 5)) 
#         shap.plots.heatmap(expl, max_display= 20, instance_order = np.arange(0, event_duration))
#         file_name = f"{model_name}/shap_ts_heatmap_{event_id}.pdf" 
#         plt.savefig(file_name, dpi=600, bbox_inches='tight')
#         plt.close()

    explanation = shap.Explanation(values=shap_values[0][:,:], 
                               base_values=explainer.expected_value[:],  
                               data=test_instance, 
                               feature_names=feature_names)
    file_name = f"{model_name}/explanation.mat" 
    savemat(file_name, {'explanation': explanation.data})

    plt.figure(figsize=(6, 4))
    shap.plots.bar(explanation, max_display=10,show=False)
    # shap.plots.beeswarm(explanation, show=False)
    file_path = f'{model_name}/shap_bar_all_random.pdf'
    plt.savefig(file_path ,dpi=600, bbox_inches='tight')
    plt.close()


# # two feature coupled
#     test_instance_df = pd.DataFrame(data=test_instance, columns=feature_names)
#     plt.figure(figsize=(6, 4))
#     shap.dependence_plot(1, shap_values[0], test_instance_df, interaction_index = "$Iv_{x,n}$", show=False)
#     file_path = f'{model_name}/shap_coupled_all_random.pdf'
#     plt.savefig(file_path ,dpi=600, bbox_inches='tight')
#     plt.close()
    return shap_values


path_data = '../4-BNN_prediction/data/AMB_feature_reg.npy'
data = np.load(path_data)
model_name = 'AMB'
K = 1500  # sampling K points from all data, all data size is 8127
event_id = 1  # it can visualize one event's time series shap value for all NN input features
event_duration = 301  # it is fixed in each scenario  amb is 301
event_numb = 27
path_best_weight = '../4-BNN_prediction/models/20231219_2222/AMB/best_model_AMB.pth'
best_model = MC_Dropout_Model(input_dim=data.shape[1]-1, output_dim=1, num_units=500, drop_prob=0.1)
best_model.load_state_dict(torch.load(path_best_weight))
best_model.eval()
feature_names = ["$v_{x,s}$",
                    "$v_{x,n}$",
                    "$v_{x,n2}$",
                    "$v_{y,s}$",
                    "$a_{x,s}$",
                    "$a_{x,n}$",
                    "$a_{x,n2}$",
                    "$a_{y,s}$",
                    "$\Delta_x$",
                    "$\Delta_y$",
                    "$\Delta_{x2}$",
                    "$\Delta_{y2}$",
                    "$Iv_{x,n}$",
                    "$Iv_{y,n}$",
                    "$Iv_{x,s}$",
                    "$Iv_{y,s}$",
                    "$Iv_{x,n2}$",
                    "$Iv_{y,n2}$",
                    "$DRAC_{Rx}$",
                    "$DRAC_{Ry}$",
                    "$DRAC_{Ry2}$",
                    "$DRAC_{Ix}$",
                    "$DRAC_{Iy}$",
                    "$DRAC_{Iy2}$",
                    "$\Delta_{vx}$",
                    "$\Delta_{vy}$",
                    "$\Delta_{ax}$",
                    "$\Delta_{ay}$",
                    "$\Delta_{vx2}$",
                    "$\Delta_{vy2}$",
                    "$\Delta_{ax2}$",
                    "$\Delta_{ay2}$",
                    ]
shap_values = shap_cal(model_name = model_name,
                       data=data,
                       K = K,
                       event_id = event_id,
                       event_duration = event_duration,
                       event_numb = event_numb,
                       feature_names = feature_names)


