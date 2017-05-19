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
            for tag in instance.Tags
              console.log "#{tag.Key}: #{tag.Value}" if tag.Key is "Name"
            console.log "State: #{instance.State.Name}"
            console.log "Platform: #{instance.Platform}" if instance.Platform?
            console.log "InstanceType: #{instance.InstanceType}"
            console.log "PublicDnsName: #{instance.PublicDnsName}" if PublicDnsName?
            console.log "PublicIpAddress: #{instance.PublicIpAddress}" if PublicIpAddress?
            console.log "PrivateDnsName: #{instance.PrivateDnsName}"
            console.log "PrivateIpAddress: #{instance.PrivateIpAddress}"
            console.log "----------------------------------"
            message = ""
            message += "----------------------------------" + '\n'
            message += "#{tag.Key}: #{tag.Value}" + '\n' if tag.Key is "Name"
            message += "State: #{instance.State.Name}" + '\n'
            message += "Platform: #{instance.Platform}" + '\n' if instance.Platform?
            message += "InstanceType: #{instance.InstanceType}" + '\n'
            message += "PublicDnsName: #{instance.PublicDnsName}" + '\n' if PublicDnsName?
            message += "PublicIpAddress: #{instance.PublicIpAddress}" + '\n' if PublicIpAddress?
            message += "PrivateDnsName: #{instance.PrivateDnsName}" + '\n'
            message += "PrivateIpAddress: #{instance.PrivateIpAddress}" + '\n'
            message += "----------------------------------"
            res.send message
