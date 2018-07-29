function v_snr=calc_snr(x,xn)
v_snr=10*log10(sum(x(:).^2)/sum((x(:)-xn(:)).^2));