using CSV
using DataFrames
using JuliaMBD
using JuliaMBD.Diagram

@model ENG_MNT_F_PNT begin
    @parameter begin
        d_Fr_ENG_mount = 1825.3
        k_Fr_ENG_mount = 1.3598e+05
        z_k_Fr_ENG_mount_ini = 0.00036769
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "ENG_MNT_F_PNT")
end

@model ENG_MNT_R_PNT begin
    @parameter begin
        d_Rr_ENG_mount = 5215
        k_Rr_ENG_mount = 6.7992e+5
        z_k_Rr_ENG_mount_ini = 0
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "ENG_MNT_R_PNT")
end

@model pitch_rate begin
    @parameter begin
        I_ENG2Fr_mount = 0
        I_ENG2Rr_mount = -0.4
        i_center_ENG = 100
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "pitch_rate")
end

@model v_z_carbody begin
    @parameter begin
        M_ENG = 50
        g = 9.8
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "v_z_carbody")
end

@model z_velocity begin
    @parameter begin
        I_ENG2Fr_ENG_mount = 0
        I_ENG2Rr_ENG_mount = -0.4
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "z_velocity")
end

@model ENG_PNT begin
    @xmlmodel("METI_Vertical_Vibration.drawio", "ENG_PNT")
end

@model HM_BD_F_PNT begin
    @parameter begin
        M_Fr_body = 44.01
        g = 9.8
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_BD_F_PNT")
end

@model HM_HD_F_PNT begin
    @parameter begin
        M_Fr_head = 27.6
        r_Fr_head = 0.21857
        theta_Fr_head = 1.3251
        k_Fr_head = 1210
        d_Fr_head = 8.17
        I_Fr_head = 1.8
        x_k_Fr_head_ini = -0.011885
        g = 9.8
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_HD_F_PNT")
end

@model HM_VS_F_PNT begin
    @parameter begin
        kz_Fr_body_organs = 82200
        dz_Fr_body_organs = 195
        M_Fr_body_organs = 12.8
        g = 9.8
        z_kz_Fr_body_organs_ini = 0.001526
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_VS_F_PNT")
end

@model HM_F_PNT begin
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_F_PNT")
end

###

@model HM_BD_R_PNT begin
    @parameter begin
        M_Rr_body = 44.01
        g = 9.8
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_BD_R_PNT")
end

@model HM_HD_R_PNT begin
    @parameter begin
        M_Rr_head = 27.6
        r_Rr_head = 0.21857
        theta_Rr_head = 1.3251
        k_Rr_head = 1210
        d_Rr_head = 8.17
        I_Rr_head = 1.8
        x_k_Rr_head_ini = -0.011885
        g = 9.8
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_HD_R_PNT")
end

@model HM_VS_R_PNT begin
    @parameter begin
        kz_Rr_body_organs = 82200
        dz_Rr_body_organs = 195
        M_Rr_body_organs = 12.8
        g = 9.8
        z_kz_Rr_body_organs_ini = 0.001526
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_VS_R_PNT")
end

@model HM_R_PNT begin
    @xmlmodel("METI_Vertical_Vibration.drawio", "HM_R_PNT")
end

###

@model MUS_F_PNT begin
    @parameter begin
        g = 9.8
        M_Fr_wheel = 40
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "MUS_F_PNT") 
end

###

@model MUS_R_PNT begin
    @parameter begin
        g = 9.8
        M_Rr_wheel = 40
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "MUS_R_PNT") 
end

###

@model RD_PNT begin
    df = CSV.read("road_surface.csv", DataFrame)
    @parameter begin
        kmph2mps = 0.27778
        I_wheelbase = 2.635
        vel_car_kmph = 60
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "RD_PNT")
end

###

@model ST_F_PNT begin
    @parameter begin
        d_Fr_chair=6634
        k_Fr_chair=1000000
        z_k_Fr_chair_ini=0.00082722
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "ST_F_PNT") 
end

