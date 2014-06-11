# Description:
#   Reads info from RDW for license plate info
#
# Commands:
#   hubot kenten <query> - Searches RDW oData for kentenen info

module.exports = (robot) ->
  robot.respond /(kenteken|ktk) (.*)/i, (msg) ->
    query = msg.match[2]
    stripped = query.replace(/-/g, "")
    msg.send "stripped: #{stripped}"
    msg.http("https://api.datamarket.azure.com/opendata.rdw/VRTG.Open.Data/v1/KENT_VRTG_O_DAT?$format=json&$filter=Kenteken%20eq%20%27#{stripped}%27")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          msg.send "#{json.d.results[0].Merk}"
#          for k,v of json.d.results[0]
#            msg.send "#{k} - #{v}"
#          msg.send "blaat: #{json.d.results[0]}"
        catch error
          msg.send "ERROR"
#    results = JSON.parse content

#    unless results?
#      msg.send "No  results for \"#{query}\""
#      return

