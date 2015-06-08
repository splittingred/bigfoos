module Teams
  class Win
    include Interactor::Organizer

    organize Teams::Winning::SetStatus,
             Teams::Winning::UpdatePlayers

    def foo
      self.won = true
      if self.save
        self.players.each do |p|
          p.win
        end
      end
    end
  end
end
