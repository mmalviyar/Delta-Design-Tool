classdef triangle < handle
    properties
        %tri_list = [];
        %orientation = NaN; %Down
        %color = NaN; %red
        %tri_interface = [];
        %x = NaN;
        %y = NaN;
        %axno = NaN;
        %tri_graph = 0;
        %anchor = 0;
        %number = NaN;
    end
    methods
        function this = triangle()
            %nothing to add
        end


        function locd = neartri(this,loc,vertices,ori,orid,number)
                n = size(vertices,1);
                xmat = loc(1)*ones(n,1);
                ymat = loc(2)*ones(n,1);
                dis = sqrt((vertices(:,1)-xmat).^2 + (vertices(:,2)-ymat).^2);                
                if min(dis) <= 4              
                    N = find(dis ==min(dis));
                    loct = vertices(N,:);
                    x = loct(1); y = loct(2);
                    if ori(N) == 1 %UP Triangle
                        Case1 = [x-3:1:x+3; (y-4)*(ones(1,7))]'; % Bottom Case
                        Case2 = [x+0.5:0.5:x+3.5; y+3:-1:y-3]'; % Right Side
                        Case3 = [x-0.5:-0.5:x-3.5; y+3:-1:y-3]'; % Left Side
                    else
                        Case1 = [x-3:1:x+3; (y+4)*(ones(1,7))]'; % Bottom Case
                        Case2 = [x+0.5:0.5:x+3.5; y-3:1:y+3]'; % Right Side
                        Case3 = [x-0.5:-0.5:x-3.5; y-3:1:y+3]'; % Left Side
                    end
                    Neighbours = [Case1; Case2; Case3];
                    k = zeros(length(Neighbours),1);
                    for i = 1:length(Neighbours)
                        k(i) = this.find_tri(a,b,vertices,ori,orid,number);
                    end   
                    %del = find(k== 0);
                    poss_Neighbours = Neighbours(k==0);                
                    % Final Decision on closest ones
                    xmat2 = loc(1)*ones(length(poss_Neighbours),1);
                    ymat2 = loc(2)*ones(length(poss_Neighbours),1);
                    dist2 = sqrt((poss_Neighbours(:,1)-xmat2).^2 + (poss_Neighbours(:,2)-ymat2).^2);
                    Closest = find(dist2 ==min(dist2));
                    locd = poss_Neighbours(Closest(1),:);
                else
                    locd = loc;
                end
        end
               
        %Function to check if the triangle is possible or not at given
        %position
        function K = find_tri(this,x,y,Def_vertices,ori,orid,number)
            K = 0;
            if orid == 1
                Xc = [(x-2:0.125/2:x+2),(x+1.875:-0.25/2:x-1.875)];
                Yc = [(y-2:0.25/2:y+2),(y+1.875:-0.25/2:y-2),((y-2)*ones(1,31))];
            else
                Xc = [(x-2:0.125/2:x+2),(x+1.875:-0.25/2:x-1.875)];
                Yc = [(y+2:-0.25/2:y-2),(y-1.875:0.25/2:y+2),((y+2)*ones(1,31))];
            end                
            if number > 1
                for i = 1: size(Def_vertices,1)
                    X = Def_vertices(i,1);
                    Y = Def_vertices(i,2);
                    %i
                    if ori(i) == 1 %UP
                        Xd = [X,X-2,X+2];
                        Yd = [Y+2,Y-2,Y-2];
                    end
                    if ori(i) == 0 % Down
                        Xd = [X,X-2,X+2];
                        Yd = [Y-2,Y+2,Y+2];
                    end
                    [in,on] = inpolygon(Xc,Yc,Xd,Yd);
                    if sum(in)>sum(on)
                        K = i; % A triangle Exist
                        break;
                    else
                        K = 0; % No triangle exist
                    end
                end
            else
                K = 0; %First triangle
            end
        end
        
        % Selecting Triangle
         %Function to check if the triangle is possible or not at given
        %position
        function K = select_tri(this,x,y,Def_vertices,ori,number)
         
            if number > 1
                for i = 1: length(ori)
                    X = Def_vertices(i,1);
                    Y = Def_vertices(i,2);
                    %i
                    if ori(i) == 1 %UP
                        Xd = [X,X-2,X+2];
                        Yd = [Y+2,Y-2,Y-2];
                    end
                    if ori(i) == 0 % Down
                        Xd = [X,X-2,X+2];
                        Yd = [Y-2,Y+2,Y+2];
                    end
                    [in,on] = inpolygon(x,y,Xd,Yd);
                    if sum(in)>sum(on)
                        K = i; % A triangle Exist
                        break;
                    else
                        K = 0; % No triangle exist
                    end
                end
            else
                K = 0; %First triangle
            end
        end
           
        %Rounding to nearest possible point when adding or moving triangle
        function loc = nearposspoint(this,x,y,vertices,def_vert,number,ori)
                n = length(vertices);
                xmat = x*ones(n,1);
                ymat = y*ones(n,1);
                dis = sqrt((vertices(:,1)-xmat).^2 + (vertices(:,2)-ymat).^2);
                N = find(dis == min(dis));
                loc = vertices(N,:);
%                 if number > 1
%                     loc = neartri(this,loc,def_vert,ori,orid,number); % Closest Point    
%                 end
        end
        
        %Rounding off
        function loc = nearposspoint2(this,x,y,vertices)
                n = length(vertices);
                xmat = x*ones(n,1);
                ymat = y*ones(n,1);
                dis = sqrt((vertices(:,1)-xmat).^2 + (vertices(:,2)-ymat).^2);
                N = find(dis ==min(dis));
                X = vertices(N,1);
                Y = vertices(N,2);
                loc = [X Y];
%                 if number > 1
%                     loc = neartri(this,loc,def_vert,ori); % Closest Point    
%                 end
        end
        
    end
end