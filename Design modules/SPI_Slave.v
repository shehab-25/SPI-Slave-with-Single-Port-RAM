module SPI_Slave (clk,rst_n,ss_n,MOSI,tx_valid,tx_data,MISO,rx_data,rx_valid);
    //FSM states
    parameter IDLE = 3'b000;
    parameter CHK_CMD = 3'b001;
    parameter WRITE = 3'b010;
    parameter READ_ADD = 3'b011;
    parameter READ_DATA = 3'b100;

    // signal inout
    input clk , rst_n , ss_n , MOSI , tx_valid;
    input [7:0] tx_data;
    output reg MISO , rx_valid;
    output reg [9:0] rx_data;
    (* fsm_encoding = "one_hot"*) //  or any other encoding type
    reg [2:0] cs,ns;
    reg [3:0] count_s_to_p , count_p_to_s;
    reg address_recived;

    // state memory
    always @(posedge clk) begin
        if (!rst_n) begin
            cs <= IDLE;
        end
        else begin
            cs <= ns;
        end
    end

    // next state logic
    always @(*) begin
        case (cs)
            IDLE: begin
                if (!ss_n) begin
                    ns = CHK_CMD;
                end
                else begin
                    ns = IDLE;
                end
            end 

            CHK_CMD: begin
                if (!ss_n) begin
                    if (!MOSI) begin  //write
                        ns = WRITE;
                    end
                    else if (MOSI) begin  //read
                        if (address_recived) begin
                            ns = READ_DATA;
                        end
                        else begin
                            ns = READ_ADD;
                        end
                    end
                end
                else begin
                    ns = IDLE;
                end
            end

            WRITE: begin
                if (!ss_n) begin
                    ns = WRITE;
                end
                else begin
                    ns = IDLE;
                end
            end

            READ_ADD: begin
                if (!ss_n) begin
                    ns = READ_ADD;
                end
                else begin
                    ns = IDLE;
                end
            end

            READ_DATA: begin
                if (!ss_n) begin
                    ns = READ_DATA;
                end
                else begin
                    ns = IDLE;
                end
            end
            default: ns = IDLE;
        endcase
    end

    // output logic
    always @(posedge clk) begin
        if(!rst_n) begin
            MISO <= 0;
            rx_data <= 0;
            rx_valid <= 0;
            count_s_to_p <= 1;
            count_p_to_s <= 1;
            address_recived <= 0;
        end
        else begin
            case (cs)
                WRITE: begin
                    if(count_s_to_p == 10) begin
                        rx_valid <= 1;
                        count_s_to_p <= 1;
                    end
                    else if (count_s_to_p != 10) begin
                        rx_valid <= 0;
                    end
                    if (count_s_to_p < 11) begin
                        rx_data[10-count_s_to_p] <= MOSI;
                        count_s_to_p <= count_s_to_p + 1;
                    end
                end

                READ_ADD: begin
                    if(count_s_to_p == 10) begin
                        rx_valid <= 1;
                        count_s_to_p <= 1;
                    end
                    else if (count_s_to_p != 10) begin
                        rx_valid <= 0;
                    end 
                    if (count_s_to_p < 11) begin
                        rx_data[10-count_s_to_p] <= MOSI;
                        count_s_to_p <= count_s_to_p + 1;
                    end
                    address_recived <= 1;
                end

                READ_DATA: begin
                    if (tx_valid) begin
                        if (count_p_to_s < 9) begin
                            MISO <= tx_data[8-count_p_to_s];
	    	                count_p_to_s <= count_p_to_s + 1;
                            count_s_to_p <= 1;
                        end
                        if (count_p_to_s == 8) begin
                            count_s_to_p <= 1;
                            count_p_to_s <= 1;
                        end
                    end

                    else begin
                        MISO <= 0;
                        if(count_s_to_p == 10) begin
                            rx_valid <= 1;
                            count_s_to_p <= 1;
                            count_p_to_s <= 1;
                        end
                        else if (count_s_to_p != 10) begin
                            rx_valid <= 0;
                        end 
                        if (count_s_to_p < 11) begin
                            rx_data[10-count_s_to_p] <= MOSI;
                            count_s_to_p <= count_s_to_p + 1;
                            count_p_to_s <= 1;
                        end
                    end
                    address_recived <= 0;
                end
                default: begin
                    count_s_to_p <= 1;
                    count_p_to_s <= 1;
                    rx_valid <= 0;
                    MISO <= 0;
                end
            endcase
        end
    end
endmodule