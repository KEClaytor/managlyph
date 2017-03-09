% Demo anaglyph modes

%% Peaks
[X, Y, Z] = peaks;
anaglyph(X, Y, Z);

%% Specify plot style
t = linspace(0, 1);
x = cos(2*pi*2*t);
y = sin(2*pi*3*t);
anaglyph(@plot3, x, y, t);

%% Specify additional plot options
t = linspace(0, 1);
x = cos(2*pi*1*t);
y = sin(2*pi*1*t);
anaglyph(@plot3, x, y, t, 'LineWidth', 5);

%% Layer plots on top of each other
% Eg; for scatterplots
group_a = rand(10, 3) + repmat([1, 0, 0], [10, 1]);
group_b = rand(10, 3) + repmat([0, 1, 0], [10, 1]);
group_c = rand(10, 3) + repmat([0, 0, 1], [10, 1]);
axv = anaglyph(@scatter3, group_a(:, 1), group_a(:, 2), group_a(:, 3));
hold on;
anaglyph(axv, @scatter3, group_b(:, 1), group_b(:, 2), group_b(:, 3), '+');
anaglyph(axv, @scatter3, group_c(:, 1), group_c(:, 2), group_c(:, 3), 'd');
