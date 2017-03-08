

function postSyncAxes(lp, axv, ~, ~)
    
    % Remove the view sync
    removeprop(lp, 'View')
    % Get the axes view
    x = axv(1).View;
    a = x(1);
    e = x(2);
    % Adjust for the disparity
    view(axv(1), a+1, e);
    view(axv(2), a-1, e);
    
end

