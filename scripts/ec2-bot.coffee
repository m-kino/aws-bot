# Description:
#   AWSサーバ情報取得用bot
#

AWS = require('aws-sdk');

module.exports = (robot) ->

  robot.respond /サーバ情報/i, (res) ->
    
    AWS.config.update {region: 'ap-northeast-1'}
    ec2 = new AWS.EC2()

    ec2.describeInstances (err,data) ->
    
      if err
        console.log err, err.stack
      else
        for reservation in data.Reservations
          for instance in reservation.Instances
            console.log "----------------------------------"
            console.log "PublicDnsName: #{instance.PublicDnsName}"
            console.log "State: #{instance.State.Name}"
            console.log "PublicIpAddress: #{instance.PublicIpAddress}"
            console.log "PrivateIpAddress: #{instance.PrivateIpAddress}"
            console.log "PrivateDnsName: #{instance.PrivateDnsName}"
            console.log "InstanceType: #{instance.InstanceType}"
            console.log "Platform: #{instance.Platform}"
            for tag in instance.Tags
              console.log "#{tag.Key}: #{tag.Value}" if tag.Key is "Name"
            console.log "----------------------------------"
            message = ""
            message += "----------------------------------" + '\n'
            message += "PublicDnsName: #{instance.PublicDnsName}" + '\n'
            message += "State: #{instance.State.Name}" + '\n'
            message += "PublicIpAddress: #{instance.PublicIpAddress}" + '\n'
            message += "PrivateIpAddress: #{instance.PrivateIpAddress}" + '\n'
            message += "PrivateDnsName: #{instance.PrivateDnsName}" + '\n'
            message += "InstanceType: #{instance.InstanceType}" + '\n'
            message += "Platform: #{instance.Platform}" + '\n'
            message += "#{tag.Key}: #{tag.Value}" + '\n'
            message += "----------------------------------"
            res.send message
