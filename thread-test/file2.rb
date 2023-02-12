sleep 3

increment_i_and_print 'flag3'
increment_j_and_print 'flag3'
increment_k_and_print 'flag3'

# no init for Thread.current[:local_i]
increment_local_i_and_print 'flag3'

Thread.current[:local_i2] = 0
increment_local_i2_and_print 'flag3'

Thread.current[:local_j] = 0
increment_local_j_and_print 'flag3'

Thread.current[:local_k] = 0
increment_local_k_and_print 'flag3'
