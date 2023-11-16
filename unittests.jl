using Plots
using DifferentialEquations
using JuliaMBD
using JuliaMBD.Diagram

using Test

@testset "ENG_MNT_F_PNT" begin
    @model testblock begin
        @block begin
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
            b1 = ENG_MNT_F_PNT()
        end
        @connect begin
            ramp1.out => b1.v_ENG2ENG_MNT_F_mps
            ramp2.out => b1.v_VL2ENG_MNT_F_mps
        end
        @scope begin
            b1.v_ENG2ENG_MNT_F_mps => v_ENG2ENG_MNT_F_mps
            b1.v_VL2ENG_MNT_F_mps => v_VL2ENG_MNT_F_mps
            b1.F_ENG_MNT_F2ENG_N => F_ENG_MNT_F2ENG_N
            b1.F_ENG_MNT_F2VL_N => F_ENG_MNT_F2VL_N
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

@testset "ENG_MNT_R_PNT" begin
    @model testblock begin
        @block begin
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
            b1 = ENG_MNT_R_PNT()
        end
        @connect begin
            ramp1.out => b1.v_ENG2ENG_MNT_R_mps
            ramp2.out => b1.v_VL2ENG_MNT_R_mps
        end
        @scope begin
            b1.v_ENG2ENG_MNT_R_mps => v_ENG2ENG_MNT_R_mps
            b1.v_VL2ENG_MNT_R_mps => v_VL2ENG_MNT_R_mps
            b1.F_ENG_MNT_R2ENG_N => F_ENG_MNT_R2ENG_N
            b1.F_ENG_MNT_R2VL_N => F_ENG_MNT_R2VL_N
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

####

@testset "pitch_rate" begin
    @model testblock begin
        @block begin
            b1 = pitch_rate()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => b1.F_ENG_MNT_F2ENG_N
            ramp2.out => b1.F_ENG_MNT_R2ENG_N
        end
        @scope begin
            b1.F_ENG_MNT_F2ENG_N => F_ENG_MNT_F2ENG_N
            b1.F_ENG_MNT_R2ENG_N => F_ENG_MNT_R2ENG_N
            b1.omg_ENG_pitch_rate_radps => omg_ENG_pitch_rate_radps
        end
    end
    
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res))
end

@testset "v_z_carbody" begin
    @model testblock begin
        @block begin
            b1 = v_z_carbody()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => b1.F_ENG_MNT_F2ENG_N
            ramp2.out => b1.F_ENG_MNT_R2ENG_N
        end
        @scope begin
            b1.F_ENG_MNT_F2ENG_N => F_ENG_MNT_F2ENG_N
            b1.F_ENG_MNT_R2ENG_N => F_ENG_MNT_R2ENG_N
            b1.v_ENG_mps => v_ENG_mps
        end
    end
    
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res))
end

@testset "z_velocity" begin
    @model testblock begin
        @block begin
            b1 = z_velocity()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => b1.v_ENG_mps
            ramp2.out => b1.omg_ENG_pitch_rate_radps
        end
        @scope begin
            b1.v_ENG_mps => v_ENG_mps
            b1.omg_ENG_pitch_rate_radps => omg_ENG_pitch_rate_radps
            b1.v_ENG2ENG_MNT_F_mps => v_ENG2ENG_MNT_F_mps
            b1.v_ENG2ENG_MNT_R_mps => v_ENG2ENG_MNT_R_mps
        end
    end
    
    m = @compile testblock()
    result = simulate(m, tspan=(0.0, 60.0));
    display(plot(result, layout=(2,2)))
end

@testset "ENG_PNT" begin
    @model testblock begin
        @block begin
            m = ENG_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => m.F_ENG_MNT_F2ENG_N
            ramp2.out => m.F_ENG_MNT_R2ENG_N
        end
        @scope begin
            m.F_ENG_MNT_F2ENG_N => F_ENG_MNT_F2ENG_N
            m.F_ENG_MNT_R2ENG_N => F_ENG_MNT_R2ENG_N
            m.v_ENG2ENG_MNT_F_mps => v_ENG2ENG_MNT_F_mps
            m.v_ENG2ENG_MNT_R_mps => v_ENG2ENG_MNT_R_mps
        end
    end
    
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

