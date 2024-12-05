import scipy.io as io
import numpy as np
import os


Input_Dic_name = '../../3-Feature_extraction/processed_feature_v4/AMB/regression_input/'
Label_Dic_name = '../../3-Feature_extraction/processed_feature_v4/AMB/regression_label/'

Input_File_name_list = os.listdir(Input_Dic_name)
Input_File_name_list.sort()
Input_File_name_list= [ i for i in Input_File_name_list if 'AMB' in i ]

Label_File_name_list = os.listdir(Label_Dic_name)
Label_File_name_list.sort()
Label_File_name_list= [ i for i in Label_File_name_list if 'AMB' in i ]

clip_nb = 5
input_feature_cut = []
AMB_feature_reg = []

for ind, File_name in enumerate(Input_File_name_list):  # event files   1-27
    Input_File_address = Input_Dic_name + File_name
    print('Current Input file name:',File_name)
    mat_file = io.loadmat(Input_File_address)

    Label_File_address = Label_Dic_name + Label_File_name_list[ind]
    print('Current label file name:',Label_File_name_list[ind])
    mat_file_label = io.loadmat(Label_File_address)
    Label = np.transpose(mat_file_label['AMB_rating'])



    Time = np.transpose(mat_file['Time'])
   

    vx_s = np.transpose(mat_file['vx_s'])
    vx_n = np.transpose(mat_file['vx_n'])
    vx_n2 = np.transpose(mat_file['vx_n2'])
    
    ax_s = np.transpose(mat_file['ax_s'])
    ax_n = np.transpose(mat_file['ax_n'])
    ax_n2 = np.transpose(mat_file['ax_n2'])


    vy_s = np.transpose(mat_file['vy_s'])
    vy_n = np.transpose(mat_file['vy_n'])
    vy_n2 = np.transpose(mat_file['vy_n2'])


    ay_s = np.transpose(mat_file['ay_s'])
    ay_n = np.transpose(mat_file['ay_n'])
    ay_n2 = np.transpose(mat_file['ay_n2'])


    delta_x = np.transpose(mat_file['delta_x'])
    delta_y = np.transpose(mat_file['delta_y'])
    delta_x2 = np.transpose(mat_file['delta_x2'])
    delta_y2 = np.transpose(mat_file['delta_y2'])

    v_In_x= np.transpose(mat_file['v_In_x'])
    v_In_y = np.transpose(mat_file['v_In_y'])
    v_Is_x = np.transpose(mat_file['v_Is_x'])
    v_Is_y = np.transpose(mat_file['v_Is_y'])
    v_In2_x = np.transpose(mat_file['v_In2_x'])
    v_In2_y = np.transpose(mat_file['v_In2_y'])


    DRAC_Rx= np.transpose(mat_file['DRAC_Rx'])
    DRAC_Ix = np.transpose(mat_file['DRAC_Ix'])
    DRAC_Ry = np.transpose(mat_file['DRAC_Ry'])
    DRAC_Iy = np.transpose(mat_file['DRAC_Iy'])
    DRAC_Rx2 = np.transpose(mat_file['DRAC_Rx2'])
    DRAC_Ix2 = np.transpose(mat_file['DRAC_Ix2'])
    DRAC_Ry2 = np.transpose(mat_file['DRAC_Ry2'])
    DRAC_Iy2 = np.transpose(mat_file['DRAC_Iy2'])


    # newly added delta v, delta a
    delta_vx= np.transpose(mat_file['delta_vx'])
    delta_vy= np.transpose(mat_file['delta_vy'])
    delta_ax= np.transpose(mat_file['delta_ax'])
    delta_ay= np.transpose(mat_file['delta_ay'])
    delta_vx2= np.transpose(mat_file['delta_vx2'])
    delta_vy2= np.transpose(mat_file['delta_vy2'])
    delta_ax2= np.transpose(mat_file['delta_ax2'])
    delta_ay2= np.transpose(mat_file['delta_ay2'])


  # input feature      
    feature_all_clip = np.concatenate((vx_s,
                                       vx_n,
                                       vx_n2,
                                       vy_s,
                                       # vy_n,
                                       # vy_n2,
                                       ax_s,
                                       ax_n,
                                       ax_n2,
                                       ay_s,
                                       #ay_n,
                                       #ay_n2,
                                       delta_x,
                                       delta_y,
                                       delta_x2,
                                       delta_y2,
                                       v_In_x,
                                       v_In_y,
                                       v_Is_x,
                                       v_Is_y,
                                       v_In2_x,
                                       v_In2_y,
                                       DRAC_Rx,
                                       #  DRAC_Rx2,
                                       DRAC_Ry,
                                       DRAC_Ry2,
                                       DRAC_Ix,
                                      #  DRAC_Ix2,
                                       DRAC_Iy,
                                       DRAC_Iy2,
                                      delta_vx,
                                      delta_vy,
                                      delta_ax,
                                      delta_ay,
                                      delta_vx2,
                                      delta_vy2,
                                      delta_ax2,
                                      delta_ay2,
                                       )
                                    ,axis=1)

    # label feature
    # time_steps_nb = 301

    label_all_clip = Label
    comb_temp = np.concatenate((feature_all_clip,label_all_clip),axis=1)
    AMB_feature_reg.append(comb_temp)
        
    
feature_len = comb_temp.shape[-1]
print('AMB_feature Type:',type(AMB_feature_reg))
AMB_feature_reg = np.array(AMB_feature_reg).reshape(-1,feature_len)
np.save('../data/AMB_feature_reg.npy',AMB_feature_reg)

