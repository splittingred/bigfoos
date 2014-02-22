module GamesHelper

  def score_link(game, player, scored_with)
    link_to 'Score', game_score_path(game,{:player_id => player.id, :scored_with => scored_with }), class: 'man', :remote => true, :method => :post
  end
end