####

@testset "HM_BD_F_PNT" begin
    @model testblock begin
        @block begin
            b = HM_BD_F_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
            ramp3 = Ramp(starttime=10, slope=25)
        end
        @connect begin
            ramp1.out => b.F_HM_HD_F_N
            ramp2.out => b.F_HM_VS_F_N
            ramp3.out => b.F_ST_F2HM_F_N
        end
        @scope begin
            b.F_HM_HD_F_N => F_HM_HD_F_N
            b.F_HM_VS_F_N => F_HM_VS_F_N
            b.F_ST_F2HM_F_N => F_ST_F2HM_F_N
            b.v_HM_BD_F2HM_HD_F_mps => v_HM_BD_F2HM_HD_F_mps
            b.v_HM_BD_F2HM_VS_F_mps => v_HM_BD_F2HM_VS_F_mps
            b.v_HM_BD_F2ST_F_mps => v_HM_BD_F2ST_F_mps
        end
    end
    
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(3,2)))
end

@testset "HM_HD_F_PNT" begin
    @model testblock begin
        @block begin
            m = HM_HD_F_PNT()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_HM_BD_F2HM_HD_mps
        end
        @scope begin
            m.v_HM_BD_F2HM_HD_mps => v_HM_BD_F2HM_HD_mps
            m.F_HM_HD_F_N => F_HM_HD_F_N
        end
    end
    
    m = @compile_derivative testblock()
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

@testset "HM_VS_F_PNT" begin
    @model testblock begin
        @block begin
            m = HM_VS_F_PNT()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_HM_BD_F2HM_VS_F_mps
        end
        @scope begin
            m.v_HM_BD_F2HM_VS_F_mps => v_HM_BD_F2HM_VS_F_mps
            m.F_HM_VS_F_N => F_HM_VS_F_N
        end
    end
    
    m = @compile testblock() 
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

@testset "HM_F_PNT" begin
    @model testblock begin
        @block begin
            m = HM_F_PNT()
            s1 = Step(steptime=5, finalvalue=10)
        end
        @connect begin
            s1.out => m.F_ST_F2HM_F_N
        end
        @scope begin
            m.F_ST_F2HM_F_N => F_ST_F2HM_F_N
            m.v_HM_BD_F2ST_F_mps => v_HM_BD_F2ST_F_mps
        end
    end
    
    m = @compile_derivative testblock()
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

###

@testset "HM_BD_R_PNT" begin
    @model testblock begin
        @block begin
            b = HM_BD_R_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
            ramp3 = Ramp(starttime=10, slope=25)
        end
        @connect begin
            ramp1.out => b.F_HM_HD_R_N
            ramp2.out => b.F_HM_VS_R_N
            ramp3.out => b.F_ST_R2HM_R_N
        end
        @scope begin
            b.F_HM_HD_R_N => F_HM_HD_R_N
            b.F_HM_VS_R_N => F_HM_VS_R_N
            b.F_ST_R2HM_R_N => F_ST_R2HM_R_N
            b.v_HM_BD_R2HM_HD_R_mps => v_HM_BD_R2HM_HD_R_mps
            b.v_HM_BD_R2HM_VS_R_mps => v_HM_BD_R2HM_VS_R_mps
            b.v_HM_BD_R2ST_R_mps => v_HM_BD_R2ST_R_mps
        end
    end
    
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(3,2)))
end

@testset "HM_HD_R_PNT" begin
    @model testblock begin
        @block begin
            m = HM_HD_R_PNT()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_HM_BD_R2HM_HD_R_mps
        end
        @scope begin
            m.v_HM_BD_R2HM_HD_R_mps => v_HM_BD_R2HM_HD_R_mps
            m.F_HM_HD_R_N => F_HM_HD_R_N
        end
    end
    
    m = @compile_derivative testblock()
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

@testset "HM_VS_R_PNT" begin
    @model testblock begin
        @block begin
            m = HM_VS_R_PNT()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_HM_BD_R2HM_VS_R_mps
        end
        @scope begin
            m.v_HM_BD_R2HM_VS_R_mps => v_HM_BD_R2HM_VS_R_mps
            m.F_HM_VS_R_N => F_HM_VS_R_N
        end
    end
    
    m = @compile testblock() 
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

