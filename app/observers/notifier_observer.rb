class NotifierObserver

  def initialize
    @slack = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: '#bigfoos', username: 'BigFoos')
  end

  def game_finished(opts = {})
    return unless ENV['SLACK_ENABLED'].present? && ENV['SLACK_ENABLED'].to_i == 1

    return unless opts[:game]
    game = opts.fetch(:game)

    winning_team = game.winning_team
    losing_team = game.losing_team
    winners = winning_team.players.collect { |p| p.user.name }
    losers = losing_team.players.collect { |p| p.user.name }

    @slack.ping "Game #{game.id} Finished:
#{winners.join(', ')}: *#{winning_team.score.to_s}*
#{losers.join(', ')}: *#{losing_team.score.to_s}*
[View Game](http://bigfoos.herokuapp.com/games/#{game.id.to_s})"

  rescue StandardError => e
    Rails.logger.error "Failed to notify slack of game: #{e.message}"
  end
end
