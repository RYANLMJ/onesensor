module tx_sys(eoc, adc_data, adc_clock, start, ale, oe, address, reset, clock, txPin);

 input eoc;
 integer selectInput=3'b000;
 input [7:0] adc_data;
 
 output adc_clock, start, ale, oe;
 output [2:0] address;
 
 wire [7:0] out_data;
 
 adc_Controller U6(reset, clock, adc_clock, selectInput, eoc, adc_data, start, ale, oe, address, out_data);

 
 input reset, clock;
 output txPin;
 
 wire [7:0] data;
 wire rst, thirtyEightKHz, ready; 
 reg swSend;
 
 assign rst=~reset;
 assign data=out_data;
 

always @(posedge clock) 
 begin
  swSend = eoc;
 end
 

 freq38K U4(rst, clock, thirtyEightKHz);
 uart_tx U5(rst, thirtyEightKHz, swSend, data, txPin, ready);
 
 
 endmodule 