@testset "HM_R_PNT" begin
    @model testblock begin
        @block begin
            m = HM_R_PNT()
            s1 = Step(steptime=5, finalvalue=10)
        end
        @connect begin
            s1.out => m.F_ST_R2HM_R_N
        end
        @scope begin
            m.F_ST_R2HM_R_N => F_ST_R2HM_R_N
            m.v_HM_BD_R2ST_R_mps => v_HM_BD_R2ST_R_mps
        end
    end
    
    m = @compile_derivative testblock()
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

###

@testset "MUS_F_PNT" begin
    @model testblock begin
        @block begin
            b = MUS_F_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => b.F_SUS_F2MUS_F_N
            ramp2.out => b.F_TR_F2MUS_F_N
        end
        @scope begin
            b.F_SUS_F2MUS_F_N => F_SUS_F2MUS_F_N
            b.F_TR_F2MUS_F_N => F_TR_F2MUS_F_N 
            b.v_MUS_F2SUS_F_mps => v_MUS_F2SUS_F_mps
            b.v_MUS_F2TR_F_mps => v_MUS_F2TR_F_mps
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

###

@testset "MUS_R_PNT" begin
    @model testblock begin
        @block begin
            b = MUS_R_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => b.F_SUS_R2MUS_R_N
            ramp2.out => b.F_TR_R2MUS_R_N
        end
        @scope begin
            b.F_SUS_R2MUS_R_N => F_SUS_R2MUS_R_N
            b.F_TR_R2MUS_R_N => F_TR_R2MUS_R_N 
            b.v_MUS_R2SUS_R_mps => v_MUS_R2SUS_R_mps
            b.v_MUS_R2TR_R_mps => v_MUS_R2TR_R_mps
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

###

@testset "RD_PNT" begin
    @model testblock begin
        @block begin
            m = RD_PNT()
        end
        @scope begin
            m.v_RD2TR_F_mps => v_RD2TR_F_mps
            m.v_RD2TR_R_mps => v_RD2TR_R_mps
        end
    end
    
    m = @compile_derivative testblock()
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

###

@testset "ST_F_PNT" begin
    @model testblock begin
        @block begin
            p = ST_F_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => p.v_HM_BD_F2ST_F_mps
            ramp2.out => p.v_VL2ST_F_mps
        end
        @scope begin
            p.v_HM_BD_F2ST_F_mps => v_HM_BD_F2ST_F_mps
            p.v_VL2ST_F_mps => v_VL2ST_F_mps
            p.F_ST_F2HM_F_N => F_ST_F2HM_F_N
            p.F_ST_F2VL_N => F_ST_F2VL_N
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

###

@testset "ST_R_PNT" begin
    @model testblock begin
        @block begin
            p = ST_R_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => p.v_HM_BD_R2ST_R_mps
            ramp2.out => p.v_VL2ST_R_mps
        end
        @scope begin
            p.v_HM_BD_R2ST_R_mps => v_HM_BD_R2ST_R_mps
            p.v_VL2ST_R_mps => v_VL2ST_R_mps
            p.F_ST_R2HM_R_N => F_ST_R2HM_R_N 
            p.F_ST_R2VL_N => F_ST_R2VL_N
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

###

@testset "front_damper" begin
    @model testblock begin
        @block begin
            m = front_damper()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_SUS_F_damper_mps
        end
        @scope begin
            m.v_SUS_F_damper_mps => v_SUS_F_damper_mps
            m.F_SUS_F_damper_N => F_SUS_F_damper_N
        end
    end
    
    m = @compile testblock()
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

@testset "SUS_F_PNT" begin
    @model testblock begin
        @block begin
            m = SUS_F_PNT()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_VL2SUS_F_mps
            s1.out => m.v_MUS_F2SUS_F_mps
        end
        @scope begin
            m.v_VL2SUS_F_mps => v_VL2SUS_F_mps
            m.v_MUS_F2SUS_F_mps => v_MUS_F2SUS_F_mps
            m.F_SUS_F2VL_N => F_SUS_F2VL_N
            m.F_SUS_F2MUS_F_N => F_SUS_F2MUS_F_N
        end
    end
    
    m = @compile testblock() 
    res = simulate(m, tspan=[0, 10])
    display(plot(res, layout=(2,2)))
