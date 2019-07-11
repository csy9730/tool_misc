################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
device_support/F2837xD_common/driverlib/interrupt.obj: E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib/interrupt.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="E:/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="E:/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="E:/SVN/gs/workspace/public" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="device_support/F2837xD_common/driverlib/interrupt.d" --obj_directory="device_support/F2837xD_common/driverlib" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

device_support/F2837xD_common/driverlib/uart.obj: E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib/uart.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="E:/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="E:/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="E:/SVN/gs/workspace/public" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="device_support/F2837xD_common/driverlib/uart.d" --obj_directory="device_support/F2837xD_common/driverlib" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


