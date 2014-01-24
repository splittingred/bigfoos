Fabricator(:achievement) do
  name        'Winnar'
  code        'wins-5'
  description 'Get 5 wins'
  prior       0
  stat        'wins'
  operator    '>='
  value       5
end
