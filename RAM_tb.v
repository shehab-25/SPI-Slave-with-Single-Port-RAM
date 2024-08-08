module test_ram();
    // signal declaration
    parameter MEM_DEPTH=256;
    parameter ADDR_SIZE=8;
    reg clk, rst_n, rx_valid;
	reg [ADDR_SIZE+1:0] din;

	wire tx_valid;
	wire [ADDR_SIZE-1:0] dout;
    integer i=0;

    // module instance
    RAM #(MEM_DEPTH,ADDR_SIZE) RAM_DUT(clk, rst_n, rx_valid, din, tx_valid, dout);
    // generate clock
    initial begin 
    clk=0;
    forever
    #1 clk=~clk;
    end 
    initial begin
        $readmemh("mem.dat",RAM_DUT.mem);
        rst_n=0;
        din=0;
        rx_valid=1;
        @(negedge clk);
        rst_n=1;
        din[9:8]=2'b00;
        din[7:0]=8'b11100110;
        @(negedge clk);
        din[9:8]=2'b01;
        din[7:0]=8'b11100110;
        @(negedge clk);
        din[9:8]=2'b10;
        din[7:0]=8'b11100110;
        @(negedge clk);
        din[9:8]=2'b11;
        din[7:0]=8'b11100110;
        @(negedge clk);
        
        $stop;
    end
endmodule