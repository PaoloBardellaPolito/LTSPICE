%Script per processare i dati AC esportati da LTspice
h=fopen('Esempio2_AmpAudio_MC.txt');
NumRuns=100;                    %100 run
NumFreqPoints=8*10+1;           %8 decadi, 10 punti per decade, +1
freq=zeros(1,NumFreqPoints);    %vettore frequenze (uguali per i vari run)
AdB=zeros(NumRuns,NumFreqPoints);
Aphi=zeros(NumRuns,NumFreqPoints);
fgets(h);                       %stringa Freq.	V(c)
for run=1:100                   %runs
    fgets(h);                   %stringa Step Information: Myrun=1  (Run: 1/100)
    for kfreq=1:81
        str=fgets(h);           %legge una riga
        %dobbiamo leggere righe del tipo 0\t(1dB,0°).
        %!A differenza del C,MATLAB restituisce tutti i valori letti in un vettore 
        Values = sscanf(str,'%f\t(%fdB,%f°)');    
        freq(kfreq)=Values(1);
        AdB(run, kfreq)=Values(2);
        Aphi(run,kfreq)=Values(3);
    end
end
fclose(h);                      %chiude il file
figure;
AdBMax=max(AdB);                %luogo dei massimi
AdBMax3dB=max(AdBMax)-3;        %-3dB
AdBmin=min(AdB);                %luogo dei minimi
AdBmin3dB=max(AdBmin)-3;        %-3dB
semilogx(freq,AdBMax,'r','linewidth',3);
hold on;
semilogx(freq,AdBmin,'b','linewidth',3);
semilogx(xlim(),[AdBMax3dB,AdBMax3dB],'--r');
semilogx(xlim(),[AdBmin3dB,AdBmin3dB],'--b');
legend('MAX','min','location','southeast');
xlabel('Frequency [Hz]');
ylabel('Amplification [dB]');
grid 

    