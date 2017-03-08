
function anaglyph(X, Y, Z)

fh = figure;
ax1 = gca;
ax2 = axes('Position', [0.1300 0.1100 0.7750 0.8150]);
ax1.Projection = 'perspective';
ax2.Projection = 'perspective';
m1 = mesh(ax1, X, Y, Z);
m2 = mesh(ax2, X, Y, Z);
set(ax2, 'Color', 'None')
mycmap = [1, 0, 0; 0, 1, 1];
colormap(ax1, mycmap);
colormap(ax2, mycmap);
m1.CData = zeros(size(m1.CData));
m2.CData = ones(size(m2.CData));
ax1.CLim = [0, 1];
ax2.CLim = [0, 1];
m1.FaceAlpha = 0;
m2.FaceAlpha = 0;
h = rotate3d(fh);
h.ActionPostCallback = @(obj, evt) syncAxes(ax1, ax2, obj, evt);

end
