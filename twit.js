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

// 以下のキーは自分で取得して置換してください。
const tweeter = new Mtwitter({
    consumer_key       : 'xxxx',
    consumer_secret    : 'xxxx',
    access_token_key   : 'xxxx',
    access_token_secret: 'xxxx'
});

const tweeterUpdater = (status) => {
    tweeter.post(
        '/statuses/update',
        { status: status },
        (err, _item) => {
            if (err) {
                console.error('Error: ' + JSON.stringify(err));
                process.exit(-1);
            } else {
                console.log('Success: ' + status);
                process.exit(0);
            }
        }
    );
};

tweeterUpdater(process.argv[2]);
