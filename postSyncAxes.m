

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

