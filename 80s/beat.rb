use_bpm get[:bpm]

sync :go

in_thread do
  sleep 0.5
  loop do
    sample :drum_heavy_kick
    sleep 1
  end
end

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
