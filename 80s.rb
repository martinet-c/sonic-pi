use_bpm 60

in_thread do
  sleep 0.25
  loop do
    sample :drum_heavy_kick
    sleep 0.5
  end
end

in_thread do
  use_synth :blade
  loop do
    play :B3, release: 0.25
    sleep 0.125
    play :B3, release: 0.25
    sleep 0.25
    
    play :B3, release: 0.25
    sleep 0.125
    play :B3, release: 0.25
    sleep 0.25
    
    play :B3, release: 0.25
    sleep 0.25
    play :B1, release: 0.25
    sleep 0.25
    
    play :B4, release: 0.25
    sleep 0.125
    play :B4, release: 0.25
    sleep 0.375
    
    sleep 0.25
  end
end

use_synth :prophet
loop do
  
  2.times do |count|
    play :D4
    sleep 0.25
    play :D4
    sleep 0.25
    play :B3
    sleep 0.25
    play :Db4, release: 0.5
    sleep 0.125
    play :D4
    sleep 0.25
    play :E4
    if count % 2 == 0
      sleep 0.875
    else
      sleep 0.375
    end
  end
  
  play :Gb4
  sleep 0.25
  play :D4
  sleep 0.5
  play :Db4
  sleep 0.25
  play :B3, release: 2
  sleep 3.5
  
end