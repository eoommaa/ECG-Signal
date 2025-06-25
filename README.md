# ECG Signal
- Electrocardiography - The process of producing an electrocardiogram (ECG), a recording of the heart’s electrical activity through repeated cardiac cycles
- ECG records impulses to display how fast the heart is beating, rhythm of the heartbeats, and the timing of electrical impulses as they move through different parts of the heart
- Helpful device in medicine used to detect heart-related and health conditions
## Processing Bio (ECG) Signal
**ECG Signals, Functions, and Filtering Task**
- `ecg` - ECG signal generator or function from MATLAB[^1]
- $x[n]$ - Input noisy ECG signal expressed as $x[n] = s[n] + sigma$, where sigma is $0<sigma<1$
  - Also sampled at F<sub>s</sub> = 500 Hz
- $s[n]$ - Clean ECG signal
- $y_{filter}[n]$ - Output ECG signal using the MATLAB function `filter`
- **Task:** Reduce the noise fluctuations by filtering or processing $x[n]$ using a moving average Finite Impulse Response (FIR) filter of length $M+1$ by using the MATLAB function `conv`
- Results were used to determine the ideal sigma values and filter order $M$ of ECG signals to determine medical diagnostics

Adapted from M&I[^2], the moving average filter is expressed as:
```math
y[n] = \frac{1}{M + 1} \sum_{k=0}^{M} x[n-k]
```
which is used as a model to write the MATLAB code to reduce the noise fluctuations from the noisy signal $x[n]$.
<br/><br/>

- Sigma values chosen: 0.2, 0.5, and 0.7
- Filter order $M$ chosen: 10, 50, and 100
  
### Results
***Noisy and Clean ECG Signals with Sigma = 0.2, 0.5, and 0.7***
![image](https://github.com/user-attachments/assets/4b9a4635-d94e-480e-8883-04e83a9245c8)
  
***Noisy and Filtered ECG Signals with Sigma = 0.2, 0.5, and 0.7 with Filter Order M = 10***
![image](https://github.com/user-attachments/assets/76725daa-7792-456c-95ac-c9f33e7b9e85)
  
***Noisy and Filtered ECG Signals with Sigma = 0.2 with Filter Order M = 10, 50, and 100***
![image](https://github.com/user-attachments/assets/d9bcf491-541e-4d18-922c-3b7a2ccbbacd)


## Filtering of an ECG Signal Corrupted by Power Supply Hum
**ECG Signals, Functions, and Filtering Task**
- $s[n]$ - Clean ECG signal
- $ecg_{1}[n]$ - Four ECG pulses of length 500 samples concatenated to create a 2000 samples long signal
- $s_{1/2}[n]$ - 500 and 2000 length 60 Hz cosine signal with 0.2 amplitude and 0 phase sampled at F<sub>s</sub> = 500 Hz, same as the signal $ecg_{1}[n]$ respectively
- $x[n]$ - Noisy ECG signal expressed as $x[n] = ecg_{1}[n] + s[n]$
- $y[n]$ - Output ECG signal using the MATLAB functions `designfilt`[^3] and `filtfilt`[^4]
- **Task:** Remove the 60 Hz interference from the noisy signal $x[n]$ by using a IIR notch filter
  - Implemented by using the MATLAB functions `designfilt` to design a bandstop filter of a bandwidth of 2 Hz centered on 60 Hz to remove the interference

### Results
***Clean ECG Signals (500 and 2000 Samples)***
![image](https://github.com/user-attachments/assets/065a8f2e-6953-40ee-a88d-a4e3ab2968be)
  
***60 Hz Cosine Signals Sampled at 500 Hz (500 and 2000 Samples)***
![image](https://github.com/user-attachments/assets/21612618-e0a6-4c43-869c-1628fdb24d1f)

***60 Hz Interference and Filtered ECG Signals***
![image](https://github.com/user-attachments/assets/d7d8fcd2-e77f-4521-b546-f54173f24a3e)
  
***Clean and Filtered ECG Signals (2000 Samples)***
![image](https://github.com/user-attachments/assets/fc3685d3-8715-46a6-ba65-34a9c7a9fe59)


[^1]: [ECG signal generator](https://github.com/eoommaa/ECG-Signal/blob/c226983dcf1e0dbb263750cd5978ac46688e0c86/processing-bio-ecg/ecg.m)
[^2]: D. G. Manolakis and V. K. Ingle, Applied Digital Signal Processing, 1st ed. Cambridge University Press, 2011, pp. 66–67.
[^3]: [MATLAB function `designfilt` documentation](https://www.mathworks.com/help/signal/ref/designfilt.html)
[^4]: [MATLAB function `filtfilt` documentation](https://www.mathworks.com/help/signal/ref/filtfilt.html)
