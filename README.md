# Coudal With Pictures

I've been a big fan of Coudal Partner's [Fresh Signals](http://www.coudal.com/) since forever. We are talking about the days of [Feed Demon](http://www.feeddemon.com/) and [Google Reader](https://www.google.com/reader/about/) (both RIP) here. But as life moved on and the unread count in Feedbin started to hit the 10,000 mark I knew something had to give. And I was determined that Fresh Signals was not going to be part of the cull.

Fresh Signals is a text only RSS feed which is both good and bad in the era of thumb-stopping content: there's no easy way to scan it. So in the interest of time management I hacked together some code that inserted an image into the feed as a reference to the post itself. And CP: Fresh Signals (With Pictures) was born.

The idea, and supporting code, is very rudimentary:

- Pull down the Fresh Signals feed every ten minutes and parse it.

- Grab the first URL link in the feed and hit the web page.

- Search for an [og:image](http://ogp.me/) tag on the page. If it exists then hotlink the image.

- Create a new RSS feed and insert the image, if it does exist, above the text.

- Push the feed to an Amazon S3 bucket.

- [Enjoy](http://kcdn.kripy.com/coudal/index.xml).

In no way to I want to detract from what Coudal Partners and Fresh Signals does. Straight up: I still subscribe to their feed. It was a fun hack and it gives me a visual representation of some of the finest links going round.

## MIT LICENSE

Copyright (c) 2016 Arturo Escartin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
