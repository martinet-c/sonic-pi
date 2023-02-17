use_bpm 100

in_thread do
  use_synth :bass_foundation
  i = 0
  loop do
    (i==0 ? 17 : 24).times do
      play :G3, amp: 0.1
      sleep 0.5
      play :G4, amp: 0.1
      sleep 0.25
      play :G4, amp: 0.1
      sleep 0.25
    end
    8.times do
      play :A3, amp: 0.1
      sleep 0.5
      play :A4, amp: 0.1
      sleep 0.25
      play :A4, amp: 0.1
      sleep 0.25
    end
    i = i+1
  end
end

in_thread do
  notes = [[:B4, :G5, :D5,  :B4, :C5], [:B4, :G5,  :D5, :B4, :C5], [:B4, :G5, :D5, :B4, :C5], [:B4, :G5, :D5, :B4, :C5],
           [:C5, :A5, :Gb5, :C5, :D5], [:A4, :Gb5, :A4, :B4, :C5], [:B4, :G5, :D5, :B4, :C5], [:B4, :G5, :D5, :B4, :C5]]
  use_synth :kalimba
  i = 0
  sleep 1
  loop do
    inotes = notes[i]
    play inotes[0], amp: 2
    sleep 1
    play inotes[0], amp: 2
    sleep 1
    play inotes[0], amp: 2
    sleep 0.25
    play inotes[1], amp: 2
    sleep 0.5
    play inotes[2], amp: 2
    sleep 0.25
    play inotes[3], amp: 2
    sleep 0.5
    play inotes[4], amp: 2
    sleep 0.5
    i = (i<7 ? i+1 : 0)
  end
end

notes = [[:B4, :C5, :D5, :C5, :B4], [:B4, :C5, :D5, :E5, :B4], [:B4, :C5, :D5, :C5, :D5], [:B4, :C5, :A4, :G4, :G4]]
use_synth :hollow
i = 0
loop do
  inotes = notes[i]
  play inotes[0], release: 2
  sleep 1
  play inotes[1], release: 4
  sleep 4
  play inotes[2], release: 3
  sleep 3
  play inotes[3], release: 2
  sleep 1
  play inotes[4], release: 2
  sleep 7
  i = (i<3 ? i+1 : 0)
end