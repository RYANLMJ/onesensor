module adc_Controller(reset, clock, adc_clock, selectInput, eoc, adc_data, start, ale, oe, address, out_data);

 input reset, clock, eoc;
 input [2:0] selectInput;
 input [7:0] adc_data;
 
 output adc_clock, start, ale, oe;
 output [2:0] address;
 output [7:0] out_data;
 
 wire rst, adc_start;
 
 assign rst=~reset;
 assign address=selectInput;
 freqADC U1(1, clock, adc_clock);
 genStart U2(rst, adc_clock, adc_start);
 adcFSM U3(rst, adc_start, eoc, adc_data, adc_clock, oe, ale, start, out_data);

endmodule
