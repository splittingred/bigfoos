# ------ WINS -------------------------------------
Achievement.seed(:code) do |ach|
  ach.id = 1
  ach.name = 'Winnar!'
  ach.code = 'wins-1'
  ach.description = 'Got your first win!'
  ach.prior = 0
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 2
  ach.name = 'Doin Good'
  ach.code = 'wins-5'
  ach.description = 'Got 5 wins'
  ach.prior = 1
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 3
  ach.name = 'Solid Performer'
  ach.code = 'wins-10'
  ach.description = 'Got 10 wins'
  ach.prior = 2
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 10
end

Achievement.seed(:code) do |ach|
  ach.id = 4
  ach.name = 'Crack-a-lackin'
  ach.code = 'wins-25'
  ach.description = 'Got 25 wins'
  ach.prior = 3
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 5
  ach.name = 'Valuable Player'
  ach.code = 'wins-50'
  ach.description = 'Got 50 wins'
  ach.prior = 4
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 6
  ach.name = 'Game Changer'
  ach.code = 'wins-100'
  ach.description = 'Got 100 wins'
  ach.prior = 5
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 100
end

# ------ LOSSES -------------------------------------

Achievement.seed(:code) do |ach|
  ach.id = 7
  ach.name = 'Try, Try Again'
  ach.code = 'losses-1'
  ach.description = 'Got your first loss'
  ach.prior = 0
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 8
  ach.name = 'Stop Spinning'
  ach.code = 'losses-5'
  ach.description = 'Got 5 losses'
  ach.prior = 7
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 9
  ach.name = 'Getting better...?'
  ach.code = 'losses-10'
  ach.description = 'Got 10 losses'
  ach.prior = 8
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 10
end

Achievement.seed(:code) do |ach|
  ach.id = 10
  ach.name = 'Time to Play on the Kiddo Table'
  ach.code = 'losses-25'
  ach.description = 'Got 25 losses'
  ach.prior = 9
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 11
  ach.name = 'Maybe This Just Isnt For You'
  ach.code = 'losses-50'
  ach.description = 'Got 50 losses'
  ach.prior = 10
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 12
  ach.name = 'Can He Play on Your Team?'
  ach.code = 'losses-100'
  ach.description = 'Got 100 losses'
  ach.prior = 11
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 100
end

# ------ GAMES -------------------------------------

Achievement.seed(:code) do |ach|
  ach.id = 13
  ach.name = 'Newbie'
  ach.code = 'games-1'
  ach.description = 'Played first game'
  ach.prior = 0
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 14
  ach.name = 'Getting the Hang of It'
  ach.code = 'games-5'
  ach.description = 'Played 5 games'
  ach.prior = 13
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 15
  ach.name = 'I Know the 2 Colors'
  ach.code = 'games-10'
  ach.description = 'Played 10 games'
  ach.prior = 14
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 10
end

Achievement.seed(:code) do |ach|
  ach.id = 16
  ach.name = 'Push and Pull Mean Something Now'
  ach.code = 'games-25'
  ach.description = 'Played 25 games'
  ach.prior = 15
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 17
  ach.name = 'I Can Pass!'
  ach.code = 'games-50'
  ach.description = 'Played 50 games'
  ach.prior = 16
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 18
  ach.name = 'I Like Foosball'
  ach.code = 'games-100'
  ach.description = 'Played 100 games'
  ach.prior = 17
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 100
end

Achievement.seed(:code) do |ach|
  ach.id = 19
  ach.name = 'I Get Work Done, Sometimes'
  ach.code = 'games-250'
  ach.description = 'Played 250 games'
  ach.prior = 18
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 250
end

Achievement.seed(:code) do |ach|
  ach.id = 20
  ach.name = 'I Stay After Work to Practice'
  ach.code = 'games-500'
  ach.description = 'Played 500 games'
  ach.prior = 19
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 500
end

Achievement.seed(:code) do |ach|
  ach.id = 21
  ach.name = 'I Dream of Foos'
  ach.code = 'games-1000'
  ach.description = 'Played 1,000 games'
  ach.prior = 20
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 1000
end

# ------ GAMES -------------------------------------

Achievement.seed(:code) do |ach|
  ach.id = 22
  ach.name = 'I Found It!'
  ach.code = 'scores-1'
  ach.description = 'Got your first point!'
  ach.prior = 0
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 23
  ach.name = 'Kick It In'
  ach.code = 'scores-5'
  ach.description = 'Got 5 points'
  ach.prior = 22
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 24
  ach.name = 'Tappy Tap'
  ach.code = 'scores-25'
  ach.description = 'Score 25 points total'
  ach.prior = 23
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 25
  ach.name = 'Line It Up'
  ach.code = 'scores-50'
  ach.description = 'Got 50 points'
  ach.prior = 24
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 26
  ach.name = 'Scoremeister'
  ach.code = 'scores-100'
  ach.description = 'Got 100 points'
  ach.prior = 25
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 100
end

Achievement.seed(:code) do |ach|
  ach.id = 27
  ach.name = 'Dangerous'
  ach.code = 'scores-250'
  ach.description = 'Got 250 points'
  ach.prior = 26
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 250
end

Achievement.seed(:code) do |ach|
  ach.id = 28
  ach.name = 'GOOAALLLLLL'
  ach.code = 'scores-500'
  ach.description = 'Got 500 points'
  ach.prior = 27
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 500
end

Achievement.seed(:code) do |ach|
  ach.id = 29
  ach.name = 'Pele'
  ach.code = 'scores-1000'
  ach.description = 'Got 1,000 points'
  ach.prior = 28
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 1000
end