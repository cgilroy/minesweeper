
class Tile
    attr_reader :bombed, :revealed, :flagged
    def initialize
        @bombed = false
        @revealed = false
        @flagged = false
    end

    def bombed?
        @bombed
    end

    def bomb
        @bombed = true
    end

end
