
function [axv] = anaglyph(plot_fcn, varargin)
    
    % Default to mesh plotting
    if isa(plot_fcn, 'function_handle')
        V = varargin;
    else
        V = {plot_fcn, varargin{:}};
        plot_fcn = @mesh;
    end
    
    % Create the figure and dual axes
    fh = figure;
    ax1 = gca;
    ax2 = axes('Position', [0.1300 0.1100 0.7750 0.8150]);
    
    m1 = plot_fcn(ax1, V{:});
    m2 = plot_fcn(ax2, V{:});
    
    % Dual element colormap, [red; cyan]
    mycmap = [1, 0, 0; 0, 1, 1];
    switch func2str(plot_fcn)
        case {'mesh'}
            % Enable transparency
            m1.FaceAlpha = 0;
            m2.FaceAlpha = 0;
            % Change color data
            colormap(ax1, mycmap);
            colormap(ax2, mycmap);
            m1.CData = zeros(size(m1.CData));
            m2.CData = ones(size(m2.CData));
            % Force limits for the colormap
            ax1.CLim = [0, 1];
            ax2.CLim = [0, 1];
        case {'plot3'}
            m1.Color = mycmap(1, :);
            m2.Color = mycmap(2, :);
    end
    
    % Begin linking properties
    axv = [ax1, ax2];
    lp = linkprop(axv, {'View', 'XLim', 'YLim', 'ZLim'});
    
    % Ensure the axes update when we do a rotation
    h = rotate3d(fh);
    h.ActionPreCallback = @(obj, evt) preSyncAxes(lp, axv, obj, evt);
    h.ActionPostCallback = @(obj, evt) postSyncAxes(lp, axv, obj, evt);
    
    % Trigger a rotation to get the disparity
    h.ActionPostCallback(fh, []);
    
    % Turn off the second axes ticks and grid so only the first is visible
    ax2.Color = 'none';
    ax2.XColor = 'none';
    ax2.YColor = 'none';
    ax2.ZColor = 'none';
    grid(ax2, 'off');
end
