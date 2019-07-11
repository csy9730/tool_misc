################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
source/Calibration.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/Calibration.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/Calibration.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/CmdDispose.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/CmdDispose.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/CmdDispose.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/Debug.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/Debug.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/Debug.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/ParamManager.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/ParamManager.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/ParamManager.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/PowerAnalyserInv.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/PowerAnalyserInv.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/PowerAnalyserInv.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/PwmGenerator.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/PwmGenerator.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/PwmGenerator.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateDriverTest.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateDriverTest.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateDriverTest.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateInit.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateInit.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateInit.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateMainPhaseSync.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateMainPhaseSync.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateMainPhaseSync.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateOutputGradient.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateOutputGradient.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateOutputGradient.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateOutputNormal.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateOutputNormal.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateOutputNormal.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateSoftStart.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateSoftStart.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateSoftStart.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateStop.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateStop.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateStop.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateSubPhaseSync.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateSubPhaseSync.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateSubPhaseSync.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateWaitBus.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateWaitBus.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateWaitBus.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateWaitMainSync.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateWaitMainSync.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateWaitMainSync.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/StateWaitOutput.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/StateWaitOutput.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/StateWaitOutput.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/SysMonitor.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/SysMonitor.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/SysMonitor.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/app.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/app.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/app.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/auxiliary.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/auxiliary.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/auxiliary.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/constvar.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/constvar.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/constvar.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/sml.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/sml.cpp $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/sml.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/startup.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/startup.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/startup.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/version.obj: D:/code/SVN/gs/workspace/source/ginv_cpu1/version.asm $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C2000 Compiler'
	"D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 -O4 --opt_for_speed=5 --fp_mode=relaxed --include_path="D:/code/SVN/gs/workspace/projcet/ginv_cpu1" --include_path="D:/code/SVN/gs/workspace/source/ginv_cpu1/algorithm" --include_path="D:/greenSoftware/CCS7.1.0.00016/ccsv7/tools/compiler/ti-cgt-c2000_16.9.1.LTS/include" --include_path="D:/code/SVN/gs/workspace/public" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_headers/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/include/FlashAPI" --include_path="D:/code/SVN/gs/workspace/device_support/F2837xD_common/driverlib" --advice:performance=all --define=CPU1 --define=_FLASH --define=_STANDALONE -g --c99 --diag_warning=225 --diag_wrap=off --display_error_number --emit_warnings_as_errors --preproc_with_compile --preproc_dependency="source/version.d" --obj_directory="source" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


