/**
 * Created by masatomix on 2017/04/24.
 * Masatomi KINO <kino@primebrains.co.jp>
 */

"use strict";

const AWS = require('aws-sdk');

module.exports.describeInstances = function (options, callback) {

    const ec2 = new AWS.EC2(options);
    ec2.describeInstances((err, data) => {
        if (err) {
            console.log(err, err.stack);
        } else {
            for (var index = 0; index < data.Reservations.length; index++) {
                // var instances = data.Reservations[index].Instances;
                data.Reservations[index].Instances.forEach(
                    function (instance) {
                        // console.log("PublicDnsName: " + instance.PublicDnsName);
                        // console.log("State: " + JSON.stringify(instance.State));
                        // console.log("PublicIpAddress: " + instance.PublicIpAddress);
                        // console.log("PrivateIpAddress: " + instance.PrivateIpAddress);
                        // console.log("PrivateDnsName: " + instance.PrivateDnsName);
                        callback(instance);
                    }
                );
            }
        }
    });
};
