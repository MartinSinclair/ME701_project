VC_Cascade_Hinf_LQR = Simulink.Variant('ControlType==Controller_Type.Cascade_Hinf_LQR');
VC_Hinf = Simulink.Variant('ControlType==Controller_Type.Hinf');
VC_LQR = Simulink.Variant('ControlType==Controller_Type.LQR');
VC_None = Simulink.Variant('ControlType==Controller_Type.None');
VC_H2 = Simulink.Variant('ControlType==Controller_Type.H2');
VC_H2_LQR = Simulink.Variant('ControlType==Controller_Type.H2_LQR');

ControlType=Controller_Type.None;

VC_Use_Noise = Simulink.Variant('NoiseType==Controller_Type.Use_Noise');
VC_Dont_Use_Noise = Simulink.Variant('NoiseType==Controller_Type.Dont_Use_Noise');

NoiseType = Controller_Type.Dont_Use_Noise;
