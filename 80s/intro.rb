use_bpm get[:bpm]

Thread.current[:sleep_count] = 0
Thread.current[:local_cut] = get[:cut]

sync :intro

sleep_and_count 16

use_synth :fm

2.times do |i|
  play :D4, release: 2
  sleep_and_count 0.5
  play :D4, release: 1
  sleep_and_count 0.25
  play :B3, release: 2
  sleep_and_count 0.5
  play :Db4, release: 2
  sleep_and_count 2.75
  
  play :D4, release: 2, amp: i+1
  sleep_and_count 0.5
  play :D4, release: 1, amp: i+1
  sleep_and_count 0.25
  play :B3, release: 2, amp: i+1
  sleep_and_count 0.5
  if i==0
    play :Db4, release: 2
    sleep_and_count 0.5
    play :D4, release: 2
    sleep_and_count 0.5
    play :E4, release: 2
    sleep_and_count 1.75
  else
    play :B3, release: 4, amp: i+1
    sleep_and_count 2.75
  end
end

sleep_and_count 4

check_sleep_count 'intro', Thread.current[:local_cut]
