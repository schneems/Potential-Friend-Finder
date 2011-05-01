About
-----

Potential friend finder is a demo app for a simple version of the _People You May Know Algorithm_ used on [Gowalla](http://gowalla.com). You can check out the real-algorithm in-action on the web by signing up for a [Gowalla](http://gowalla.com) account and adding friends. For more information please check out the source code, and watch the attached video and presentation

Screencast of the presentation on: [Vimeo](http://www.vimeo.com/22997846)

Slides of the presentation: [How Richard Found Friends (Slideshare)](http://www.slideshare.net/thinkbohemian/potential-friend-finder)


Install
-------
     1) git clone git@github.com:Schneems/Potential-Friend-Finder.git
     2) cd Potential-Friend-Finder
       2.1) # if you don't have homebrew install it homebrew   https://github.com/mxcl/homebrew/wiki/installation
       2.2) brew install imagemagick # if you don't have imagemagick 
     3) bundle install
     4) rails server

Note: requires memcache and redis. I recommend using [RVM](https://rvm.beginrescueend.com/) to manage your Rubies. 

Use
---
Navigate to [http://localhost:3000](http://localhost:3000) on your computer. Create an admin account, this will allow you to add 'users' to your mini-social network. Once you have users, you can make friends, and observe what our potential friends algorithm suggests.


Contribute
----------
Please fork this project, and see if you can come up with improvements to the algorithm. If you want me to pull your fork later, please make your changes on a branch, and give the user some way to toggle between your algorithm and the original algorithm. Putting all your methods in a module and extending user.rb would be an easy way to accomplish this

If you want to contribute and you need to reach me, you can find me on the twitters [@Schneems](http://twitter.com/schneems)

Also want to give a shout out to [@mattt](http://twitter.com/mattt) ([Mattt on Github](http://github.com/mattt)) for clueing me into friends-of-a-friend graph theory...he is awesome.

Copyright (c) 2011 Schneems

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