end

###

@testset "rear_damper" begin
    @model testblock begin
        @block begin
            m = rear_damper()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_SUS_R_damper_mps
        end
        @scope begin
            m.v_SUS_R_damper_mps => v_SUS_R_damper_mps
            m.F_SUS_R_damper_N => F_SUS_R_damper_N
        end
    end
    
    m = @compile testblock() 
    res = simulate(m, tspan=[0, 10])
    display(plot(res))
end

@testset "SUS_R_PNT" begin
    @model testblock begin
        @block begin
            m = SUS_R_PNT()
            s1 = Step(steptime=5, finalvalue=100)
        end
        @connect begin
            s1.out => m.v_VL2SUS_R_mps
            s1.out => m.v_MUS_R2SUS_R_mps
        end
        @scope begin
            m.v_VL2SUS_R_mps => v_VL2SUS_R_mps
            m.v_MUS_R2SUS_R_mps => v_MUS_R2SUS_R_mps
            m.F_SUS_F2VL_N => F_SUS_F2VL_N
            m.F_SUS_R2MUS_R_N => F_SUS_R2MUS_R_N
        end
    end
    
    m = @compile testblock() 
    res = simulate(m, tspan=[0, 10])
    display(plot(res, layout=(2,2)))
end

###

@testset "TR_F_PNT" begin
    @model testblock begin
        @block begin
            p = TR_F_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => p.v_MUS_F2TR_F_mps
            ramp2.out => p.v_RD2TR_F_mps
        end
        @scope begin
            p.v_MUS_F2TR_F_mps => v_MUS_F2TR_F_mps
            p.v_RD2TR_F_mps => v_RD2TR_F_mps
            p.F_TR_F2MUS_F_N => F_TR_F2MUS_F_N
            p.F_TR_F2RD_N => F_TR_F2RD_N
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(2,2)))
end

###

@testset "TR_R_PNT" begin
    @model testblock begin
        @block begin
            p = TR_R_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => p.v_MUS_R2TR_R_mps
            ramp2.out => p.v_RD2TR_R_mps
        end
        @scope begin
            p.v_MUS_R2TR_R_mps => v_MUS_R2TR_R_mps
            p.v_RD2TR_R_mps => v_RD2TR_R_mps
            p.F_TR_R2MUS_R_N => F_TR_R2MUS_R_N
            p.F_TR_R2RD_N => F_TR_R2RD_N
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    plot(res, layout=(2,2))
end

###

@testset "pitch_rate_vl" begin
    @model testblock begin
        @block begin
            p = pitch_rate_vl()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
            ramp3 = Ramp(starttime=10, slope=25)
            ramp4 = Ramp(starttime=10, slope=35)
            ramp5 = Ramp(starttime=10, slope=45)
            ramp6 = Ramp(starttime=10, slope=55)
        end
        @connect begin
            ramp1.out => p.F_ENG_MNT_F2VL_N
            ramp2.out => p.F_ENG_MNT_R2VL_N
            ramp3.out => p.F_ST_F2VL_N
            ramp4.out => p.F_ST_R2VL_N
            ramp5.out => p.F_SUS_R2VL_N
            ramp6.out => p.F_SUS_F2VL_N
        end
        @scope begin
            p.F_ENG_MNT_F2VL_N => F_ENG_MNT_F2VL_N
            p.F_ENG_MNT_R2VL_N => F_ENG_MNT_R2VL_N
            p.F_ST_F2VL_N => F_ST_F2VL_N
            p.F_ST_R2VL_N => F_ST_R2VL_N
            p.F_SUS_R2VL_N => F_SUS_R2VL_N
            p.F_SUS_F2VL_N => F_SUS_F2VL_N
            p.omg_VL_pitch_rate_radps => omg_VL_pitch_rate_radps
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(4,2)))
end

