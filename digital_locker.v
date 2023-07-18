module digital_locker( output reg [1:0] y_out , input  [7:0] x_in ,  input clock , reset); //declaring the module with 8 bit input(2 bit decimal input has 8 bit BCD ) , clock , reset and 2 bit output. 
  
  reg[2:0] state , next_state; //declaring the variables state and nex_state. 
  
  parameter S0 = 3'b000 , S1 = 3'b001 , S2 = 3'b010 , S3 = 3'b011 , S4 = 3'b100; // delcaring the states. 
  
  //S0 : start state , no input is given. 
  //S1 : wrong pin is entered once. 
  //S2 : wrong pin is entered twice. 
  //S3 : locked state(wrong pin is entered thrice). 
  //S4 : lock is open(correct pin is entered in one of the three chances). 
  
  always@(posedge clock , negedge reset) //always block is used so that state changes only if there is a positive edge or negative edge of reset. 

    if(reset==0)
      state <= S0; //The present state becomes 'S0' if reset is '0'.
  else
    state <= next_state; //It goes to next state if reset is '1'. 
  
  always@(state , x_in) //forming the state transitions.
    
    //Since my roll number ends in '8003' the master pin is '10000000' and decimal pin is '00000011'. 
    
    case(state) //Case statement it is a multiway conditional branch construct.Whenever the value of 'state' changes case statement is executed and it compares the values from top to bottom until correct case is found.
      
      
      S0:   if(x_in == 8'b00000011) next_state = S4; else next_state = S1; //If the FSM is in state 'S0' and the input is 00000011 then it goes to the state 'S4'. 
      S1:   if(x_in == 8'b00000011) next_state = S4; else next_state = S2; //If the FSM is in state 'S1' and the input is 00000011 then it goes to the state 's4'. 
      S2:   if(x_in == 8'b00000011) next_state = S4; else next_state = S3; //If the FSM is in state 'S2' and the input is 00000011 then it goes to the stagte 'S4'.
      S3:   if(x_in == 8'b10000000) next_state = S0; else next_state = S3; //If the FSM is in state 'S3' and the input is 10000000(master pin) then it goes to the state 'S0'. 
      
    endcase
  
  always@(state , x_in) //forming the output of the FSM. 8003.
    case(state) //Case statement it is a multiway conditional branch construct.Whenever the value of 'state' changes case statement is executed and it compares the values from top to bottom until correct case is found. 
      
      
      S0: if(x_in ==  8'b00000011) y_out = 11; else y_out = 00; //If the FSM is in state 'S0' and the input is 00000011(correctpin) then the output is '11' else '00'. 
      
      S1: if(x_in ==  8'b00000011) y_out = 11; else y_out = 00; //If the FSM is in state 'S1' and correct pin is entered then the output is '11' else '00'. 
      
      S2: if(x_in ==  8'b00000011) y_out = 11; else y_out = 01; //If the FSM is in state 'S2' and correct pin is entered then the output is '11' else '01'. 
      
      S3: if(x_in ==  8'b10000000) y_out = 10; else y_out = 01; //If the FSM is in state 'S3' and correct master pin is entered then the output is '10' else '01'. 
      
    endcase
    
endmodule 
