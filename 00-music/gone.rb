use_bpm 120
use_synth :piano

notes = [:C5, :D5, :E5, 0.5, :F5, :E5, :D5, :C5, 0.5, :D5, :C5, :B4, :A4, 0.5, :B4, :A4, :B4, :C5, 1,
         :B4, :C5, :D5, 0.5, :E5, :D5, :C5, :B4, 0.5, :C5, :B4, :A4, :G4, 0.5, :F5, 0, :E5, 0.5]
i = 0
loop do
  if notes[i].to_f == notes[i]
    sleep notes[i]
  else
    play notes[i]
  end
  sleep 0.5
  i = i<notes.size ? i+1 : 0
end
