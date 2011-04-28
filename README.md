Install
-------
     1) git clone git@github.com:Schneems/Potential-Friend-Finder.git
     2) cd Potential-Friend-Finder
     2.1) # if you don't have homebrew install it   https://github.com/mxcl/homebrew/wiki/installation
     2.2) # if you don't have imagemagick brew install imagemagick
     3) bundle install
     4) rails s

Note: requires memcache and redis

Use
---
Navigate to [http://localhost:3000](http://localhost:3000) on your computer. Create an admin account, this will allow you to add 'users' to your mini-social network. Once you have users, you can make friends, and observe what our potential friends our algorithm suggests.


About
-----
Video: [vimeo](http://www.vimeo.com/22997846)
Presentation: [slideshare](http://www.slideshare.net/thinkbohemian/potential-friend-finder)
Potential friend finder is a demo app for a simple version of the _People You May Know Algorithm_ used on [Gowalla](http://gowalla.com). You can check out the real-algorithm in-action on the web by signing up for a [Gowalla](http://gowalla.com) account and adding friends. For more information please check out the source code, and watch the attached video and presentation

Please fork this project, and see if you can come up with improvements to the algorithm. If you want me to pull your fork later, please make your changes on a branch, and give the user some way to toggle between your algorithm and the original algorithm.

If you want to contribute and you need to reach me, you can find me on the twitters @schneems

Also want to give a shout out to @mattt for clueing me into friends-of-a-friend graph theor...he is awesome. 

Copyright (c) 2011 Schneems
