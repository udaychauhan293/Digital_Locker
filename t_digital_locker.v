module t_digital_locker; //test bench module for digital_locker is declared. 
  
  wire [1:0] t_y_out; //output is decalred as wire data type with 2 bits. 
  
  reg [7:0]t_x_in ; //input port x_in is declared as reg data type with 8 bits. 
  
  reg t_clock , t_reset; //clock and reset are declared as reg data type. 8003
  
  digital_locker DL_1(t_y_out , t_x_in , t_clock , t_reset); //The main module is initialised here(called here).
  
  initial #100   $finish; //The simulation is stopped after '100' time units. 8003
  
  initial
    begin
      
      $dumpfile("digital_locker.vcd"); //these statements are included so as to get the timing diagrams of the input and output. 
      $dumpvars(0,t_digital_locker);
             
      
      t_clock = 0; //the clock is initially set to zero.
      
      forever #5t_clock = ~t_clock; //clock is complemented every '5' time units and hence the time period of clock is 10 time units. 
      
    end
  
  initial 
    fork //fork and join block is used and hence the time delay is relative to t = 0. 
    
      t_reset = 0;   //reset is initially zero so that it acts as a self-starting lock. 
      
 #10 t_reset = 1;
      #5  t_x_in = 8'b00101001;      //wrong pin is entered(29). 
      
      #15 t_x_in = 8'b00100110;      //wrong pin is entered(26). 
      
      #25 t_x_in = 8'b00010000;      //wrong pin is entered(10). 
      
      #35 t_x_in = 8'b00100001;      //wrong master pin is entered(21). 
      
      #45 t_x_in = 8'b10000000;      //correct master pin is entered(80).   
      
      #55 t_x_in = 8'b10010010;      //wrong pin is entered (92). 
      
      #65 t_x_in = 8'b00000011;      //correct pin is entered(03). 
    
  join
  
  initial
    begin
      
      $monitor("x_in = %b , y_out = %b",t_x_in,t_y_out);    //$monitor is used to print the output , the output is printed whenever there is a change in the argument i.e change in x_in and y_out.
      
    end
  
  
endmodule
