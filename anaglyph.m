%% ax = anaglyph(plot_fcn, plot_options)
% Plot a red/cyan anaglpyh. Returns axes handles to subaxes.
% Inputs:
%   plot_fcn (optional)
%       Function handle, currently @mesh and @plot3 are supported.
%       If not supplied, mesh will be used to plot.
%   plot_options
%       Options to be passed to the plot function handle. At a very
%       minimum, these should be the X, Y, Z data pairs.
%       They are passed as (see examples below);
%           plot_fcn(plot_options{:})
%
% Examples:
%   [X, Y, Z] = peaks;
%   anaglyph(X, Y, Z);
% 
%   % Specify additional plot options
%   t = linspace(0, 1);
%   x = cos(2*pi*2*t);
%   y = sin(2*pi*3*t);
%   anaglyph(@plot3, x, y, t, 'LineWidth', 3);
% 
% 2017-03-07 - ke.claytor(at)gmail.com

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

% Sync the two axes' views while rotating
function preSyncAxes(lp, ~, ~ ,~)
    
    addprop(lp, 'View');
    
end

% Add in the disparity when we stop rotating
function postSyncAxes(lp, axv, ~, ~)
    
    % Angular disparity
    d = 1;
    % Remove the view sync
    removeprop(lp, 'View')
    % Get the axes view
    x = axv(1).View;
    a = x(1);
    e = x(2);
    % Adjust for the disparity
    view(axv(1), a+d, e);
    view(axv(2), a-d, e);
    
end
