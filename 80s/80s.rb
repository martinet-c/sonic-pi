# change cpt to choose where to start
# 1 cpt = 16 beats; threads using cpt should last 2, 4, 8 or 16 beats for the sync to work
set :cpt, 0

set :bpm, 120

use_bpm get[:bpm]

run_file '~/sonic-pi/80s/beat.rb'
run_file '~/sonic-pi/80s/bass.rb'

sleep 1 # let time for the run_files to start

cue :go

use_synth :prophet

loop do
  
  in_thread do
    sleep 1 # let time for all threads to start a loop and evaluate cpt
    set :cpt, get[:cpt]+1
  end
  
  case
  when get[:cpt] < 2
    sleep 16
    
  else
    2.times do |i|
      play :D4, release: 2
      sleep 0.5
      play :D4, release: 2, amp: 1.5
      sleep 0.5
      play :B3, release: 2
      sleep 0.5
      play :Db4, release: 1
      sleep 0.25
      play :D4, release: 2
      sleep 0.5
      play :E4, release: 2
      if i % 2 == 0
        sleep 1.750
      else
        sleep 0.750
      end
    end
    
    play :Gb4, release: 2
    sleep 0.5
    play :D4, release: 2, amp: 1.5
    sleep 1
    play :Db4, release: 2, amp: 1.5
    sleep 0.5
    play :B3, release: 4, amp: 1.5
    sleep 7
  end
  
end