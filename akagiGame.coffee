gamePieces = require('./akagiTiles.coffee')
player = require('./akagiPlayer.coffee')

class MahjongGame
  #A four player game of Mahjong
  constructor: (playerChannels, server, gameSettings) ->
    @wall = new gamePieces.Wall()
    @players = [
      new player(playerChannels[1]),
      new player(playerChannels[2]),
      new player(playerChannels[3]),
      new player(playerChannels[4])
    ]
    @gameObservationChannel = playerChannels[0]
    @startRoundOne()

  startRoundOne: ->
    #TODO: Randomize starting locations later
    @eastPlayer = @players[0]
    @southPlayer = @players[1]
    @westPlayer = @players[2]
    @northPlayer = @players[3]
    @startRound("East",@eastPlayer)

  startRound:(prevailingWind,dealer) ->
    @prevailingWind = prevailingWind
    @dealer = dealer
    @turn = 1
    @phase = 'draw'
    @wall.doraFlip()
    for player in @players
      player.hand.startDraw(@wall)
      player.roundStart()
      player.sendMessage("Prevailing wind is #{@prevailingWind}.")
      player.sendMessage("Dora is #{@wall.printDora()}.")

module.exports = MahjongGame