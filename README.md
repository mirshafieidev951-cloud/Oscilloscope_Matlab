# Real-Time Oscilloscope using MATLAB & Sound Card 📉

This project implements a low-frequency **Digital Storage Oscilloscope (DSO)** using a standard laptop's microphone jack as an Analog-to-Digital Converter (ADC). The software is written in **MATLAB** and features a Graphical User Interface (GUI) for real-time signal analysis.

This project was developed as the final project for the **Electrical Circuits I** course.

## 📄 Project Report
For detailed documentation, hardware wiring diagrams, and theoretical analysis, please refer to the full project report:
👉 **[Download Full Report (PDF)](Project.pdf)**

## 🎯 Key Features
* **Real-Time Data Acquisition:** Captures audio signals at **44.1 kHz** sampling rate (16-bit depth).
* **Signal Processing:** - Fast Fourier Transform (**FFT**) for frequency extraction.
  - Peak-to-Peak amplitude calculation.
  - Signal normalization.
* **Interactive GUI:** - Dynamic time-domain plotting.
  - Adjustable time scaling (Time/Div).
  - Real-time display of Frequency (Hz) and Amplitude.

## ⚙️ Hardware Setup
The probe is constructed using a **3.5mm Audio Jack** connected to the signal source:
* **Microphone Pin:** Connected to the Signal Positive (+).
* **Ground Pin:** Connected to the Signal Ground (-).

> **⚠️ WARNING:** The typical input voltage range for a laptop sound card is **±1V to ±2V**. Exceeding this range may permanently damage your hardware. A voltage divider protection circuit is highly recommended.

## 📉 Technical Limitations
Based on the hardware constraints of standard PC sound cards:
1.  **Bandwidth:** According to the **Nyquist Theorem**, with a sampling rate of 44.1 kHz, the maximum measurable frequency is limited to **22.05 kHz**.
2.  **AC Coupling:** Sound cards use capacitors in series with the input, blocking DC components. This oscilloscope is suitable for AC signals only.
3.  **Input Impedance:** The input impedance is significantly lower than standard laboratory oscilloscopes.

## 🚀 How to Run
1.  Ensure **MATLAB** is installed on your system.
2.  Connect your DIY probe to the **Microphone/Line-in** jack.
3.  **Important:** Disable "Noise Suppression" and "Echo Cancellation" in your Windows/Linux Sound Settings for accurate signal fidelity.
4.  Run the `simple_oscilloscope.m` script (source code available in the PDF report).

---
*Developed by Mirshafiei, Student of Sharif University of Technology*
