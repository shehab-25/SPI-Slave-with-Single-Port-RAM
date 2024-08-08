module SPI_Wrapper (clk,rst_n,MOSI,ss_n,MISO);
    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE = 8;
    parameter IDLE = 3'b000;
    parameter CHK_CMD = 3'b001;
    parameter WRITE = 3'b010;
    parameter READ_ADD = 3'b011;
    parameter READ_DATA = 3'b100;

    input clk , rst_n , MOSI , ss_n;
    output MISO;
    wire rx_valid , tx_valid;
    wire [7:0] tx_data;
    wire [9:0] rx_data;

    SPI_Slave #(IDLE,CHK_CMD,WRITE,READ_ADD,READ_DATA) SPI(clk,rst_n,ss_n,MOSI,tx_valid,tx_data,MISO,rx_data,rx_valid);
    RAM #(MEM_DEPTH,ADDR_SIZE) ram(clk, rst_n, rx_valid, rx_data, tx_valid, tx_data);
    
endmodule