@testset "v_z_carbody_vl" begin
    @model testblock begin
        @block begin
            p = v_z_carbody_vl()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
            ramp3 = Ramp(starttime=10, slope=25)
            ramp4 = Ramp(starttime=10, slope=35)
            ramp5 = Ramp(starttime=10, slope=45)
            ramp6 = Ramp(starttime=10, slope=55)
        end
        @connect begin
            ramp1.out => p.F_ENG_MNT_F2VL_N
            ramp2.out => p.F_ENG_MNT_R2VL_N
            ramp3.out => p.F_ST_F2VL_N
            ramp4.out => p.F_ST_R2VL_N
            ramp5.out => p.F_Rr_sus
            ramp6.out => p.F_Fr_sus
        end
        @scope begin
            p.F_ENG_MNT_F2VL_N => F_ENG_MNT_F2VL_N
            p.F_ENG_MNT_R2VL_N => F_ENG_MNT_R2VL_N
            p.F_ST_F2VL_N => F_ST_F2VL_N
            p.F_ST_R2VL_N => F_ST_R2VL_N
            p.F_Rr_sus => F_Rr_sus
            p.F_Fr_sus => F_Fr_sus
            p.v_VL_mps => v_VL_mps
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(4,2)))
end

@testset "z_velocity_vl" begin
    @model testblock begin
        @block begin
            p = z_velocity_vl()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
        end
        @connect begin
            ramp1.out => p.v_VL_mps
            ramp2.out => p.omg_VL_pitch_rate_radps
        end
        @scope begin
            p.v_VL_mps => v_VL_mps
            p.omg_VL_pitch_rate_radps => omg_VL_pitch_rate_radps
            p.v_VL2ENG_MNT_F_mps => v_VL2ENG_MNT_F_mps
            p.v_VL2ENG_MNT_R_mps => v_VL2ENG_MNT_R_mps
            p.v_VL2ST_F_mps => v_VL2ST_F_mps
            p.v_VL2ST_R_mps => v_VL2ST_R_mps
            p.v_VL2SUS_R_mps => v_VL2SUS_R_mps
            p.v_VL2SUS_F_mps => v_VL2SUS_F_mps
        end
    end
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(4,2)))
end

@testset "VL_PNT" begin
    @model testblock begin
        @block begin
            m = VL_PNT()
            ramp1 = Ramp(starttime=10, slope=5)
            ramp2 = Ramp(starttime=10, slope=15)
            ramp3 = Ramp(starttime=10, slope=25)
            ramp4 = Ramp(starttime=10, slope=35)
            ramp5 = Ramp(starttime=10, slope=45)
            ramp6 = Ramp(starttime=10, slope=55)
        end
        @connect begin
            ramp1.out => m.F_ENG_MNT_F2VL_N
            ramp2.out => m.F_ENG_MNT_R2VL_N
            ramp3.out => m.F_ST_F2VL_N
            ramp4.out => m.F_ST_R2VL_N
            ramp5.out => m.F_SUS_R2VL_N
            ramp6.out => m.F_SUS_F2VL_N
        end
        @scope begin
            m.F_ENG_MNT_F2VL_N => F_ENG_MNT_F2VL_N
            m.F_ENG_MNT_R2VL_N => F_ENG_MNT_R2VL_N
            m.F_ST_F2VL_N => F_ST_F2VL_N
            m.F_ST_R2VL_N => F_ST_R2VL_N
            m.F_SUS_R2VL_N => F_SUS_R2VL_N
            m.F_SUS_F2VL_N => F_SUS_F2VL_N
            m.v_VL2ENG_MNT_F_mps => v_VL2ENG_MNT_F_mps
            m.v_VL2ENG_MNT_R_mps => v_VL2ENG_MNT_R_mps
            m.v_VL2ST_F_mps => v_VL2ST_F_mps
            m.v_VL2ST_R_mps => v_VL2ST_R_mps
            m.v_VL2SUS_R_mps => v_VL2SUS_R_mps
            m.v_VL2SUS_F_mps => v_VL2SUS_F_mps
        end
    end
    
    m = @compile testblock()
    res = simulate(m, tspan=[0, 100])
    display(plot(res, layout=(3,4)))
end

nothing

