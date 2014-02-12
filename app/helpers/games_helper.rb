module GamesHelper

  def man_link index
    link_to index.to_s, game_path, class: 'man'
  end
end
