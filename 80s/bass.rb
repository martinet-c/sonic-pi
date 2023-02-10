use_bpm get[:bpm]

sync :go

use_synth :fm

loop do
  
  case get[:cpt]
  
  when 0
    sleep 12
    play :D4, release: 2
    sleep 0.5
    play :D4, release: 1
    sleep 0.25
    play :B3, release: 2
    sleep 0.5
    play :Db4, release: 2
    sleep 2.75
    
  when 1
    2.times do |i|
      if i==1
        play :D4, release: 2
        sleep 0.5
        play :D4, release: 1
        sleep 0.25
        play :B3, release: 2
        sleep 0.5
        play :Db4, release: 2
        sleep 2.75
      end
      play :D4, release: 2, amp: i+1
      sleep 0.5
      play :D4, release: 1, amp: i+1
      sleep 0.25
      play :B3, release: 2, amp: i+1
      sleep 0.5
      if i==0
        play :Db4, release: 2
        sleep 0.5
        play :D4, release: 2
        sleep 0.5
        play :E4, release: 2
        sleep 1.75
      else
        play :B3, release: 4, amp: i+1
        sleep 2.75
      end
    end
    
  else
    sleep 16
    
  end
  
end