i = 0

define :increment_i_and_print do |flag|
  i += 1
  print "#{flag}: i == #{i}"
end

Thread.current[:local_i] = 0

define :increment_local_i_and_print do |flag|
  Thread.current[:local_i] += 1
  print "#{flag}: Thread.current[:local_i] == #{Thread.current[:local_i]}"
end

# Thread.current[:local_i2] will be initialized later (line 69)

define :increment_local_i2_and_print do |flag|
  Thread.current[:local_i2] += 1
  print "#{flag}: Thread.current[:local_i2] == #{Thread.current[:local_i2]}"
end

run_file '~/sonic-pi/thread-test/file1.rb'
run_file '~/sonic-pi/thread-test/file2.rb'

in_thread do
  
  j = 0
  
  define :increment_j_and_print do |flag|
    j += 1
    print "#{flag}: j == #{j}"
  end
  
  Thread.current[:local_j] = 0
  
  define :increment_local_j_and_print do |flag|
    Thread.current[:local_j] += 1
    print "#{flag}: Thread.current[:local_j] == #{Thread.current[:local_j]}"
  end
  
  sleep 4
  increment_i_and_print 'flag4'
  increment_j_and_print 'flag4'
  increment_k_and_print 'flag4'
  
  # no init for Thread.current[:local_i]
  increment_local_i_and_print 'flag4'
  
  Thread.current[:local_i2] = 0
  increment_local_i2_and_print 'flag4'
  
  # Thread.current[:local_j] already initialized (line 34)
  increment_local_j_and_print 'flag4'
  
  Thread.current[:local_k] = 0
  increment_local_k_and_print 'flag4'
end

sleep 1
increment_i_and_print 'flag1'
increment_j_and_print 'flag1'
print "flag 1 special: j == #{j}"
increment_k_and_print 'flag1'
print "flag 1 special: k == #{k}" # this line will generate an error, comment it and try again

# Thread.current[:local_i] already initialized (line 8)
increment_local_i_and_print 'flag1'

Thread.current[:local_i2] = 0
increment_local_i2_and_print 'flag1'

Thread.current[:local_j] = 0
increment_local_j_and_print 'flag1'

Thread.current[:local_k] = 0
increment_local_k_and_print 'flag1'
