function [] = myPoly(X,Y,n,p,fn)

XX = zeros(n,2);
YY = zeros(n,2);

if length(p.m) == 2
    rw_or_dsw = 1;
elseif length(p.m) == 1
    rw_or_dsw = 0;
else
    fprintf('Error: m should be length 1 or 2\n')
    return
end




if rw_or_dsw
    x0 = p.x0;
    y0 = p.y0;
    m  = linspace(p.m(1),p.m(2),n);
    for ii = 1:n
        yy = @(xx) m(ii)*(xx-x0)+y0;
        [x,y] = myBound(X,Y,yy);
        if length(x) == 3
            x = x(1:2);
            y = y(1:2);
        elseif isempty(x) || length(x)== 1
            for jj = 1:length(X) - 1
                bm = diff(Y(jj:jj+1))./diff(X(jj:jj+1));
                if bm == m(ii)
                    x = X(jj:jj+1);
                    y = Y(jj:jj+1);
                    break
                end
            end
        end
        XX(ii,:) = x;
        YY(ii,:) = y;
    end
else
    m = p.m;
    for ii = 1:length(X)
        x0 = X(ii);
        y0 = Y(ii);
        y = @(X) m*(X-x0)+y0;
        b(ii) = y(0);
    end
    b = linspace(max(b),min(b),n);
    for ii = 1:n
        
        
        y = @(X) m*X+b(ii);
        [x,y] = myBound(X,Y,y);
        if length(x) == 3
            x = x(1:2);
            y = y(1:2);
        elseif isempty(x) || length(x)== 1
            for jj = 1:length(X) - 1
                bm = diff(Y(jj:jj+1))./diff(X(jj:jj+1));
                if abs(bm-m)<0.001
                    x = X(jj:jj+1);
                    y = Y(jj:jj+1);
                    break
                end
            end
        end
        XX(ii,:) = x;
        YY(ii,:) = y;
    end
end
if n == 2
    plot(X,Y,'color',p.c,...
        'linewidth',p.lw)
else
    plotXY(XX,YY,fn,p)
end

end

function [newx,newy] = myBound(XX,YY,y)
xvec = [min(XX)-1,max(XX)+1];
yvec = y(xvec);
L1 = [XX;YY];
L2 = [xvec;yvec];

xy   = InterX(L1,L2);

newx = xy(1,:);
newy = xy(2,:);
end

function [] = plotXY(x,y,fn,p)
n = length(x);
figure(fn); hold on
for jj = 1:n
    plot(x(jj,:),y(jj,:),'color',p.c,...
        'linewidth',p.lw)
end

end

