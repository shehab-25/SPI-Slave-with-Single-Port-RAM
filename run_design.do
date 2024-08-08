vlib work
vlog SPI_Slave.v RAM.v SPI_Wrapper.v SPI_Wrapper_tb.v
vsim -voptargs=+acc work.SPI_Wrapper_tb
add wave *
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/tx_valid
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/tx_data
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/rx_valid
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/rx_data
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/SPI/cs
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/SPI/count_s_to_p
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/SPI/count_p_to_s
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/SPI/address_recived
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/ram/dout
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/ram/din
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/ram/data
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/ram/wr_addr
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/ram/rd_addr
add wave /SPI_Wrapper_tb/SPI_Wrapper_DUT/ram/mem
run -all
#quit -sim