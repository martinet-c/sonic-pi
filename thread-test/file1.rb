k = 0

define :increment_k_and_print do |flag|
  k += 1
  print "#{flag}: k == #{k}"
end

Thread.current[:local_k] = 0

define :increment_local_k_and_print do |flag|
  Thread.current[:local_k] += 1
  print "#{flag}: Thread.current[:local_k] == #{Thread.current[:local_k]}"
end

sleep 2

increment_i_and_print 'flag2'
increment_j_and_print 'flag2'
increment_k_and_print 'flag2'

# no init for Thread.current[:local_i]
increment_local_i_and_print 'flag2'

Thread.current[:local_i2] = 0
increment_local_i2_and_print 'flag2'

Thread.current[:local_j] = 0
increment_local_j_and_print 'flag2'

Thread.current[:local_k] = 0
increment_local_k_and_print 'flag2'
