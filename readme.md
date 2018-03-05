#My blog

## Important Commands
CMDURL: bundle exec jekyll serve 
CMDURL: bundle show minima

## Installation Stuff
* sudo apt-get install ruby
* sudo gem install jekyll bundler
* sudo gem install rubygems-update
* update_rubygems 
* gem update --system
* sudo apt-get install libroot-bindings-ruby-dev

## URLS
URL: https://jekyllrb.com/docs/quickstart/
URL: https://github.com/jekyll/minima
URL: https://rubygems.org/pages/download
URL: http://localhost:4000/humanreadable/
URL: http://mode19.github.io/humanreadable/

## Publishing 

1. checkout master branch - commit changes/push
2. re-build the jekyll site: jekyll clean build
3. checkout gh-pages
4. copy site from master branch: cp -r $MASTER_BRANCH_LOCATION/docs/_site/* .
5. commit gh-pages

## Notes/credits
https://www.liaohuqiu.net/posts/jekyll-plugins-on-github-pages/
https://michaelsoolee.com/google-analytics-jekyll/
