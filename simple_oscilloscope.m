function simple_oscilloscope()
    fs = 44100;       % Sampling frequency
    nChannels = 1;    % Number of channels (1 for mono, 2 for stereo)
    nBits = 16;       % Number of bits per sample
    
    % Recording settings
    duration = 1;     % Recording duration in seconds
    
    % Create an audiorecorder object
    recObj = audiorecorder(fs, nBits, nChannels);
    
    % Create a graphical user interface (GUI)
    hFig = figure('Name', 'Simple Oscilloscope', 'NumberTitle', 'off', ...
        'CloseRequestFcn', @closeFigure, 'Position', [100, 100, 800, 600]);
    
    hAxes = axes('Parent', hFig, 'Position', [0.1, 0.3, 0.8, 0.6]);
    hLine = plot(hAxes, NaN, NaN);
    
    xlabel(hAxes, 'Time (seconds)');
    ylabel(hAxes, 'Amplitude');
    grid(hAxes, 'on');
    
    % GUI controls for displaying frequency and amplitude
    uicontrol('Style', 'text', 'String', 'Frequency (Hz):', ...
        'Position', [20 100 100 20]);
    hFreq = uicontrol('Style', 'text', 'String', '0', ...
        'Position', [120 100 100 20]);
        
    uicontrol('Style', 'text', 'String', 'Amplitude:', ...
        'Position', [20 70 100 20]);
    hAmp = uicontrol('Style', 'text', 'String', '0', ...
        'Position', [120 70 100 20]);
        
    % Controls for changing time axis scale
    uicontrol('Style', 'text', 'String', 'Time Scale (seconds):', ...
        'Position', [20 40 100 20]);
    hScale = uicontrol('Style', 'edit', 'String', num2str(duration), ...
        'Position', [120 40 100 20]);
    uicontrol('Style', 'pushbutton', 'String', 'Apply', ...
        'Position', [230 40 50 20], 'Callback', @updateScale);
        
    % Continuous recording and display of signal
    while ishandle(hFig)
        recordblocking(recObj, duration);
        y = getaudiodata(recObj);
        
        % Normalize the signal (Optional: based on report code)
        if ~isempty(y)
             y = y / max(abs(y));
        end
        
        t = linspace(0, duration, length(y));
        
        % Update the plot
        set(hLine, 'XData', t, 'YData', y);
        drawnow;
        
        % Calculate and display frequency and amplitude
        Y = fft(y);
        f = (0:length(Y)-1)*fs/length(Y);
        [~, idx] = max(abs(Y));
        freq = f(idx);
        
        % Calculate peak-to-peak amplitude
        amp = (max(y) - min(y)) / 2;
        
        set(hFreq, 'String', num2str(freq, '%.2f'));
        set(hAmp, 'String', num2str(amp, '%.2f'));
    end
    
    % --- Callback Functions ---
    
    function closeFigure(~, ~)
        stop(recObj);
        delete(hFig);
    end

    function updateScale(~, ~)
        newScale = str2double(get(hScale, 'String'));
        if isnan(newScale) || newScale <= 0
            errordlg('Time scale must be a positive number.', 'Error');
        else
            duration = newScale;
        end
    end
end