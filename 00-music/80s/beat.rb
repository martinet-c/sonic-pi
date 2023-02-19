use_bpm get[:bpm]
beats_sum = get[:bpc][get[:cut]..get[:bpc].length-1].sum

sync :beat

in_thread do
  sleep 0.5
  (beats_sum).times do
    sample :drum_heavy_kick
    sleep 1
  end
end

use_synth :blade
(beats_sum/4).times do
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
