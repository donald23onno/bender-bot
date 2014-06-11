# Description:
#   Reads info from RDW for license plate info
#
# Commands:
#   hubot kenten <query> - Searches RDW oData for kentenen info

module.exports = (robot) ->
  robot.respond /(kenteken|ktk) (.*)/i, (msg) ->
    query = msg.match[2]
    stripped = query.replace(/-/g, "")
    msg.http("https://api.datamarket.azure.com/opendata.rdw/VRTG.Open.Data/v1/KENT_VRTG_O_DAT?$format=json&$filter=Kenteken%20eq%20%27#{stripped}%27")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
#SEND VARIOUS INFO:
          msg.send "Merk/type: #{json.d.results[0].Handelsbenaming}"
          msg.send "Catalogusprijs: #{json.d.results[0].Catalogusprijs}"
          msg.send "Kleur: #{json.d.results[0].Eerstekleur}"
        catch error
          msg.send "ERROR"

#    unless results?
#      msg.send "No  results for \"#{query}\""
#      return

