% takes the sine waves and lines them up in phase
function h = zombie_train(volts,time,freq)
    l = size(volts,1);
    y1 = l > 1;
    y2 = l > 2;
    y3 = l > 3;
    y4 = l > 4;
    y5 = l > 5;

    a = [time(1,:);volts(1,:)];
    if y1
        b = [time(2,:);volts(2,:)];
    end
    if y2
        c = [time(3,:);volts(3,:)];
    end
    if y3
        d = [time(4,:);volts(4,:)];
    end
    if y4
        e = [time(5,:);volts(5,:)];
    end
    if y5
        f = [time(6,:);volts(6,:)];
    end

    ref = mean(mean(volts));
    fr = mean(freq);
    p = 2*pi()/fr;
    cutoff = find(~(a(1,:)-interp1(a(1,:),a(1,:),p,'nearest')));
    
    [~,ii] = min(abs(a(2,1:cutoff)-ref));
    time(1,:) = offset(a(2,:),ii,time(1,:),fr);
    
    if y1
        [~,ii] = min(abs(b(2,1:cutoff)-ref));
        time(2,:) = offset(b(2,:),ii,time(2,:),fr);
    end
    
    if y2
        [~,ii] = min(abs(c(2,1:cutoff)-ref));
        time(3,:) = offset(c(2,:),ii,time(3,:),fr);
    end
    
    if y3
        [~,ii] = min(abs(d(2,1:cutoff)-ref));
        time(4,:) = offset(d(2,:),ii,time(4,:),fr);
    end
    
    if y4
        [~,ii] = min(abs(e(2,1:cutoff)-ref));
        time(5,:) = offset(e(2,:),ii,time(5,:),fr);
    end
    
    if y5
        [~,ii] = min(abs(f(2,1:cutoff)-ref));
        time(6,:) = offset(f(2,:),ii,time(6,:),fr);
    end
    
    figure
    scatter(time(1,:),volts(1,:))
    hold on
    if y1
        scatter(time(2,:),volts(2,:))
    end
    if y2
        scatter(time(3,:),volts(3,:))
    end
    if y3
        scatter(time(4,:),volts(4,:))
    end
    if y4
        scatter(time(5,:),volts(5,:))
    end
    if y5
        scatter(time(6,:),volts(6,:))
    end
    legend('Increasing A','Increasing B','Increasing C','Decreasing A','Decreasing B','Decreasing C')
    title("Voltage vs time")
    ylabel("Voltage (V)")
    xlabel("Time (s)")
    hold off

    h = time;
end