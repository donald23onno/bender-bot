# Description:
#   Reads info from RDW for license plate info
#
# Commands:
#   hubot kentenen <query> - Searches RDW oData for kentenen info
module.exports = (robot) ->
  robot.respond /(kenteken|ktk)/i, (msg) ->
    query = msg.match[2]
    query.replace /-/, ""
    robot.http(" https://api.datamarket.azure.com/opendata.rdw/VRTG.Open.Data/v1/KENT_VRTG_O_DAT?$format=json&$filter=Kenteken%20eq%20%27#{query}%27")
      .query({
        'max-results': 1
        alt: 'json'
        q: query
      })
      .get() (err, res, body) ->
        videos = JSON.parse(body)

        unless videos?
          msg.send "No video results for \"#{query}\""
          return

        video  = msg.random videos
        video.link.forEach (link) ->
          if link.rel is "alternate" and link.type is "text/html"
            msg.send link.href

