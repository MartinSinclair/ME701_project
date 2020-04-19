classdef Controller_Type < Simulink.IntEnumType
        enumeration
        Cascade_Hinf_LQR (1)
        Hinf (2)
        LQR (3)
        None (4)
        H2 (5)
        H2_LQR (6)
        LQG (9)
        Hinf_LQG (10)
        
        Use_Noise (7)
        Dont_Use_Noise (8)
        end
end