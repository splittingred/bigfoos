Fabricator(:player) do
  user
  team
  points  Random.rand(0..5)
end
