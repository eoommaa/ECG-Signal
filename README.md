# ECG Signal
- Electrocardiography - The process of producing an electrocardiogram (ECG), a recording of the heart’s electrical activity through repeated cardiac cycles
- ECG records impulses to display how fast the heart is beating, rhythm of the heartbeats, and the timing of electrical impulses as they move through different parts of the heart
- Helpful device in medicine used to detect heart-related issues and other health conditions
- ***Note: Both of the projects uses the same ECG signal generator file[^1]***
## Processing Bio (ECG) Signal
**ECG Signals, Functions, and Filtering Task**
- `ecg` - ECG signal generator or function from MATLAB[^1]
- $x[n]$ - Input noisy ECG signal expressed as $x[n] = s[n] + sigma$, where sigma is $0<sigma<1$
  - Also sampled at F<sub>s</sub> = 500 Hz
- $s[n]$ - Clean ECG signal
- $y_{filter}[n]$ - Output ECG signal using the MATLAB function `filter`
- **Task:** Reduce the noise fluctuations by filtering or processing $x[n]$ using a moving average Finite Impulse Response (FIR) filter of length $M+1$ by using the MATLAB function `conv`.

  Adapted from M&I[^2], the moving average filter is expressed as $y[n] = \frac{1}{M + 1} \sum_{k=0}^{M} x[n-k]$, is used as a mathematical model to reduce the noise fluctuations from the noisy signal $x[n]$.
  - Sigma values chosen: 0.2, 0.5, and 0.7 & Filter order $M$ chosen: 10, 50, and 100
- Results were used to determine the ideal sigma values and filter order $M$ of ECG signals for detecting heart-related issues and other health conditions
  
### Results
***Noisy and Clean ECG Signals with Sigma = 0.2, 0.5, and 0.7***
![image](./plots/processing_bio_ecg_1.png)
  
***Noisy and Filtered ECG Signals with Sigma = 0.2, 0.5, and 0.7 with Filter Order M = 10***
![image](./plots/processing_bio_ecg_2.png)
  
***Noisy and Filtered ECG Signals with Sigma = 0.2 with Filter Order M = 10, 50, and 100***
![image](./plots/processing_bio_ecg_3.png)


## Filtering of an ECG Signal Corrupted by Power Supply Hum
**ECG Signals, Functions, and Filtering Task**
- $s[n]$ - Clean ECG signal
- $ecg_{1}[n]$ - Four ECG pulses of length 500 samples concatenated to create a 2000 samples long signal
- $s_{1/2}[n]$ - 500 and 2000 length 60 Hz cosine signal with 0.2 amplitude and 0 phase sampled at F<sub>s</sub> = 500 Hz, same as the signal $ecg_{1}[n]$ respectively
- $x[n]$ - Noisy ECG signal expressed as $x[n] = ecg_{1}[n] + s[n]$
- $y[n]$ - Output ECG signal using the MATLAB functions `designfilt`[^3] and `filtfilt`[^4]
- **Task:** Remove the 60 Hz interference from the noisy signal $x[n]$ by using a IIR notch filter
  - Implemented by using the MATLAB function `designfilt` to design a [bandstop filter of a bandwidth of 2 Hz centered on 60 Hz](https://github.com/eoommaa/ECG-Signal/blob/e276e31c323aecf55aa604f5fb15b25733d70aba/fir-iir-ecg/ecg_2.m#L83C1-L86C60) to remove the interference

### Results
***Clean ECG Signals (500 and 2000 Samples)***
![image](./plots/iir_ecg_1.png)
  
***60 Hz Cosine Signals Sampled at 500 Hz (500 and 2000 Samples)***
![image](./plots/iir_ecg_2.png)

***60 Hz Interference and Filtered ECG Signals***
![image](./plots/iir_ecg_3.png)
  
***Clean and Filtered ECG Signals (2000 Samples)***
![image](./plots/iir_ecg_4.png)


[^1]: [ECG signal generator](https://github.com/eoommaa/ECG-Signal/blob/c226983dcf1e0dbb263750cd5978ac46688e0c86/processing-bio-ecg/ecg.m)
[^2]: D. G. Manolakis and V. K. Ingle, Applied Digital Signal Processing, 1st ed. Cambridge University Press, 2011, pp. 66–67.
[^3]: [MATLAB function `designfilt` documentation](https://www.mathworks.com/help/signal/ref/designfilt.html)
[^4]: [MATLAB function `filtfilt` documentation](https://www.mathworks.com/help/signal/ref/filtfilt.html)
