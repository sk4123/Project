% std for lin reg
function f = dev(exp,ac)
    if length(exp) == length(ac)
        f = sqrt(sum((exp-ac).^2)/(length(exp)-2));
    end
end