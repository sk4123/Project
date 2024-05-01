% outputs the new time vector for the zombie_train function
function i = offset(a,ii,time,f)
    i = time - ii*time(2);
    zero = find(~i);
    a2 = a(zero:end);
    if a2(20)<a2(1)
        i = time - ii*time(2) + 3.5/f;
    end
end