###

@model ST_R_PNT begin
    @parameter begin
        d_Rr_chair = 9381.9
        k_Rr_chair = 2000000
        z_k_Rr_chair_ini = 0.00041361
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "ST_R_PNT") 
end

###

@model front_damper begin
    df = CSV.read("damper_rate.csv", DataFrame)
    @parameter begin
        d_Fr_sus_fric_gain = 10000
        d_Fr_sus_fric = 40
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "front_damper")
end

###

@model SUS_F_PNT begin
    @parameter begin
        L_ratio_Fr_sus = 1.2048
        z_k_Fr_sus_ini = 0.10755
        k_Fr_sus = 30690
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "SUS_F_PNT")
end

###

@model rear_damper begin
    df = CSV.read("damper_rate.csv", DataFrame)
    @parameter begin
        d_Rr_sus_fric_gain = 10000
        d_Rr_sus_fric = 30
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "rear_damper")
end

###

@model SUS_R_PNT begin
    @parameter begin
        L_ratio_Rr_sus = 1.2048
        z_k_Rr_sus_ini = 0.076651
        k_Rr_sus = 30690
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "SUS_R_PNT")
end

###

@model TR_F_PNT begin
    @parameter begin
        d_Fr_wheel = 3162.3
        k_Fr_wheel = 200000
        z_k_Fr_wheel_ini = 0.022334
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "TR_F_PNT") 
end

###

@model TR_R_PNT begin
    @parameter begin
        d_Rr_wheel = 3162.3
        k_Rr_wheel = 200000
        z_k_Rr_wheel_ini = 0.016621
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "TR_R_PNT") 
end

###

@model pitch_rate_vl begin
    @parameter begin
        I_center2Fr_ENG_mount = 1.1374
        I_center2Rr_ENG_mount = 0.90993
        I_center2Fr_Chair = 0.34122
        I_center2Rr_Chair = -1.0237
        I_center2Rr_sus = -1.4976
        I_center2Fr_sus = 1.1374
        i_center_gravity = 400
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "pitch_rate_vl") 
end

@model v_z_carbody_vl begin
    @parameter begin
        g = 9.8
        M_car_body = 1171.2
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "v_z_carbody_vl") 
end

@model z_velocity_vl begin
    @parameter begin
        I_center2Fr_ENG_mount = 1.1374
        I_center2Rr_ENG_mount = 0.90993
        I_center2Fr_Chair = 0.34122
        I_center2Rr_Chair = -1.0237
        I_center2Rr_sus = -1.4976
        I_center2Fr_sus = 1.1374
    end
    @xmlmodel("METI_Vertical_Vibration.drawio", "z_velocity_vl") 
end

@model VL_PNT begin
    @xmlmodel("METI_Vertical_Vibration.drawio", "VL_PNT")
end

###

@model Vehicle begin
    @xmlmodel("METI_Vertical_Vibration.drawio", "Vehicle")
end

###

@buildxml("models.xml",
    ENG_MNT_F_PNT,
    ENG_MNT_R_PNT,
    pitch_rate,
    v_z_carbody,
    z_velocity,
    ENG_PNT,
    HM_BD_F_PNT,
    HM_HD_F_PNT,
    HM_VS_F_PNT,
    HM_F_PNT,
    HM_BD_R_PNT,
    HM_HD_R_PNT,
    HM_VS_R_PNT,
    HM_R_PNT,
    MUS_F_PNT,
    MUS_R_PNT,
    RD_PNT,
    ST_F_PNT,
    ST_R_PNT,
    front_damper,
    SUS_F_PNT,
    rear_damper,
    SUS_R_PNT,
    TR_F_PNT,
    TR_R_PNT,
    pitch_rate_vl,
    v_z_carbody_vl,
    z_velocity_vl,
    VL_PNT,
    Vehicle
)
