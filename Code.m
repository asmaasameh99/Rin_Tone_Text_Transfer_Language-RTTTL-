clc;
clear all;
close all;
x=input( 'Enter the note','s');
C= strsplit(x,':'); %split the 3 parts of tone and turn string into cells
tone_name=C(1,1) ;
u=C(1,2); %the defult value
m=horzcat(u{:});%turning the defult values from cell into array
m(m=='=') = []; %remove = from string
m(m=='d') = []; %remove d from string
m(m=='o') = []; %remove o from string
m(m=='b') = []; %remove b from string
theString = m; %m='value of duration,value of octave,value of beats'
theString(theString == ',') = [] ;% remove all commas in string
stringWithoutCommas = theString(theString ~= ','); %new string without comma
defult=strsplit(stringWithoutCommas); % turn the array into cells 
d1=defult{1};%value of defult duration
d=str2num(d1);
o1=defult{2}; %value of defult octave
o=str2num(o1);
b1=defult{3}; % value of beats per minute 
b=str2num(b1);
v=C(1,3); %tone cell
tone=horzcat(v{:}); %convert cell into array 
tone(tone == ',') = [];
stringWithoutCommas = tone(tone ~= ',');
y=strsplit(stringWithoutCommas); %tone as cell, each cell is a tone
dw=60*4/b ; %whole duration of each note
fs=8000 ; %number of sampling
l=length(y); % number of tones in array
array=zeros(1,l);
sz = size(array);
final = cell(sz); % make a cell the same length of tone array
 
