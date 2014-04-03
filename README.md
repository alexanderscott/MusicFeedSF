# MusicFeedSF
Hot off the easel: the latest art buzz & events in the Bay Area. Go get your art on.


## Details
Source code for [MusicFeedSF](http://artfeedsf.com)
Feed aggregator containing self-updating:
 * Tweets (Twitter REST API)
 * Events (Eventbrite API)
 * News (RSS Feeds)


## Install & Run
Create an app on the [Twitter Developers](https://dev.twitter.com/) website and grant OAuth access to your account.
Register an app with Eventbrite to receive an API key.

Clone this repo and update the `config/environment.yml` (included but blank) with your Twitter & Eventbrite app access info. 

     $ bundle install
     # rake rails:update:bin
     $ bundle exec rake assets:precompile
     $ rails s -p 3000


## TODO
* Music & Concert integration
* Write tests


## License
The MIT License (MIT)

Copyright (c) 2014 Alex Ehrnschwender

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
