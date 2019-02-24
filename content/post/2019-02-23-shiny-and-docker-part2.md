---
title: Getting Custom Domain for EC2 Web App - Part 2
author: ~
date: '2019-02-23'
slug: rshiny-on-docker-part2
categories: ['tutorials']
tags: ['r', 'shiny', 'aws', 'ec2', 'docker', 'webapps']
draft: false
---

In this post, I'll cover how to better customize some settings so to get your own custom domain for your EC2 instance. Say, `app.example.com`. Anyone interested in customizing an EC2 instance can use this - not just those who build R Shiny apps. I assume you already read [part 1], where it was described how to launch an R Shiny app on EC2. I assume you already have some EC2 instance running with some useful app. First I'll cover how to set up your custom domain. Then I'll dive into some security thoughts that I skipped in the first post.

[part 1]: https://www.bryanwhiting.com/2019/02/rshiny-on-docker-part1

## Adding Custom Domain

Following this [gist](https://gist.github.com/keithweaver/7f7de8a2499b3bcfafd7d753a9e3f699) and these [official AWS steps](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-ec2-instance.html), it takes 5 minutes to point your EC2 to a custom domain.

I assume you already have a domain name. If you don't, read this footnote[^1].

[^1]: If you're feeling risky, perhaps find a free one at http://www.dot.tk. I do not endorse this site, as I've seen some terrible reviews, but it does let you register domains for free. And it worked for this post. Just be sure to sign in with your junk email and not use any personal information.

1. I assume your EC2 instance is running, 
2. Log into AWS and go to https://console.aws.amazon.com/route53/.
2. Go to "hosted zones".
3. Click "create hosted zone".
4. In Domain name, enter just your domain `example.com` (don't do `www.example.com`).
5. Click "Create".
6. The hosted zone (which now has your name `example.com`) will have auto-populated record sets. Keep those, but ignore them. Click "Create Record Set".
7. Follow instructions in [official AWS steps](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-ec2-instance.html). Basically, 1) just supply the subdomain in `name`. Your `name` could be `app` for `app.example.com`. I assume this is what you want (you could also do `www`). But if `www` is already being used, then `app.` might be cool. 2) copy your EC2's Public IPv4 address (just the numbers, not the whole `ec2-18-111-123-123.us-east-2.compute.amazonaws.com`).
8. Once you create, you're done on AWS. Go to where your domain registrar (godaddy, dot.tk). 
9. Find where to edit your DNS (sometimes called DNS records.) 
10. For Host, add `app`. Use `Type A`. Target: the ec2's IPv4 address.
11. You're done!

See my shiny app live:

* Shiny Server Landing Page: http://www.shinyapps.ml/
* My Geyser App: http://www.shinyapps.ml/
* Sample Hello Shiny: http://www.shinyapps.ml/sample-apps/hello/
* Sample Shiny Doc: http://www.shinyapps.ml/sample-apps/rmd/ 

If it's not longer live by the time you read this (e.g., my EC2 instance died), here's proof I had it live at one point.

![](/img/20190219-rshinydocker/sampleapps.png)
![](/img/20190219-rshinydocker/sampleapps-hello.png)
![](/img/20190219-rshinydocker/shinydoc.png)
![](/img/20190219-rshinydocker/shinyapps-ml.png)

And your reaction might be `wait, that's at www.shinyapps.ml, not app.shinyapps.ml`. Nice catch. And well, the first time I did this post, I did it with `app`. Then I forgot to screen shot it. Then I got distracted and I wanted to see if I could get a free URL using dot.tk. And so the second time I just did `www.`. And now I'm too lazy to go back and try `app.shinyapps.ml` and re-do my screenshots. Is anyone even still listening at this point?...If not, I wrote this for myself anway. But really, it's the same instructions for `www.` as for `app.` Now for a conversation about security.

## Launching EC2 with Better Security

When I did [part 1] I got some mean warnings about security groups when I followed step 1 in setting up my EC2 instance. I don't like doomsday warnings that hackers will attack me, especially since cybersecurity isn't my strong suit. So I did some digging, and here's another approach you could take.

You might see some warnings about people being able to access your ec2 instance.

> *Warning.* If you use 0.0.0.0/0, you enable all IPv4 addresses to access your instance using SSH. If you use ::/0, you enable all IPv6 address to access your instance. This is acceptable for a short time in a test environment, but it's unsafe for production environments. In production, you authorize only a specific IP address or range of addresses to access your instance. [AWS documentaiton](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html)

For someone to ssh into your ec2 instance (and access the files), they [need your pem key](https://hackernoon.com/tutorial-creating-and-managing-a-node-js-server-on-aws-part-1-d67367ac5171). (Or, you have to [find a way](https://serverfault.com/questions/477488/can-i-ssh-into-my-amazon-ec2-server-instance-if-i-dont-have-pem-file-from-when) to let them in.) 

So how do you allow access to the outside world? This AWS tutorial answers the questions [I host a website on an EC2 instance. How do I allow my users to connect on HTTP (80) or HTTPS (443)?](https://aws.amazon.com/premiumsupport/knowledge-center/connect-http-https-ec2/).

When to use [TCP vs HTTP vs HTTPS](https://www.quora.com/What-is-the-difference-between-a-Custom-TCP-rule-and-a-HTTPS-rule-in-AWS-security-group-settings). [HTTP vs HTTPS?](https://seopressor.com/blog/http-vs-https/).

I'm no security expert, but based on the above, here's what I've done for my security group:

1. Enabled SSH via My IP.
2. Enabled HTTP with port 80, HTTPS with port 443.
3. Change your Docker command from `-p 3838:3838` to `-p 80:3838`, where the first number is the host port, and the second is the Docker container port. (`rocker/shiny` exposes port 3838. And the `shiny-server.conf` file used by shiny server defaults to 3838. Upload your own shiny-server.conf file if you want to change the default from 3838 to 80.)

```
docker run --rm -p 80:3838 -v $PWD/app:/srv/shiny-server/app -v $PWD/log/shinylog/:/var/log/shiny-server/ rocker/shiny
```
Then, when your users go to your URL, the browser will hide 80 by default.





