# 
# Synthesis run script generated by Vivado
# 

  set_param gui.test TreeTableDev
create_project -in_memory -part xc7k70tfbg676-1
set_param project.compositeFile.enableAutoGeneration 0
set_property constrs_type UCF [current_fileset -constrset]
read_vhdl C:/sw_repo/Soft/WIP/STMTest.vhd
set_property webtalk.parent_dir C:/sw_repo/Soft/WIP/project_2/project_2.data/wt [current_project]
set_property parent.project_dir C:/sw_repo/Soft/WIP/project_2 [current_project]
synth_design -top STM_SWD -part xc7k70tfbg676-1
write_checkpoint STM_SWD.dcp
report_utilization -file STM_SWD_utilization_synth.rpt -pb STM_SWD_utilization_synth.pb
