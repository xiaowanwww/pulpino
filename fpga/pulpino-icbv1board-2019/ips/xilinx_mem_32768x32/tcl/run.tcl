
if { ![info exists ::env(XILINX_PART)] } {
  set ::env(XILINX_PART) "xc7z020clg484-1"
}



set partNumber $::env(XILINX_PART)


create_project -force xilinx_mem_32768x32 . -part $partNumber

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name xilinx_mem_32768x32
set_property -dict [list CONFIG.Memory_Type {Single_Port_RAM} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Write_Width_A {32} CONFIG.Write_Depth_A {32768} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Use_RSTA_Pin {true}] [get_ips xilinx_mem_32768x32]
generate_target all [get_files ./xilinx_mem_32768x32.srcs/sources_1/ip/xilinx_mem_32768x32/xilinx_mem_32768x32.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./xilinx_mem_32768x32.srcs/sources_1/ip/xilinx_mem_32768x32/xilinx_mem_32768x32.xci]
launch_run -jobs 8 xilinx_mem_32768x32_synth_1
wait_on_run xilinx_mem_32768x32_synth_1