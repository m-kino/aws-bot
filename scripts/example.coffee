# Description:
#   お天気bot
#
# Usage:
#   天気　#{都市}
#   ※#{都市}には以下が対応。
#   東京、神奈川、千葉、埼玉
#

module.exports = (robot) ->

  robot.respond /天気　(.*)/i, (res) ->
  
    city = res.match[1]
    cityCode = ""
    if (city is "東京") or (city is "とうきょう")
      cityCode = "130010"
    else if (city is "神奈川") or (city is "かながわ") or (city is "横浜") or (city is "よこはま")
      cityCode = "140010"
    else if (city is "千葉") or (city is "ちば")
      cityCode = "120010"
    else if (city is "埼玉") or (city is "さいたま")
      cityCode = "110010"
    else
      res.reply "首都圏以外は分かんないよ。"

    request = res.http('http://weather.livedoor.com/forecast/webservice/json/v1').query(city: cityCode).get()
    request (err, response, body) ->
      result = JSON.parse(body)
      if err
        console.log err, err.stack
        res.reply "お天気情報が取得できませんでした。"
      else
        console.log result.title
        console.log "---------------------------------"
        for forecast in result.forecasts
          console.log "#{forecast.dateLabel}：#{forecast.telop}"
#          console.log "最低気温：#{forecast.temperature.min}　/ 最高気温：#{forecast.temperature.max}"
        console.log "---------------------------------"
        console.log result.description.text
        console.log "---------------------------------"
        message = ""
        message += result.title + "\n"
        message += "---------------------------------" + "\n"
        for forecast in result.forecasts
          message += "#{forecast.dateLabel} : #{forecast.telop}" + "\n"
        message += "---------------------------------" + "\n"
        message += result.description.text + "\n"
        message += "---------------------------------"
        res.send message
