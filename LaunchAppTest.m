classdef LaunchAppTest < matlab.uitest.TestCase
    properties
        App
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            testCase.App = DeltaDesign(101); %51 is default participant
            testCase.App.test_case = 1;
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    
    methods (Test)
        function test_add_up_red(testCase)
            no_of_deltas= length(testCase.App.world.orientation);                 
            test_coord = [10,10];
            test_click = 'normal';
            %testCase.App.test_case = 1;
            testCase.press(testCase.App.UP) 
            testCase.App.run_actions(test_coord,test_click);
            testCase.verifyEqual(length(testCase.App.world.orientation),no_of_deltas+1)                                        
        end  
        
        function test_add_up_blue(testCase)
            no_of_deltas= length(testCase.App.world.orientation);                 
            test_coord = [20,10];
            test_click = 'alt';
            %testCase.App.test_case = 1;
            testCase.press(testCase.App.UP) 
            testCase.App.run_actions(test_coord,test_click);
            testCase.verifyEqual(length(testCase.App.world.orientation),no_of_deltas+1)                                        
        end  
        
        
        function test_add_down_red(testCase)
            no_of_deltas= length(testCase.App.world.orientation);            
            
            test_coord = [30,30];
            test_click = 'normal';
            %testCase.App.test_case = 1;
            testCase.press(testCase.App.DOWN) 
            testCase.App.run_actions(test_coord,test_click);
            testCase.verifyEqual(length(testCase.App.world.orientation),no_of_deltas+1)                                        
        end     
        
        function test_add_down_blue(testCase)
            no_of_deltas= length(testCase.App.world.orientation);            
            
            test_coord = [30,10];
            test_click = 'alt';
            %testCase.App.test_case = 1;
            testCase.press(testCase.App.DOWN) 
            testCase.App.run_actions(test_coord,test_click);
            testCase.verifyEqual(length(testCase.App.world.orientation),no_of_deltas+1)                                        
        end     
        
        function test_delete(testCase)
            no_of_deltas= length(testCase.App.world.orientation);           
            test_coord = [30,30];
            test_click = 'normal';
            %testCase.App.test_case = 1;
            testCase.press(testCase.App.DEL) 
            testCase.App.run_actions(test_coord,test_click);
            testCase.verifyEqual(length(testCase.App.world.orientation),no_of_deltas-1)           
            
        end
        
        function test_flip(testCase)
            ori = [length(find(testCase.App.world.orientation==1)),length(find(testCase.App.world.orientation==0))];
            test_coord = [10,10];
            test_click = 'normal';
            %testCase.App.test_case = 1;
            testCase.press(testCase.App.FLIP) 
            testCase.App.run_actions(test_coord,test_click);      
            new_ori = [length(find(testCase.App.world.orientation==1)),length(find(testCase.App.world.orientation==0))];
            testCase.verifyNotEqual(new_ori,ori)                        
        
        end
%         
       function test_move(testCase)           
            test_coord1 = [10,10]; % Old Location 
            test_click = 'normal';            
            testCase.press(testCase.App.MOVE) 
            testCase.App.run_actions(test_coord1,test_click);
            test_coord = [20,20]; % New location
            testCase.App.run_actions(test_coord,test_click);
            
           % TO verify check if a triangle exists at test_coord
           locd = testCase.App.tri_obj.nearposspoint2(test_coord(1),test_coord(2),testCase.App.world.Vertices);
           K = testCase.App.tri_obj.select_tri(locd(1),locd(2),testCase.App.world.coordinates,testCase.App.world.orientation,testCase.App.world.number);
           
           if K > 0
               check = 1;
           else
               check = 0;
           end
           testCase.verifyEqual(check,1);        
             
            
       end
%         
        function test_color(testCase)
            colr = [length(find(testCase.App.world.color==1)),length(find(testCase.App.world.color==0))];           
            test_coord = [30,10];
            test_click = 'normal';
            testCase.press(testCase.App.CHCOLOR) 
            testCase.App.run_actions(test_coord,test_click);      
            new_colr = [length(find(testCase.App.world.color==1)),length(find(testCase.App.world.color==0))];  
            testCase.verifyNotEqual(new_colr,colr)             
            
        end
%        
%         function test_control(testCase)
%             
%         end
        
    end
end