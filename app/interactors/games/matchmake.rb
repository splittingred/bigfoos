module Games
  class Matchmake
    include Interactor

    before do
      if context.user_ids.present?
        context.user_ids.reject!(&:empty?)
        context.users = User.of_ids(context.user_ids).order(score: :desc)
      end
      # get and sort users by rank
      @users = context.users

      context.fail!(error: 'Not enough players selected.') if @users.count != 4

      @random_teams = context.random_teams.present?
      @colors = %w(Yellow Black).shuffle
      @player_order = [1,4,2,3]
      @player_order.shuffle! if @random_teams
    end

    def call
      @game = Game.new(num_players: 4, teams: [])

      @colors.each do |color|
        team = Team.new(color: color, num_players: 2)
        positions = %w(front back).shuffle

        2.times do
          player = Player.new
          # 1/4/2/3 selection of teams, unless random_teams is true
          if @random_teams
            player.user = @users.at(@player_order.shift.to_i-1)
          else
            player.user = @users.sample
          end

          # select position based on player's history, putting them in least played position if one of the top 2 players
          if positions.count > 1
            position = positions.delete(player.least_played_position.to_s)
          else
            position = positions.pop
          end
          player.position = position

          team.players << player
        end
        @game.teams << team
      end

      @game.save!

      context.game = @game

    rescue => e
      context.fail!(error: e.message)
    end
  end
end
