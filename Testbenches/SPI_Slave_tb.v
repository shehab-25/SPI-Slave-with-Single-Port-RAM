                                        //***  Testbench for the SPI Slave   ***//

module SPI_Slave_tb();

    //FSM states
    parameter IDLE = 3'b000;
    parameter CHK_CMD = 3'b001;
    parameter WRITE = 3'b010;
    parameter READ_ADD = 3'b011;
    parameter READ_DATA = 3'b100;

    // signal declaration
    reg clk , rst_n , ss_n , MOSI , tx_valid;
    reg [7:0] tx_data;
    wire MISO , rx_valid;
    wire [9:0] rx_data;

    integer i = 0;

    SPI_Slave #(IDLE,CHK_CMD,WRITE,READ_ADD,READ_DATA) SPI_Slave_DUT(clk,rst_n,ss_n,MOSI,tx_valid,tx_data,MISO,rx_data,rx_valid);

    initial begin
        clk=0;
        forever
        #1 clk=~clk;
    end

    initial begin
        rst_n=0; 
        ss_n=1; 
        MOSI=1;
        @(negedge clk);
        rst_n=1;
        ss_n=0;

        // Write Address Test Case

        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        for(i=0;i<8;i=i+1) begin
            MOSI=$random;
            @(negedge clk);
        end
        
        ss_n=1;

        // Write Data Test Case
        @(negedge clk);
        ss_n=0;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        MOSI=1;
        @(negedge clk);
        for(i=0;i<8;i=i+1) begin
            MOSI=$random;
            @(negedge clk);
        end
        
        ss_n=1;
        
        // Read Address Test Case
        @(negedge clk);
        ss_n=0;
        @(negedge clk);
        MOSI=1;
        @(negedge clk);
        MOSI=1;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        for(i=0;i<8;i=i+1) begin
            MOSI=$random;
            @(negedge clk);
        end
        
        ss_n=1;

        // Read Data Test Case
        @(negedge clk);
        ss_n=0;
        @(negedge clk);
        MOSI=1;
        @(negedge clk);
        MOSI=1;
        @(negedge clk);
        MOSI=1;
        @(negedge clk);
        for(i=0;i<8;i=i+1) begin
            MOSI=$random;
            @(negedge clk);
        end
        
        tx_valid = 1;
        tx_data = 8'b11101001;
        repeat(9)
            @(negedge clk);
        ss_n=1;
        repeat(2)
            @(negedge clk);
        
        
        $stop;
    end

    endmodule
