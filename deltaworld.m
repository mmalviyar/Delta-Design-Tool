classdef deltaworld < handle
    
    properties
        coordinates = [];
        color = [];
        orientation = [];
        Seq_tri = [];
        Rel = [];
        dist_rel = [];
        color_rel = [];
        door = [];        
        anchor = [];
        anc = NaN;
        number = 1;
        Cost = 0;
        FOS = 0;
        thermal = 0;
        aesthetics = 0;         
        tri_axis = [];
        axes = [];
        axno = [];         
        Vertices = [];
        delta = triangle();
        check = NaN;
        COGax = NaN;
        COG = [];
        cus_sat = 0;
        Inside_Area = NaN;
        SCORE = 0;
        door_length = NaN;
        
        
    end
    
    methods
        function this = deltaworld()
            % Nothing Right NOW
        end
        % INITIATING THE ENVIRONMENT WITH AXES NUMBER, POSSIBLE VERTICES and PLOTTING AXIS
        function deltaenv(this,Res)
            Lx = Res;
            Ly = Res;
            number_of_axes = Res-1;
            number_of_vert = 2*(Lx-4)*(Ly-4);
            % Defining Possible Coordinates ZigZag
            % Vert = [ 0,1 | 1,1 | 2,1 | 0,2 ];
            this.Vertices = zeros(number_of_vert,2);
            j = 0;
            for i = 2:1:Ly-3
                x = 2:0.5:Lx-3;
                k = j + 1;
                j = j + 2*(Lx - 4) - 1; 
                y = (i)*ones(length(x),1);
                this.Vertices(k:j,:) = [x',y];
            end
            % Axes
            temp = this.Vertices(:,1) - this.Vertices(:,2);
            minax = min(temp);
            maxax = max(temp);
            this.axno = minax:1:maxax;
            this.axes = zeros(2,2,number_of_axes);
            xm = max(this.Vertices(:,1)); ym = max(this.Vertices(:,2));
            for i = 1:length(this.axno)
                if this.axno(i) ~= 0 
                Coord = [this.axno(i) ym+this.axno(i) 0 xm; 0  ym -this.axno(i) xm-this.axno(i)];
                K1 = find(Coord(1,:)<0); K2 = find(Coord(2,:)<0); 
                K3 = find(Coord(1,:)>xm); K4 = find(Coord(2,:)>ym);
                K = [K1 K2 K3 K4];
                K = K(K>0);
                Coord(:,K) = [];
                this.axes(:,:,i) = Coord';
                else
                    this.axes(:,:,i) = [0  0; xm ym];
                end
            end
            % Saving the vertices, Axes and Axno
             %tridelta.vertices= this.Vertices;
             %tridelta.Axes = this.axes;
             %tridelta.Axno = this.axno;
        end
        
        % Saving Everything-----------------
        function save_state(this,action)  
            % Adding UP Triange, Down Triangle, Anchor
            % Revising Flip, Move, Color and Delete
            % Open PDF for problem statement
            % Control Options Undo Redo
            % Design Performance at every state
            
        end
        
        % Adding a triangle-------------------------------------------
        
        function [msg,success] = add_delta(this, loc, colr, orid)
                               
                 x = loc(1); y = loc(2);
                 no = this.number;
                 vertices = this.Vertices;
                 if strcmp(colr,'r')
                     string = "RED";
                 else
                     string = "BLUE";
                 end                
                %checkpossiblity
                locd = this.delta.nearposspoint(x,y,vertices,this.coordinates,this.number,this.orientation);
                x = locd(1); y = locd(2);
                if no > 1
                    defvert = this.coordinates;
                    ori = this.orientation;
                    K = this.delta.find_tri(x,y,defvert,ori,orid,no);
                else
                    K = 0;
                end
                if K == 0
                    this.addtriangle(round(x),round(y),orid,colr,no); %1 is UP and 0 is Down
                    this.number = this.number + 1;
                    if orid == 1
                        msg = string + "-UP triangle add succesfully";
                    else
                        msg = string + "-DOWN triangle added successfully";
                    end
                    success = 1;
                else
                    msg = "Try Again, there is an overlap between triangles";
                    success = 0;
                end
        end
        
        function addtriangle(this,x,y,ori,colr,idx) %Adding Triangle
            this.coordinates(idx,:) = [x y];
            this.orientation(idx) = ori;
            this.tri_axis(idx) = round(x - y,1);
            if colr == 'r'
                c = 1; %RED
            else
                c = 0; %BLUE
            end
            this.color(idx) = c;
        end
        
        function  [msg,success] = del_delta(this, loc) % Deleting Triangle
                 x = loc(1); y = loc(2);     
                 %tri = app.tridelta.tri;
                 if this.number > 1
                    defvert = this.coordinates;
                    ori = this.orientation;
                    K = this.delta.select_tri(x,y,defvert,ori,this.number);
                 else
                    K = 0;
                 end
                 if K > 0
                     this.coordinates(K,:) = [];
                     this.color(K) = [];
                     this.orientation(K) = [];
                     this.tri_axis(K) = [];
                     %this.anchor(K) = 0;  
                     Anchor = find(this.anchor == 1);
                     AK = find(Anchor ==K);
                     if AK >0
                         this.anchor = zeros(this.number,1);  
                         this.anc = 0;
                     end
                     this.number = this.number - 1;
                     success = 1;
                     msg = "You just deleted a triangle";
                 else
                     success = 0;
                     msg = "No triangle nearby, Please Try Again";
                 end                  
        end
        
        function [msg,success] = movetri(this,loc,idx)
                defvert = this.coordinates;
                defvert(idx,:) = [];
                ori = this.orientation;
                locd = this.delta.nearposspoint(loc(1),loc(2),this.Vertices, defvert, this.number,ori);
                x = locd(1); y = locd(2);
                K = this.delta.find_tri(x,y,defvert,ori,ori(idx),this.number);
                if K == 0
                   this.coordinates(idx,:) = locd;                   
                   this.tri_axis(idx)= x - y;
                   success = 1;
                   msg = "Triangle Moved successfully";
                else
                   success = 0;
                   msg = "Moving not possible";
                end
                    
        end
        function [msg,success] = flip(this,idx)
            ori = this.orientation(idx);
            if ori == 1
                newori = 0;
            else
                newori = 1;
            end
            % Check if flip is possible
            loc = this.coordinates(idx,:);
            colr = this.color(idx);
                this.del_delta(loc);
            K = this.delta.find_tri(loc(1),loc(2),this.coordinates,this.orientation,newori,idx);
            if K ==0       
                if colr == 1
                    c = 'r';
                else
                    c = 'b';
                end
                this.add_delta(loc, c, newori);
                msg = "Triangle flipped";
                success = 1;
            else
                msg = "flip is not possible";
                success = 0;
            end              
            
        end
        
        function [msg,success] = changecolor(this,idx)
            colr = this.color(idx);
            if colr == 0
                newcolr = 1;
            else
                newcolr = 0;
            end
            % Check if flip is possible                 
                this.color(idx) = newcolr;
                %tri = app.tridelta.tri(idx,:);
                %tri(:,4) = newori;
                msg = "Color changed";
                success = 1;  
        end
        

        function [msg,success] = add_anchor(this,idx,anc)
            if idx > 0
                success = 1;
                this.anchor(idx) = 1;
                this.anc = anc;
                msg = "Added anchor";
            else
                msg = "Select a triangle";
                success = 0;
                
            end
        end
        
        % Check Design
        function tricheck = checkdesign(this)
            Def_vert = [this.coordinates,(1:this.number -1)'];
            colr = this.color;
            ori = this.orientation;
            DownTri = Def_vert(ori == 0,:);
            UpTri = Def_vert(ori == 1,:);
            DownTri(:,4) = colr(ori == 0);
            UpTri(:,4) = colr(ori == 1);
            % Step 1: Checking Design through Centre Point Relation
            Centre_rel = zeros(size(UpTri,1),size(DownTri,1));
            P = zeros(size(UpTri,1),size(DownTri,1));
            for i = 1:size(UpTri,1)
                x = UpTri(i,1); y = UpTri(i,2);                
                x = x+4; y = y+4; % so that x and y are never less than zero in analysis
                Case1 = [x-3:0.5:x+3; (y-4)*(ones(1,13))]'; % Bottom Case
                Case2 = [x+0.5:0.5:x+3.5; y+3:-1:y-3]'; % Right Side
                Case3 = [x-0.5:-0.5:x-3.5; y+3:-1:y-3]'; % Left Side
                
                for j = 1:size(DownTri,1)
                    xj = DownTri(j,1) + 4;
                    yj = DownTri(j,2) + 4;
                    K1 = find(Case1(:,1) == xj & Case1(:,2) == yj);
                        if norm(K1)>0
                            Centre_rel(i,j) = 1; 
                            P(i,j) = ceil(K1/2);
                        end
                    K2 = find(Case2(:,1) == xj & Case2(:,2) == yj);
                        if norm(K2)>0 
                            Centre_rel(i,j) = 2;
                            P(i,j) = K2;
                        end
                    K3 = find(Case3(:,1) == xj & Case3(:,2) == yj);
                         if norm(K3)>0 
                             Centre_rel(i,j) = 3; 
                             P(i,j) = K3;
                         end
                end
            end
            this.Rel = Centre_rel;
            dist_Rel = this.distance_rel(P);
            % Color Relation
            %1: RR 2: RB 3:BB
            Colrel = zeros(size(UpTri,1),size(DownTri,1));
            for i = 1:size(UpTri,1)
                for j = 1:size(DownTri,1)
                    if Centre_rel(i,j)>0
                       Colrel(i,j) =  UpTri(i,4) + DownTri(j,4) + 1;
                    end
                end
            end
            %Inside_Area = round(polyarea(Def_vert(:,1),Def_vert(:,2)));
            % Checking Design
            for i = 1:size(UpTri,1)
                K = find(Centre_rel(i,:)>0);
                CountUP(i) = length(K);  
            end
            for i = 1:size(DownTri,1)
                K = find(Centre_rel(:,i)>0);
                CountDown(i) = length(K);   
            end

            Count = [CountUP CountDown];
                      
            Checkone = find(Count == 1);
            Checktwo = find(Count ~=2 & Count ~=1);
            %Checkthree = Inside_Area - 200;    
            Temp_Tri = [UpTri; DownTri];  
            this.door = Temp_Tri(Checkone,3);            
            
            if  length(Checkone) == 2 && isempty(Checktwo)
                %CHCK = 1; %GOOD DESIGN
                %Temp_Tri = [UpTri; DownTri];  
                %Tri_no_door = Temp_Tri(Checkone,3);
                Axno_door = this.tri_axis(this.door);
                doorlength = abs(Axno_door(1) - Axno_door(2));
                CHCK = 1;
            else
                CHCK = 0; %BAD DESIGN
                doorlength = 0;
            end
            tricheck.doorlength = doorlength;
            this.door_length = doorlength;
            tricheck.checkdesign= CHCK;
            tricheck.uptri = UpTri;
            tricheck.downtri = DownTri;
            tricheck.trirelation = Centre_rel;
            tricheck.tridisrel = dist_Rel;
            %tricheck.insider_area = Inside_Area;
            tricheck.errortype1 = Checkone;
            tricheck.errortype2 = Checktwo;
            tricheck.door = Checkone;
            tricheck.colorrel = Colrel;
        end

        %Getting Sequence of triangles
        function Seq = trirel(this,UpTri,DownTri,C,doortri,cse)
            i = doortri(1); d = doortri(2);
            Trinoup = UpTri(:,3); 
            Trinodn = DownTri(:,3);
            no_of_del = length([Trinoup; Trinodn]);
            Seq = zeros(no_of_del,1);
            p = 1;
            if cse ==1 
                 dir = 1;
                 Seq(p) = Trinodn(i);
                 Seq(end) = Trinoup(d);

            elseif cse == 2
                 dir = 1;
                 Seq(p) = Trinodn(i);
                 Seq(end) = Trinodn(d);
            else
                 dir = 0;
                 Seq(p) = Trinoup(i);
                 Seq(end) = Trinoup(d);
            end
            p = 2;
            j = 0;
            while p < no_of_del
                    if dir == 1 && p < no_of_del
                        temp = find(C(:,i)>0);
                        %k = find(temp~=j)
                        temp2 = Trinoup(temp(temp~=j)); 
                        Seq(p) = temp2;
                        j = i;
                        i = find(Trinoup == temp2);
                        p = p+1;
                        dir = 0;
                    end
                    if dir == 0 && p < no_of_del
                        temp = find(C(i,:)>0);
                        %k = find(temp~=j)
                        temp2 = Trinodn(temp(temp~=j)); 
                        Seq(p) = temp2;
                        j = i;
                        i = find(Trinodn == temp2);
                        p = p+1;
                        dir = 1;
                    end
            end
            this.Seq_tri = Seq;

        end

        
        % Distance Interaction
        function dist = distance_rel(this,P)
        [m,n] = size(P);
        dist = zeros(m,n);
            for i = 1:m
                for j = 1:n
                   if P(i,j) ==4
                       dist(i,j) = 1; end
                   if P(i,j) == 3 || P(i,j) == 5
                       dist(i,j) = 0.75; end
                   if P(i,j) == 2 || P(i,j) == 6
                       dist(i,j) = 0.5; end
                   if P(i,j) == 1 || P(i,j) == 7
                       dist(i,j) = 0.25; end          
                end
            end
            this.dist_rel = dist;
        end
        
      
        
        % Calculate Objective Function
        function [reesult,exist] = cal_objfun(this)
                %Def_vert = app.tridelta.tri(2:3,:);
                colr = this.color;
                ori = this.orientation;
                tricheck = this.checkdesign();
                if tricheck.checkdesign == 1
                         UpTri= tricheck.uptri;
                         DownTri=tricheck.downtri;
                         C = tricheck.trirelation;
                         disrel = tricheck.tridisrel;
                         colrel = tricheck.colorrel;
                    % Sorting
                         dor = tricheck.door;
                         brekpoint = size(UpTri,1);
                         p = find(dor>brekpoint);
                         q = find(dor<=brekpoint);
                         if length(p) == 1
                             doortri(1)= dor(p)-brekpoint;
                             doortri(2)= dor(q);
                             cse = 1;
                         elseif length(p) == 2
                             doortri = dor(p)-[brekpoint brekpoint];
                             cse = 2;
                         else
                             doortri = dor(q);
                             cse = 3;
                         end
                         TriSEQ = this.trirel(UpTri,DownTri,C,doortri,cse);
                            
                    % COG
                    Axdelta = this.tri_axis;
                    ax_COG = sum(Axdelta)/(this.number - 1);
                    ax_COGr = round(ax_COG);
                    this.COGax = ax_COGr;
                    this.COG = [mean(this.coordinates(:,1)), mean(this.coordinates(:,2))];
                    % Estimating Anchor Loads
                        %finding anchor axes and loads
                        ax_anc1 = Axdelta(this.anchor(1));
                        ax_anc2 = Axdelta(this.anchor(2));
                        AB = norm(ax_anc1 - ax_anc2);
                        GB = norm(ax_COGr - ax_anc2);
                        ratio = GB/AB;
                        X = ratio*length(ori);
                        Y = length(ori) - X;
                        FOSX = abs(15/X);
                        FOSY = abs(15/Y);
                        this.FOS = min(FOSX,FOSY);
                        % AREA OF THE INSIDE
                        this.Inside_Area = polyarea(this.coordinates(TriSEQ,1),this.coordinates(TriSEQ,2));
                       
%                      lendoor = norm(Axdelta(door(1)) - Axdelta(door(2)));             

                     % Project Budget Estimation

                        % Cost
                          % Delta Cost
                          Rtri = find(colr == 1); %Red
                          Btri = find(colr == 0); %Blue
                          if length(Rtri)>12
                              Detlatri_red = length(Rtri)*6;
                          else
                              Detlatri_red = length(Rtri)*8;    
                          end
                          if length(Btri)>8
                              Detlatri_blue = length(Btri)*6;
                          else
                              Detlatri_blue = length(Btri)*10;
                          end
                          Deltatricost = Detlatri_red + Detlatri_blue;
                          k = 1;
                          CostJoin = 0;
                          % Joining Cost
                          for i = 1:size(UpTri)
                              for j = k:size(DownTri)
                                  if colrel(i,j) == 1
                                      CostJoin = 10*disrel(i,j)+ CostJoin;
                                  end
                                  if colrel(i,j) == 2
                                      CostJoin = 20*disrel(i,j)+ CostJoin;
                                  end
                                  if colrel(i,j) == 3
                                      CostJoin = 5*disrel(i,j) + CostJoin;
                                  end
                              end
                              k = k+1;
                          end
                        % ModJoinCost
                         numoftri = length(ori);
                         %Mod4 = 2; Mod2 = 1; 
                         if numoftri >= 10
                             Mod4 = round(0.4*numoftri)/4;
                             Mod2 = round(0.2*numoftri)/2;
                         elseif numoftri >= 2
                             Mod4 = 0;
                             Mod2 = round(0.6*numoftri)/2;
                         else
                             Mod4 = 0;
                             Mod2 = 0;
                         end

                         if 4*Mod4 + 2*Mod2 <= numoftri
                             Mod1 = numoftri-4*Mod4 - 2*Mod2;
                             Total_Mod = Mod1 + Mod4 + Mod2;
                         else
                              %damn = msgbox('You gotta learn how to sum BRO');
                              %uiwait(damn,3); 
                         end
                        % Time
                         Time = 1*Mod1 + 2*Mod2 + 4*Mod4 + 4*(Total_Mod - 1);
                        % Workforce Cost
                         this.Cost = Deltatricost + CostJoin + 5*Time + 8*(Total_Mod - 1);
                         this.Cost = 1.5*this.Cost; % Overhead COST
                     % Thermal Managment
                         Colrseq = colr(TriSEQ);
                         thermalstable = 1;
                         for i = 1:length(Colrseq)-2
                             Sumtherm = Colrseq(i) + Colrseq(i+1) + Colrseq(i+2); 
                             if Sumtherm==3
                                 thermalstable = 0;
                                 break;                 
                             end
                         end

                     % Aesthetics
                        % One quarter Area
                        % INT/EXT wall length ratio
                        % No of Blue Triangles and four tri aesthetics
                          NoofBLUE = length(Btri);
                          Blueperc = NoofBLUE/length(colr);
                          colrstable = 1;
                         for i = 1:length(Colrseq)-3
                             Sumcolr = Colrseq(i) + Colrseq(i+1) + Colrseq(i+2) + Colrseq(i+3); 
                             if Sumcolr== 0
                                 colrstable = 0; %
                                 break;                 
                             end
                         end
                    exist = 1;
                    if thermalstable == 1
                        this.thermal = "Thermally Stable";
                    else
                        this.thermal = "Thermally Unstable";
                    end
                    if colrstable == 1 && Blueperc <=0.6
                        this.aesthetics = "Aesthetic Design";
                    else
                        this.aesthetics = "Check if there are more than 4 blue together together";
                    end
                    FOS_NORM = abs(this.FOS - 1.3)/0.7;
                    COST_NORM = abs((this.Cost - 600)/(1500-600));
                                        
                    if this.FOS >=1 && this.Cost <=1500 && thermalstable == 1 && colrstable == 1 ...
                            && this.door_length <= 10 && this.door_length >=5 && this.Inside_Area/2 >= 100
                        Norm_Score = 1- 0.5*(FOS_NORM + COST_NORM);
                        if Norm_Score >= 0.75
                            this.cus_sat = "Excellent Design";
                        elseif Norm_Score >= 0.5
                            this.cus_sat = "Good Design";
                        elseif Norm_Score >= 0.25
                            this.cus_sat = "Accepted";
                        elseif Norm_Score > 0
                            this.cus_sat = "Accepted";
                        end
                    else
                        this.cus_sat = "Design is not acceptable, Please Revise";
                        Norm_Score = 0;
                    end
                    this.SCORE = Norm_Score;
                    reesult.Strength_Performance = this.FOS;
                    reesult.Thermal_Performance = this.thermal;
                    reesult.Aesthetic_Performance = this.aesthetics;
                    reesult.Cost_Performance = this.Cost;
                    reesult.tricheck = tricheck;
                    reesult.customer_satisfaction = this.cus_sat;

                else
                    %damn = msgbox('You need help BRO');
                    reesult.tricheck = tricheck;
                    exist = 0;
                    %uiwait(damn,3);
                end
       
        end
    end
        
end
 
