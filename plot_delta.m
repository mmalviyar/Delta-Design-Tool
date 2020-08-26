function tridelta = plot_delta(Res)

% clear all
% Res = 10;
Lx = Res + 2;
Ly = 2*Lx + 4;

%% Defining Coordinates
No_of_coord = Lx*Ly;
Vert = zeros(No_of_coord,2);
j= 0;
for i = 1:Ly
    if i == 1
        k =1;
    else
        k = j+1;
    end
    j = Lx + j;
    Vert(k:j,:) = [linspace(0,Lx-1,Lx)', (i-1)*ones(Lx,1) ];
end

%% Defining Elements in Mesh
k = 1;
ve = 1;
for j = 1:4:Ly-4
l = (j-1)*Lx + 1;
h = (j*Lx)-2;
for i = l:2:h
    a = i;
    b = i + 2;
    c = 4*Lx + i + 2;
    d = 4*Lx + i ;
    m = 2*Lx + i + 1;
    ad = 2*Lx + i;
    cb = 2*Lx + i + 2;
    cd = 4*Lx + i + 1;
    ab = i + 1;
    poC(ve)= c;
    poA(ve) = a;
    poB(ve) = b;
    poD(ve) = d;
    poCD(ve)= cd;
    poAB(ve) = ab;
    poCB(ve) = cb;
    poAD(ve) = ad;
    poM(ve) = m;
    ve = ve +1;
    Tri(k:k+7,:) = [ m ad a ; m a ab ; m ab b; m b cb ; m cb c ; m c cd ; m cd d; m d ad];
    k = k + 8;
end
end

%% Possible Points
k = 1;
for i = 1:length(poC)
    con = find(poD==poC(i));
    if con >0
        poss_points2(k) = poC(i);
        k = k+1;
    end        
end
poss_points2(k:k+length(poM)-1) = poM;
PossVertices = Vert(poss_points2,:);
K = find(PossVertices(:,1)<4 | PossVertices(:,1)>Lx-6 |PossVertices(:,2)> Ly-8|PossVertices(:,2)<4 );
PossVertices(K,:) = [];

notposs = [2:4*Lx:(Ly-4)*Lx+2,Lx-1:4*Lx:(Ly-4)*Lx+ (Lx -1)];
k = 1;
for i = 1:length(poCB)
    con = find(poAD==poCB(i));
    if con >0
        poss_points(k) = poCB(i);
        k = k+1;
    end        
end
for i = 1:length(poCD)
    con = find(poAB==poCD(i));
    con2 = find(notposs == poCD(i));
    if con2 
        not = 0;
    else
        not = 1;
    end
    if norm(con) > 0 && not>0
        poss_points(k) = poCD(i);
        k = k+1;
    end        
end
Poss_vert = Vert(poss_points,:);

%% -ve axes
Xmax = max(Vert(:,1));
Ymax = max(Vert(:,2));
NoAxes = floor(Xmax/2);
%MidAx = floor(NoAxes/2);
Ax = zeros((Ymax+1)/2,2,NoAxes);
g = 1;
for k = NoAxes:-1:1
    i = -2*(k-1);
    X = i:1:(Ymax-1)/2 + i;
    Y = 0:2:Ymax-1;
    Ax(:,:,g) = [X' Y'];
    Axno(g) = -k + 1;
    g = g + 1;
   
end
%+ve axes
for k = 2:NoAxes
    i = 2*(k-1);
    X = i:1:(Ymax-1)/2 + i;
    Y = 0:2:Ymax-1;
    Ax(:,:,g) = [X' Y'];
    Axno(g) = k - 1;
    g = g + 1;
end

%%
tridelta.vertices= Vert;
tridelta.faces = Tri;
tridelta.deltapoints = Poss_vert;
tridelta.Possvertices = PossVertices;
tridelta.Axes = Ax;
tridelta.Axno = Axno;
end