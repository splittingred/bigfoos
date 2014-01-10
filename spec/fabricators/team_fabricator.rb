Fabricator(:team) do
  game
  color       %w(Black Yellow).sample
  num_players 2
end
