function [ sgd ] = ComputeNormlizedSGD( F1, F2, size1, size2)

h1 = size1(1); w1 = size1(2);
h2 = size2(1); w2 = size2(2);

N = 1000;
sgd = 0;
count = 0;

iteration = 0;
max_iteration = N * 10;
while (count < N && iteration < max_iteration)
    
    iteration = iteration + 1;
    
    d1 = one_iteration(F1, F2, h1, w1, h2, w2);
    if d1 < 0
        continue;
    end
    
    d2 = one_iteration(F2, F1, h2, w2, h1, w1);
    
    if d2 < 0
        continue;
    end
    
    count = count + 1;
    sgd = sgd + (d1 + d2) / 2;
end

sgd = min(sgd / N, 1);

end


function d = one_iteration(F1, F2, h1, w1, h2, w2)
d = -1;

factor1 = 1 / sqrt(h1 * h1 + w1 * w1);
factor2 = 1 / sqrt(h2 * h2 + w2 * w2);

m = round([w1.*rand(), h1.*rand()]);
epiLine1 = epipolarLine(F1,m);
borderline1 = lineToBorderPoints(epiLine1,[h2, w2]);
if borderline1(1) < 0
    return;
end

m1 = find_point_in_line(epiLine1,borderline1);

epiLine2 = epipolarLine(F2,m);
d1_ = d_from_point_to_line(m1, epiLine2);

d1_ =  d1_ * factor2;


epiLine3 = epipolarLine(F2',m1);
d1 = d_from_point_to_line(m, epiLine3);

d1 = d1 * factor1;

d = (d1 + d1_) / 2;

end



function m = find_point_in_line(epiLines, borderlines)
m_x = borderlines(1) + (borderlines(3) - borderlines(1)) * rand();
m_y = - (epiLines(1) * m_x + epiLines(3)) / epiLines(2);
m = [m_x, m_y];
end

function distance = d_from_point_to_line(point, line)
    point(:,3) = 1;
    distance = abs(dot(point, line)) / (norm(line(1:2)) + 1e-10);
end
