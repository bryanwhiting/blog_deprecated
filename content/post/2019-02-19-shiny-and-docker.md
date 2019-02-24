---
title: R Shiny on AWS Using Docker - Part 1
author: ~
date: '2019-02-19'
slug: rshiny-on-docker-part1
categories: ['tutorials']
tags: ['r', 'shiny', 'aws', 'ec2', 'docker', 'webapps']
draft: false
---

I want to run R Shiny on AWS using Docker. Here's how to do it. 

In [part 2], I'll demonstrate how to get a custom domain and make the URL look clean.

## Useful background reading
If you're already comfortable with Docker, skip to the next section.

1. [Great Simple tutorial on using Docker and Flask](https://hackaday.com/2018/09/05/intro-to-docker-why-and-how-to-use-containers-on-any-system/): Short and sweet. 
1. [Docker for Beginners](https://docker-curriculum.com/): Verbose and lengthy. Excellent introduction. Walks you through all the jargon. Well written. Teaches how to use AWS.
1. [Using Docker and Shiny](https://www.bjoern-hartmann.de/post/learn-how-to-dockerize-a-shinyapp-in-7-steps/): This person builds their own Shiny image on top of base R. Teaches you how to publish an R Shiny docker app without using DockerHub. Doesn't teach AWS integration.
1. [rocker/shiny](https://hub.docker.com/r/rocker/shiny/) on DockerHub: a pre-defined Docker image that runs Shiny directly.
1. [stackoverflow on how to use rocker/shiny](https://stackoverflow.com/questions/44406631/deploy-shiny-app-in-rocker-shiny-docker): Misses a few key concepts, which I'll clarify.
1. [copy vs add on docker](https://nickjanetakis.com/blog/docker-tip-2-the-difference-between-copy-and-add-in-a-dockerile): fyi
1. [launching google cloud with shiny docker](https://cloudyr.github.io/googleComputeEngineR/articles/shiny-app.html)
1. [launching shiny apps on aws - Ger Inberg](https://gerinberg.com/2017/04/12/deploying-shiny-apps-on-aws-using-docker/)

## Test Docker Locally
Piecing these readings together, I realized that `rocker/shiny` is all you need to launch a Shiny app. (If you need to install your own packages, you'll need to create your own Dockerfile/image. But for a very basic app, `rocker/shiny` is all you need.) These steps might not work with your work's proxy. How to launch a Shiny app using Docker:

* Download Docker for Mac.
* package your R shiny app into a folder, let's call it `/app`
* cd into the directory _above_ where `/app` lives. E.g., cd into `somedir`.

```
somedir
|--app
  |--ui.R
  |--server.R
```

* Run the following command:
```
docker run --rm -p 3838:3838 -v $PWD/app:/srv/shiny-server/ -v $PWD/log/shinylog/:/var/log/shiny-server/ rocker/shiny
```
* Go to `localhost:3838` in your browser and see your app. Have fun!
* Stop your container: `docker kill $(docker ps -q)`
* Your directory `somedir` will now have a new log file:

```
somedir
|--app
  |--ui.R
  |--server.R
|--log
  |--app-shiny-20190221-020457...
```

## What the command is doing

Let's break down this command:
```
docker run --rm -p 3838:3838 -v $PWD/app:/srv/shiny-server/ -v $PWD/log/shinylog/:/var/log/shiny-server/ rocker/shiny
```

* `docker run ... rocker/shiny` will pull the `rocker/shiny` image from Dockerhub and launch it.
* `-rm` will tear down the image after the instances is destroyed, making the image temporary. 
* `-p 3838:3838` will expose the Docker port 3838 to your localhost:3838. 
* `-v $PWD/app:/srv/shiny-server/` will mount your directory `app` (that's in your present working directory) to Docker's directory `/srv/shiny-server/`. 
* `-v $PWD/log/shinylog/:/var/log/shiny-server/` will create a new directory called `/log/shinylog` in your present working directory and mount it to Docker's `/var/log/shiny-server`. This will enable log files to be read back to your host directory that are being created inside of Docker as you interact with the app.

I chose to use Docker's mounting in this example. If you don't mount, you could copy the app into the Docker image using a Dockerfile. Mounting lets Docker read directly from the host OS. If you choose not to mount and instead copy `/app` into the Docker image, then you could just package the entire Docker image up to Dockerhub. See [this tutorial on how to do that](https://www.bjoern-hartmann.de/post/learn-how-to-dockerize-a-shinyapp-in-7-steps/).

# Multiple apps on same docker container

If you change the mount to `$PWD/app:/srv/shiny-server/app`, as in the following:

```
docker run --rm -p 3838:3838 -v $PWD/app:/srv/shiny-server/app -v $PWD/log/shinylog/:/var/log/shiny-server/ rocker/shiny
```
Then when you go to `localhost:3838` you'll see the Shiny Server landing page. Then you can travel to `localhost:3838/app` to see your app live. Adding mounts would allow you to have multiple apps in the same Docker container.

# AWS EC2

1. Create Ubuntu AWS instance as listed in step 1 here: [TowardsDataScience](https://towardsdatascience.com/how-to-host-a-r-shiny-app-on-aws-cloud-in-7-simple-steps-5595e7885722). I did ubuntu image.
2. ssh in using pem key, following instnrucitons [here](https://medium.com/@GalarnykMichael/aws-ec2-part-2-ssh-into-ec2-instance-c7879d47b6b2). Basically, `ssh -i /path/to/key.pem ubuntu@PUBLICDNS` ec2-18-111-123-123.us-east-2.compute.amazonaws.com
1. `sudo -i`
1. `snap install docker`
1. ` docker pull rocker/shiny` (takes a few minutes)
1. `mkdir app`
1. `vim app/app.R` and copy in your app. (Git clone it, upload, stp, whatever. Just get your app into the `~/app/` folder. Get your data where it needs to be, too.)
1. `sudo docker run --rm -p 3838:3838 -v $PWD/app:/srv/shiny-server/app -v $PWD/log/shinylog/:/var/log/shiny-server/ rocker/shiny`

Now go to `ec2-18-111-123-123.us-east-2.compute.amazonaws.com:3838/app` to view your app. That's it!

Here I have mine hosted at 443 (not 3838), which I'll explore in [part 2].

![](/img/20190219-rshinydocker/ec2-443.png)

Next: For tips on how to convert that beastly URL into a custom domain (and hide the 3838 port number), see [part 2].

[part 2]: https://www.bryanwhiting.com/2019/02/rshiny-on-docker-part2

