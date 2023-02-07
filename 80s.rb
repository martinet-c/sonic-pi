use_bpm 120

in_thread do
  sleep 0.5
  loop do
    sample :drum_heavy_kick
    sleep 1
  end
end

in_thread do
  use_synth :blade
  loop do
    play :B3, release: 0.5
    sleep 0.25
    play :B3, release: 0.5
    sleep 0.5
    
    play :B3, release: 0.5
    sleep 0.25
    play :B3, release: 0.5
    sleep 0.5
    
    play :B3, release: 0.5
    sleep 0.5
    play :B1, release: 0.5
    sleep 0.5
    
    play :B4, release: 0.5
    sleep 0.25
    play :B4, release: 0.5
    sleep 0.75
    
    sleep 0.5
  end
end

use_synth :prophet
loop do
  
  2.times do |count|
    play :D4, release: 2
    sleep 0.5
    play :D4, release: 2
    sleep 0.5
    play :B3, release: 2
    sleep 0.5
    play :Db4, release: 1
    sleep 0.25
    play :D4, release: 2
    sleep 0.5
    play :E4, release: 2
    if count % 2 == 0
      sleep 1.750
    else
      sleep 0.750
    end
  end
  
  play :Gb4, release: 2
  sleep 0.5
  play :D4, release: 2
  sleep 1
  play :Db4, release: 2
  sleep 0.5
  play :B3, release: 4
  sleep 7
  
end