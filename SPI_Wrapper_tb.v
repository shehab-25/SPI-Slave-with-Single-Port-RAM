                                        //***  Testbench for the top module SPI Wrapper   ***//

module SPI_Wrapper_tb();

    parameter MEM_DEPTH = 256;
    parameter ADDR_SIZE = 8;
    parameter IDLE = 3'b000;
    parameter CHK_CMD = 3'b001;
    parameter WRITE = 3'b010;
    parameter READ_ADD = 3'b011;
    parameter READ_DATA = 3'b100;

    // signal declaration
    reg clk , rst_n , MOSI , ss_n;
    wire MISO;

    integer i = 0;

    // Module instantiation
    SPI_Wrapper #(MEM_DEPTH,ADDR_SIZE,IDLE,CHK_CMD,WRITE,READ_ADD,READ_DATA) SPI_Wrapper_DUT (clk,rst_n,MOSI,ss_n,MISO);

    // clock generation
    initial begin
        clk=0;
        forever
        #1 clk=~clk;
    end

    initial begin
        $readmemh("mem.dat" ,SPI_Wrapper_DUT.ram.mem);
        rst_n=0;  // initialize Design
        ss_n=1; 
        MOSI=1;
        @(negedge clk);
        rst_n=1;
        ss_n=0;

        // Write Address 1
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

        // Write Data 1 
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
        
        // Read Address 1 
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

        // Read Data 1
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
        repeat(9) @(negedge clk);

        ss_n=1;
        @(negedge clk);
        
        // write address 2
        ss_n=0;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        MOSI=0;
        @(negedge clk);
        for(i=0;i<8;i=i+1) begin
            MOSI=1;
            @(negedge clk);
        end
        ss_n=1;
        @(negedge clk);

       // Write Data 2
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
        @(negedge clk);

        // Read Address 2 
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
        @(negedge clk);

        // Read Data 2
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
        repeat(9) @(negedge clk);
        ss_n=1;
        @(negedge clk);
        $stop;
    end

    endmodule
