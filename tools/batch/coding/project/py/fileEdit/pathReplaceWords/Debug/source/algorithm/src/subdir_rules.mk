################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
source/algorithm/src/CNTL_2P2Z_F.obj: E:/SVN/gs/workspace/source/ginv_cpu1/algorithm/src/CNTL_2P2Z_F.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="E:/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="E:/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="E:/SVN/gs/workspace/public" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/algorithm/src/CNTL_2P2Z_F.d" --obj_directory="source/algorithm/src" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/algorithm/src/CNTL_3P3Z_F.obj: E:/SVN/gs/workspace/source/ginv_cpu1/algorithm/src/CNTL_3P3Z_F.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="E:/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="E:/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="E:/SVN/gs/workspace/public" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/algorithm/src/CNTL_3P3Z_F.d" --obj_directory="source/algorithm/src" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/algorithm/src/invertor.obj: E:/SVN/gs/workspace/source/ginv_cpu1/algorithm/src/invertor.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="E:/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="E:/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="E:/SVN/gs/workspace/public" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/algorithm/src/invertor.d" --obj_directory="source/algorithm/src" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/algorithm/src/zalPfcLinePhase.obj: E:/SVN/gs/workspace/source/ginv_cpu1/algorithm/src/zalPfcLinePhase.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="E:/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="E:/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="E:/SVN/gs/workspace/public" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/algorithm/src/zalPfcLinePhase.d" --obj_directory="source/algorithm/src" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/algorithm/src/zal_invertor_init.obj: E:/SVN/gs/workspace/source/ginv_cpu1/algorithm/src/zal_invertor_init.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="E:/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="E:/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="E:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="E:/SVN/gs/workspace/public" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="E:/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/algorithm/src/zal_invertor_init.d" --obj_directory="source/algorithm/src" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


