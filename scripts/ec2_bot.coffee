# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
#
#
# Commands:
#   hubot サーバ情報 - サーバ情報を返します。。
#
# Author:
#   Masatomi KINO <kino@primebrains.co.jp>

AWS = require 'aws-sdk'
#config = require 'config'
utils = require '../utils.js'

module.exports = (robot) ->


  robot.respond /(サーバ情報)/i, (res) ->

#    設定ファイルから情報取得
#    AWS.config.loadFromPath('./config/config.json');
#    AWSのCredentialsファイルから情報取得
#    credentials = new AWS.SharedIniFileCredentials {profile: 'default'}
#    AWS.config.credentials = credentials

    utils.describeInstances {
      region: 'us-west-2'
    },
      (instance) ->
        message = "----\n"
        message += "InstanceId: " + instance.InstanceId + '\n'
        message += "PublicDnsName: " + instance.PublicDnsName + '\n'
        message += "PublicIpAddress: " + instance.PublicIpAddress + '\n'
        message += "State: " + instance.State.Name + '\n'
        message += "----\n"
        res.send message


    utils.describeInstances {
      region: 'ap-northeast-1'
    },
      (instance) ->
        message = "----\n"
        message += "InstanceId: " + instance.InstanceId + '\n'
        message += "PublicDnsName: " + instance.PublicDnsName + '\n'
        message += "PublicIpAddress: " + instance.PublicIpAddress + '\n'
        message += "State: " + instance.State.Name + '\n'
        message += "----\n"
        res.send message



