use_bpm 140
use_synth :piano
set :variation, 0

in_thread do
  i = 0
  sleep 0.5 # just to be sure that the other threads have time to start
  loop do
    if i>0 && i%4==0
      set :variation, [0, 1, get[:variation]].choose
    end
    cue :go
    4.times do
      2.times do |j|
        notes = [(ring :G5, :Gs5, :G5, :F5), (ring :B5, :C6, :B5, :A5)][get[:variation]]
        play notes[i], release: 0.5, amp: j==0 ? 0.6 : 0.4
        sleep 0.25
      end
      sleep 0.25
    end
    i += 1
  end
end

in_thread do
  i = 0
  loop do
    sync :go
    play [(ring :G4, :Gs4, :G4, :F4), (ring :B4, :C5, :B4, :A4)][get[:variation]][i]
    2.times do
      play [:C4, :E4][get[:variation]]
      play [:D4, :Fs4][get[:variation]]
      sleep 0.5
    end
    sleep 1
    if i%3 == 0
      play [:Ds4, :G4][get[:variation]]
    else
      play [[(ring :F4, :G4, :F4, :Ds4)[i], :Gs4].choose, [(ring :A4, :B4, :A4, :G4)[i], :C5].choose][get[:variation]]
    end
    sleep 0.5
    play [(ring :G4, :F4, :Ds4, :D4), (ring :B4, :A4, :G4, :Fs4)][get[:variation]][i]
    i += 1
  end
end

in_thread do
  i = 0
  loop do
    sync :go
    3.times do |j|
      play [(ring :C3, :C3, :C3, [:C3, :Bb3].choose), (ring :E3, :E3, :E3, [:E3, :D3].choose)][get[:variation]][i]
      sleep 0.5
      play [(ring :G3, :Gs3, :G3, :F3), (ring :B3, :C4, :B3, :A3)][get[:variation]][i]
      sleep j<2 ? 0.5 : 0
    end
    i += 1
  end
end
