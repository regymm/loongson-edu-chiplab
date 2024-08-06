#性能测试
file copy -force ../../software/perf/obj/bitcount/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/bubble_sort/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/coremark/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/crc32/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/dhrystone/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/quick_sort/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/select_sort/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/sha/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/stream_copy/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all


file copy -force ../../software/perf/obj/stringsearch/inst_data.bin ./loongson.sim/sim_1/behav/xsim/inst_data.bin
restart
run all

