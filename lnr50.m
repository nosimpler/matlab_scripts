function Sc = lnr50Hz(S,Fs)
% function Sc = lnr50Hz(S,Fs)
%
% Line noise reduction (50 Hz) The amplitude and phase of the line noise is 
% estimated. A sinusoide with these characteristics is then subtracted from
% the signal. In many cases this approach is better than a notch filter, since 
% it does not reduce remove brain responses in the 50 Hz band. Works excellent
% on EFs with strong line noise.
%
% S   : time x trials    
% Fs  : sampling frequency
% Sc  : S 'cleaned' from 50 Hz
%------------------------------------------------------------------------
% Ole Jensen and Cristina Simoes, Brain Resarch Unit, Low Temperature 
% Laboratory, Helsinki University of Technology, 02015 HUT, Finland,
% Report bugs to ojensen@neuro.hut.fi
%------------------------------------------------------------------------

%    Copyright (C) 2000 by Ole Jensen 
%    This program is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 2 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You can find a copy of the GNU General Public License
%    along with this package (4DToolbox); if not, write to the Free Software
%    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


fNoise=50.0;
tv = (0:length(S)-1)/Fs;
S = S';

transP = 0;
if size(S,2) == 1
    S = S';
    transP = 1;
end

for k=1:size(S,1)
   Sft = ft(S(k,:),fNoise,Fs);
   Sc(k,:) = S(k,:) - abs(Sft)*cos(2*pi*fNoise*tv - angle(Sft));
end

Sc = Sc';

if transP 
    Sc = Sc';
end

function S=ft(s, f, Fs)

tv = (0:length(s)-1)/Fs;
tmp = exp(i*2*pi*f*tv);
S= 2*sum(s.*exp(i*2*pi*f*tv))/length(s);