for i=1:l ;  % for loop for each element in cell y 
    if y{i}(1)=='1'; %check the duration
        if y{i}(2)=='6';
            D=16 ;
            p=3;
        else 
            D=1;
            p=2;
        end
    elseif y{i}(1)=='2';
             D=2;
             p=2;   
    elseif y{i}(1)=='4';
            D=4;
            p=2;
    elseif y{i}(1)=='8'; 
            D=8;
            p=2;
    elseif y{i}(1)=='3' && y{i}(2)=='2'
            D=32;
            p=3;
    elseif y{i}(1)~='1' && y{i}(1)~='2' && y{i}(1)~='4' &&y{i}(1)~='8' 
            D=d ;
            p=1;
    end    
    if y{i}(p)=='a' %check the note
        note='a';
    elseif y{i}(p)=='b'
        note='b';
    elseif y{i}(p)=='c'
        note='c';
    elseif y{i}(p)=='d'
        note='d';
    elseif y{i}(p)=='e'
        note='e';
    elseif y{i}(p)=='f'
        note='f';
    elseif y{i}(p)=='g';
        note='g';
    elseif y{i}(p)=='p';
            note='p';
    end
    if note== y{i}(end) %check if the note ended or not 
        if    o==4;
              k=1;
        elseif o==5;
                k=2;
        elseif o==6
                k=4;
        elseif o==7
                k=8;
        elseif o==8
                k=16;
        end   
        t=0:1/fs:(dw/D); %time sampling
        if note=='a'
            n= sin(2*pi*k*440*t);
        elseif note=='b'
            n= sin(2*pi*k*493.9*t);
        elseif note=='c'
            n= sin(2*pi*k*261.6*t);
        elseif note =='d'
            n= sin(2*pi*k*293.7*t);
        elseif note =='e'
            n= sin(2*pi*k*329.628*t);
        elseif note== 'f'
             n= sin(2*pi*k*349.2*t);
        elseif note== 'g'
            n= sin(2*pi*k*392*t);
       elseif note=='p'
            n= sin(2*pi*k*0*t);
        end
        final{1,i}=[n];
        continue 
    end
    p=p+1;
    if y{i}(p)=='#' ;
        sharp='#';
        note=[note sharp];
        
    end 
    if  y{i}(p)== y{i}(end)
         if     o==4
                k=1;
        elseif o==5;
                k=2;
        elseif o==6
                k=4;
        elseif o==7
                k=8;
        elseif o==8
                k=16;
         end
         t=0:1/fs:(dw/D); %time sampling
          if note=='a'
        n= sin(2*pi*k*440*t);
    elseif note=='a#'
        n= sin(2*pi*k*466.2*t);
    elseif note=='b'
        n= sin(2*pi*k*493.9*t);
    elseif note=='c'
         n= sin(2*pi*k*261.6*t);
    elseif note=='c#';
         n= sin(2*pi*k*277.2*t);
    elseif note =='d'
         n= sin(2*pi*k*293.7*t);
    elseif note=='d#'
        n= sin(2*pi*k*311.1*t);
    elseif note =='e'
         n= sin(2*pi*k*329.6*t);
    elseif note== 'f'
         n= sin(2*pi*k*349.2*t);
    elseif note=='f#'
         n= sin(2*pi*k*370*t);
    elseif note== 'g'
         n= sin(2*pi*k*392*t);
    elseif note=='g#'
         n= sin(2*pi*k*415.3*t);
      elseif note=='p'
            n= sin(2*pi*k*0*t);
         end
        final{1,i}=[n];     
        continue 
    end
    p=p+1;
    if y{i}(p)=='.';
        D=1.5*D;
        t=0:1/fs:(dw/D);
    end 
        if y{i}(p) == y{i}(end)
            if      o==4
                k=1;
            elseif o==5;
                k=2;
            elseif o==6
                k=4;
            elseif o==7
                k=8;
            elseif o==8
                k=16;
            end    
         t=0:1/fs:(dw/D); %time sampling
           if note=='a'
        n= sin(2*pi*k*440*t);
    elseif note=='a#'
        n= sin(2*pi*k*466.2*t);
    elseif note=='b'
        n= sin(2*pi*k*493.9*t);
    elseif note=='c'
         n= sin(2*pi*k*261.6*t);
    elseif note=='c#';
         n= sin(2*pi*k*277.2*t);
    elseif note =='d'
         n= sin(2*pi*k*293.7*t);
    elseif note=='d#'
        n= sin(2*pi*k*311.1*t);
    elseif note =='e'
         n= sin(2*pi*k*329.6*t);
    elseif note== 'f'
         n= sin(2*pi*k*349.2*t);
    elseif note=='f#'
         n= sin(2*pi*k*370*t);
    elseif note== 'g'
         n= sin(2*pi*k*392*t);
    elseif note=='g#'
         n= sin(2*pi*k*415.3*t);
      elseif note=='p'
            n= sin(2*pi*k*0*t);
         end
        final{1,i}=[n];
        continue
        else p=p+1;
    end
    
    if y{i}(p)=='4' ;
            octave=4;
            k=1;
    elseif  y{i}(p)=='5' ;
            octave=5;
            k=2;
    elseif y{i}(p)=='6' ;
         octave=6;
         k=4;
    elseif  y{i}(p)=='7' ;
        octave=7;
        k=8;
    elseif y{i}(p)=='8' ;
        ocrave=8;
        k=16;
    elseif  y{i}(p)~='4' &&  y{i}(p)~='5' && y{i}(p)~='6' && y{i}(p)~='7' && y{i}(p)~='8' 
            octave=o;
            if o==4
                k=1;
            elseif o==5;
                k=2;
            elseif o==6
                k=3;
            elseif o==7
                k=4;
            else
                k=5;
            end
            
    end 
    
    t=0:1/fs:(dw/D); %duration
   
    
      if note=='a'
        n= sin(2*pi*k*440*t);
    elseif note=='a#'
        n= sin(2*pi*k*466.2*t);
    elseif note=='b'
        n= sin(2*pi*k*493.9*t);
    elseif note=='c'
         n= sin(2*pi*k*261.6*t);
    elseif note=='c#';
         n= sin(2*pi*k*277.2*t);
    elseif note =='d'
         n= sin(2*pi*k*293.7*t);
    elseif note=='d#'
        n= sin(2*pi*k*311.1*t);
    elseif note =='e'
         n= sin(2*pi*k*329.6*t);
    elseif note== 'f'
         n= sin(2*pi*k*349.2*t);
    elseif note=='f#'
         n= sin(2*pi*k*370*t);
    elseif note== 'g'
         n= sin(2*pi*k*392*t);
    elseif note=='g#'
         n= sin(2*pi*k*415.3*t);
      elseif note=='p'
            n= sin(2*pi*k*0*t);
      end
       final{1,i}=[n];    
end;
horzcat(final{:});
result=[final{:}];
m=[result result];
sound(m,8000);
wavwrite(m,'tone')
