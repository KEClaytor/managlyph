
function [axv] = anaglyph(X, Y, Z)
    
    % Create the figure and dual axes
    fh = figure;
    ax1 = gca;
    ax2 = axes('Position', [0.1300 0.1100 0.7750 0.8150]);
    
    m1 = mesh(ax1, X, Y, Z);
    m2 = mesh(ax2, X, Y, Z);
    
    m1.FaceAlpha = 0;
    m2.FaceAlpha = 0;
    
    % Dual element colormap, [red; cyan]
    mycmap = [1, 0, 0; 0, 1, 1];
    colormap(ax1, mycmap);
    colormap(ax2, mycmap);
    % Change color data
    m1.CData = zeros(size(m1.CData));
    m2.CData = ones(size(m2.CData));
    % Force limits for the colormap
    ax1.CLim = [0, 1];
    ax2.CLim = [0, 1];
    
    % Begin linking properties
    axv = [ax1, ax2];
    lp = linkprop(axv, {'View', 'XLim', 'YLim', 'ZLim'});
    
    % Ensure the axes update when we do a rotation
    h = rotate3d(fh);
    h.ActionPreCallback = @(obj, evt) preSyncAxes(lp, axv, obj, evt);
    h.ActionPostCallback = @(obj, evt) postSyncAxes(lp, axv, obj, evt);
    
    % Trigger a rotation to get the disparity
    h.ActionPostCallback(fh, []);
    
    ax2.Color = 'none';
    ax2.XColor = 'none';
    ax2.YColor = 'none';
    ax2.ZColor = 'none';
    grid(ax2, 'off');
end
