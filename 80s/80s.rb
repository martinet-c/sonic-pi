# change cut number to choose where to start
# 1 cut = 16 beats (most of the time, there are exceptions)
# threads using cut should loop every 2, 4, 8 or 16 beats for the sync to work
set :cut, 0

set :bpc, [36, 16, 16, 16] # bpc = beats per cut

set :bpm, 120

use_bpm get[:bpm]

run_file '~/sonic-pi/80s/beat.rb'
run_file '~/sonic-pi/80s/intro.rb'

sleep 1 # let time for the run_files to start

in_thread do
  
  Thread.current[:sleep_count] = 0
  
  define :sleep_and_count do |beats|
    Thread.current[:sleep_count] += beats
    sleep beats
  end
  
  define :check_sleep_count do |thread, cut|
    if Thread.current[:sleep_count] == get[:bpc][cut]
      Thread.current[:sleep_count] = 0
    else
      abort("Sleep count check failed for thread #{thread} / cut #{cut}: #{Thread.current[:sleep_count]} counted, #{get[:bpc][cut]} expected")
    end
  end
  
  cue :beat
  
  use_synth :prophet
  
  (get[:bpc].length()-get[:cut]).times do
    
    Thread.current[:local_cut] = get[:cut]
    
    in_thread do
      sleep 1 # let time for all threads (run_file) to start a loop and evaluate cut if they need to
      set :cut, get[:cut]+1
    end
    
    case
    when Thread.current[:local_cut]<1
      cue :intro
      sleep_and_count get[:bpc][Thread.current[:local_cut]]
      
    else
      2.times do |i|
        play :D4, release: 2
        sleep_and_count 0.5
        play :D4, release: 2, amp: 1.5
        sleep_and_count 0.5
        play :B3, release: 2
        sleep_and_count 0.5
        play :Db4, release: 1
        sleep_and_count 0.25
        play :D4, release: 2
        sleep_and_count 0.5
        play :E4, release: 2
        if i % 2 == 0
          sleep_and_count 1.750
        else
          sleep_and_count 0.750
        end
      end
      
      play :Gb4, release: 2
      sleep_and_count 0.5
      play :D4, release: 2, amp: 1.5
      sleep_and_count 1
      play :Db4, release: 2, amp: 1.5
      sleep_and_count 0.5
      play :B3, release: 4, amp: 1.5
      sleep_and_count 7
    end
    
    check_sleep_count 'main', Thread.current[:local_cut]
    
  end
  
end