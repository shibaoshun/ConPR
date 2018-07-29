function sigma=estimate_sigma(z)
daub6kern=[0.03522629188571 0.08544127388203 -0.13501102001025 -0.45987750211849 0.80689150931109 -0.33267055295008];
wav_det=filter2(daub6kern,z);
wav_det=filter2(daub6kern',wav_det);
sigma=median(abs(wav_det(:)))/.6745;
return;

[cA,cH,cV,cD] = dwt2(z,'db6');
sigma=median(abs(cD(:)))/0.6745;