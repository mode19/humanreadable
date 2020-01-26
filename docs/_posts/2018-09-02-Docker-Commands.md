---
layout: post
title:  "Some Docker Commands"
date:   2018-09-03
categories: vim, unix
---

## Some Docker Commands

Start a new or exisitng container

    docker start <containerid>
    docker attach <containerid> - attach console

Run a command in running container:

    
    docker exec -it <containerid> /bin/bash

Save changes to an image (from a running container) (create a new image (or tag))

    sudo docker commit -m "install stuff" <container name or ID> <new-image-name>[:<tag>]

Run a new container based on a image

    sudo docker run -v $PWD/docs:/mydocs -p 4000:4000 --name MyUbuntuXenialRepo -it myubuntuxenialimage bash

