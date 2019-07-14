//====================================================//
//                                                    //
//         Copyright (c) 2019 K, Kijinosippo          //
//                                                    //
//    This code is released under the MIT License.    //
//   http://opensource.org/licenses/mit-license.php   //
//                                                    //
//====================================================//
'use strict';

const Mtwitter = require('mtwitter');

const tweeter = new Mtwitter({
    consumer_key       : xxxx,
    consumer_secret    : xxxx,
    access_token_key   : xxxx,
    access_token_secret: xxxx
});

const tweeterUpdater = (status) => {
    tweeter.post(
        '/statuses/update',
        { status: status },
        (err, _item) => {
            if (err) {
                console.error('[Tweeter] Error: ' + JSON.stringify(err));
            } else {
                console.log('[Tweeter] Updated: ' + status);
            }
        }
    );
};

tweeterUpdater(process.argv[2]);
