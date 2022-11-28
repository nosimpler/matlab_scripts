nw=16
[pre_xx, w, pre_conf] = pmtm(pre_tACS, nw, 'ConfidenceLevel', 0.95); 
[post_xx, w, post_conf] = pmtm(post_tACS, nw, 'ConfidenceLevel', 0.95); 
plot(w*125/pi, log10(pre_xx)); 
hold on; 
plot(w*125/pi, log10(post_xx));
plot(w*125/pi, log10(pre_conf), 'g-.');
plot(w*125/pi, log10(post_conf), 'y-.');

[pre_xx, w1] = pyulear(pre_tACS, 200, 2^16, 250); 
[post_xx, w2] = pyulear(post_tACS, 200, 2^16, 250);

plot(w1, log10(pre_xx)); 
hold on; 
plot(w2, log10(post_xx));