import scipy.io as io
import numpy as np
import os


Input_Dic_name = '../../3-Feature_extraction/processed_feature_v4/MAL_1/regression_input/'
Label_Dic_name = '../../3-Feature_extraction/processed_feature_v4/MAL_1/regression_label/'

Input_File_name_list = os.listdir(Input_Dic_name)
Input_File_name_list.sort()
Input_File_name_list= [ i for i in Input_File_name_list if 'MAL' in i ]

Label_File_name_list = os.listdir(Label_Dic_name)
Label_File_name_list.sort()
Label_File_name_list= [ i for i in Label_File_name_list if 'MAL' in i ]

clip_nb = 5
input_feature_cut = []
MAL_feature_reg = []

for ind, File_name in enumerate(Input_File_name_list):  # event files   1-27
    Input_File_address = Input_Dic_name + File_name
    print('Current Input file name:',File_name)
    mat_file = io.loadmat(Input_File_address)

    Label_File_address = Label_Dic_name + Label_File_name_list[ind]
    print('Current label file name:',Label_File_name_list[ind])
    mat_file_label = io.loadmat(Label_File_address)
    Label = np.transpose(mat_file_label['MAL_1_rating'])



    Time = np.transpose(mat_file['Time'])
    # x_s = np.transpose(mat_file['x_s'])
    # x_n = np.transpose(mat_file['x_n'])


    vx_s = np.transpose(mat_file['vx_s'])
    vx_n = np.transpose(mat_file['vx_n'])
    
    ax_s = np.transpose(mat_file['ax_s'])
    ax_n = np.transpose(mat_file['ax_n'])


    # y_s = np.transpose(mat_file['y_s'])
    # y_n = np.transpose(mat_file['y_n'])


    vy_s = np.transpose(mat_file['vy_s'])
    vy_n = np.transpose(mat_file['vy_n'])


    ay_s = np.transpose(mat_file['ay_s'])
    ay_n = np.transpose(mat_file['ay_n'])


    delta_x = np.transpose(mat_file['delta_x'])
    delta_y = np.transpose(mat_file['delta_y'])


    v_In_x= np.transpose(mat_file['v_In_x'])
    v_In_y = np.transpose(mat_file['v_In_y'])
    v_Is_x = np.transpose(mat_file['v_Is_x'])
    v_Is_y = np.transpose(mat_file['v_Is_y'])


    DRAC_Rx= np.transpose(mat_file['DRAC_Rx'])
    DRAC_Ix = np.transpose(mat_file['DRAC_Ix'])
    DRAC_Ry = np.transpose(mat_file['DRAC_Ry'])
    DRAC_Iy = np.transpose(mat_file['DRAC_Iy'])


   # newly added delta v, delta a
    delta_vx= np.transpose(mat_file['delta_vx'])
    delta_vy= np.transpose(mat_file['delta_vy'])
    delta_ax= np.transpose(mat_file['delta_ax'])
    delta_ay= np.transpose(mat_file['delta_ay'])

  # input feature      
    feature_all_clip = np.concatenate((vx_s,
                                       vx_n,
                                       #  vy_s,
                                       vy_n, #check
                                       ax_s,
                                       ax_n,
                                      # ay_s,
                                      ay_n,  #check 
                                       delta_x,
                                       delta_y,
                                       v_In_x,
                                       v_In_y,
                                       v_Is_x,
                                       v_Is_y,
                                       DRAC_Rx,
                                       DRAC_Ry,
                                       DRAC_Ix,
                                       DRAC_Iy,
                                       delta_vx,
                                      delta_vy,
                                      delta_ax,
                                      delta_ay,
                                       )
                                    ,axis=1)



    label_all_clip = Label
    comb_temp = np.concatenate((feature_all_clip,label_all_clip),axis=1)
    MAL_feature_reg.append(comb_temp)
      
feature_len = comb_temp.shape[-1]
print('MAL_feature Type:',type(MAL_feature_reg))
MAL_feature_reg = np.array(MAL_feature_reg).reshape(-1,feature_len)
np.save('../data/MAL_feature_reg_1.npy',MAL_feature_reg)


