

function syncAxes(ax1, ax2, obj, evd)

x = evd.Axes.View;
a = x(1);
e = x(2);
view(ax1, a+1, e);
view(ax2, a-1, e);

% [x, y, z] = sph2cart(a, e, 10);
% ax1.CameraPosition = [x, y, z];
% ax2.CameraPosition = [x, y, z];
% [x, y, z] = sph2cart(a, e, -10);
% ax1.CameraTarget = [x, y, z];
% ax2.CameraTarget = [x, y, z];

end

