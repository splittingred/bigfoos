Fabricator(:player) do
  user
  game
  team
  points  Random.rand(0..5)
end
