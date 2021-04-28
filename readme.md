#My blog

## Important Commands
CMDURL: bundle exec jekyll serve 
bundle exec jekyll serve --host 0.0.0.0 
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

## Building/Publishing 

1. checkout master branch - commit changes/push
2. re-build the jekyll site: 
        jekyll clean
        JEKYLL_ENV=production jekyll build
3. checkout gh-pages
4. copy site from master branch: cp -r $MASTER_BRANCH_LOCATION/docs/_site/* .
5. commit gh-pages

## Notes/credits
https://www.liaohuqiu.net/posts/jekyll-plugins-on-github-pages/
https://michaelsoolee.com/google-analytics-jekyll/

~/.tmux.conf" 21L, 747C

# remap prefix to Control + a
set -g prefix C-a
# bind 'C-a C-a' to type 'C-a'
bind C-a send-prefix
unbind C-b

set-window-option -g mode-keys vi
set-option -g history-limit 10000

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

#bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
#bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
#bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
#bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
#bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"


bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

~/.ackrc

--ignore-dir=dist
--ignore-dir=.idea
--ignore-dir=target
--ignore-dir=bower_components
--ignore-dir=vendor
--ignore-dir=coverage
--type-set=jrunner:ext:java,xhtml,html,sh,properties,xml



#!/bin/bash

set -e
echo "ok"
test 1 == 1
echo "ok"
test 1 == 2
echo "ok"
test 1 == 1





