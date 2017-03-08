% Demo anaglyph modes

%% Peaks
[X, Y, Z] = peaks;
anaglyph(X, Y, Z);

%% Specify plot stype
t = linspace(0, 1);
x = cos(2*pi*2*t);
y = sin(2*pi*3*t);
anaglyph(@plot3, x, y, t);
