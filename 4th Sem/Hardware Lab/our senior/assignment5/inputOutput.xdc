set_property IOSTANDARD LVCMOS33 [get_ports {in[3]}]

 set_property IOSTANDARD LVCMOS33 [get_ports {in[2]}]

 set_property IOSTANDARD LVCMOS33 [get_ports {in[1]}]

 set_property IOSTANDARD LVCMOS33 [get_ports {in[0]}]

 set_property IOSTANDARD LVCMOS33 [get_ports {s1}]

 set_property IOSTANDARD LVCMOS33 [get_ports {s2}]

 set_property IOSTANDARD LVCMOS33 [get_ports {s3}]

 set_property IOSTANDARD LVCMOS33 [get_ports {s4}]
 set_property IOSTANDARD LVCMOS33 [get_ports ready]
 set_property IOSTANDARD LVCMOS33 [get_ports valid]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[14]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[13]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[12]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[11]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[10]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[9]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[8]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[7]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[6]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[5]]
set_property IOSTANDARD LVCMOS33 [get_ports outta[4]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[3]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[2]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[1]]
 set_property IOSTANDARD LVCMOS33 [get_ports outta[0]]




 set_property PACKAGE_PIN V10 [get_ports {in[3]}]

 set_property PACKAGE_PIN U11 [get_ports {in[2]}]

 set_property PACKAGE_PIN U12 [get_ports {in[1]}]

 set_property PACKAGE_PIN H6 [get_ports {in[0]}]
 
  set_property PACKAGE_PIN T13 [get_ports {s1}]

 set_property PACKAGE_PIN R16 [get_ports {s2}]

 set_property PACKAGE_PIN U8 [get_ports {s3}]

 set_property PACKAGE_PIN T8 [get_ports {s4}]

 set_property PACKAGE_PIN R13 [get_ports ready]
set_property PACKAGE_PIN V11 [get_ports valid]
 set_property PACKAGE_PIN V12 [get_ports outta[14]]
 set_property PACKAGE_PIN V14 [get_ports outta[13]]
 set_property PACKAGE_PIN V15 [get_ports outta[12]]
 set_property PACKAGE_PIN T16 [get_ports outta[11]]
 set_property PACKAGE_PIN U14 [get_ports outta[10]]
 set_property PACKAGE_PIN T15 [get_ports outta[9]]
 set_property PACKAGE_PIN V16 [get_ports outta[8]]
 set_property PACKAGE_PIN U16 [get_ports outta[7]]
 set_property PACKAGE_PIN U17 [get_ports outta[6]]
 set_property PACKAGE_PIN V17 [get_ports outta[5]]
set_property PACKAGE_PIN R18 [get_ports outta[4]]
 set_property PACKAGE_PIN N14 [get_ports outta[3]]
 set_property PACKAGE_PIN J13 [get_ports outta[2]]
 set_property PACKAGE_PIN K15 [get_ports outta[1]]
 set_property PACKAGE_PIN H17 [get_ports outta[0]]

set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clock }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clock}];