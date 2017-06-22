---
title: Blogdown and Trankquilpeak Theme Hosted on Netlify
date: '2017-06-20'
author: 'Bryan Whiting'
tags: ["tutorials", "blogdown"]
draft: no
---

This blog will outline what I see as differences between Hugo and Jekyll, some benefits and drawbacks of using Netlify vs. GitHub pages to host, and how to launch the Hugo Trankquilpeak theme from scratch.

## Why Hugo?

One of my first posts was about blogging with Jekyll hosted on GitHub. About six months after writing that post, I hit a few bugs trying to debug it and got frustrated because I had already forgotten all of what I binge-learned earlier. I was tired of re-updating my Jekyll code, and ultimately gave up since I didn't use it often enough. And so I switched to Hugo and blogdown. Here are the reasons why I've already switched from Jekyll to Hugo:

* Jekyll requires you to download and manage the software which caused me a lot of headaches and debugging. Blogdown manages all of the Hugo installations for you.
* I wanted to be able to use R Markdown in my blogs and Jekyll doesn't have a native integration. [Andrew Brooks has a solution](http://brooksandrew.github.io/simpleblog/articles/blogging-with-r-markdown-and-jekyll-using-knitr/) that allows you to use R Markdown and Jekyll, though I had trouble using it[^1].
* Netlify allows HTTPS for custom URLs, whereas GitHub only allows HTTPS for `username.github.io` pages (not custom URLs). Here's a discussion on [GitHub pages v. Netlify](https://bookdown.org/yihui/blogdown/github-pages.html).
* Configuring a custom URL on Netlify is extremely easy compared to GitHub pages. (If you don't use a custom URL, you won't like the one Netlify provides by default.)

[^1]:Alternatively, I could knit the R Markdown file to HTML and Jekyll could read the HTML file, but each R Markdown post ultimately had a different formatting than the normal markdown posts.

## Enter blogdown

`blogdown` is an R package that manages the Hugo software, which is a static website generator. Here's the [package on GitHub](https://github.com/rstudio/blogdown), which has a handy 5 min instruction to get your feet wet. Here's the [official tutorial on blogdown](https://bookdown.org/yihui/blogdown/) and is a great resource. 

You will spend some time getting to know blogdown and Hugo, and Hugo requires as much work figuring out as does Jekyll if you want to get into the gritty customization. That being said, blogdown makes it easy to get started and come back several months later without having to worry about managing all of the Jekyll packages.

A few things about blogdown and Hugo I've learned:

- Hugo is a static site generator (meaning it makes a very basic website)
- Hugo is software you download and run to build and compile your website
- blogdown is a wrapper for Hugo terminal commands
- blogdown renders R Markdown files (Hugo can't)
- blogdown automates installing everything you need for Hugo. (This was very difficult to do with Jekyll at first.) 
- blogdown runs the Hugo commands to compile your site locally
- `serve_site()` lets you edit your posts and view the changes simultaneously with every save
- `build_site()` prepares the site for production

## blogdown for Trankquilpeak theme

Every Hugo site is different, and each has a different config file. So I'll go step by step on how I launched my blog. 

### Launch your website in 5 minutes locally

1. Run `install_hugo()` to get the latest version. You may have to update Hugo periodically, as it's open source and keeps updating. So if you're having issues building your site, try debugging using `install_hugo(force = T)`.  
2. Run `new_site()` command to build a website from scratch. (Note, these two steps can save you hours of reading documentation if you go the Jekyll route.)
3. Make sure you [specify the theme](https://bookdown.org/yihui/blogdown/themes.html) you want, e.g. `new_site(theme = 'kakawait/hugo-tranquilpeak-theme')`, because it'll download the right `config.toml`. Here's a note from the docs:
 `...You need to be very careful when changing themes, because one theme can be drastically different with another theme in terms of the configurations. It is quite possible that a different theme will not work with your current config.toml. Again, you have to read the documentation of a theme to know what options are supported or required.`
3. Now the site is built, you'll see several folders. The github Hugo theme is saved in `themes`. The entire site is saved and compiled in `public`. And Blogdown and Hugo do the work of preparing your content and putting it in the `public` folder. Your posts are in `content`, and your images are in `static`.
4. To get started, put all your blogs in the `content/post`, and your site images in `static` and run `build_site()` when you're ready.
5. If you run `new_post()`, it'll create a post in `content/post`.

### Host your blog on Netlify

If you want to do GitHub pages, see [Tyler Clavelle's tutorial](https://tclavelle.github.io/blog/blogdown_github/), [Amber Thomas' tutorial](https://proquestionasker.github.io/blog/Making_Site/) or the [blogdown docs](https://bookdown.org/yihui/blogdown/github-pages.html). 

I cover here how to use Netlify to host, which is extremely easy! Here are the steps:

1. Put your entire site as a repository on GitHub, Gitlab, or Bitbucket. (I did GitHub.)
2. Go to [Netlify](https://www.netlify.com/). 
3. Connect your GitHub accounts. 
4. Click `New site from Git`.
4. Continuous deployment: click `GitHub`. You can limit access to only public repositories.
5. Click on your GitHub blog repo.
  1. Branch to deploy: `master`
  1. Build command: `hugo_0.19` ([See docs on build command](https://bookdown.org/yihui/blogdown/netlify.html))
  1. Publish directory: `public`
6. Click `Deploy site`. Netlify will generate a random URL `<netlify-name>.netlify.com`, like `destiny-jones-84018.netlify.com` and launch your site.

### Connecting your custom domain

Netlify makes it very easy, more straightforward than GitHub pages to connect your custom domain.

Go to `Settings > Configure domain`. Just add your custom domain in the space provided and update your [DNS configuration](https://www.netlify.com/docs/custom-domains/#dns-configuration). For some reason, this took me forever to figure out on Jekyll and GitHub pages (it seemed like everyone knew how to do this but me...).

### Encrypt with HTTPS

If you want, you can encrypt your site with HTTPS, as [Yihui recommends](https://bookdown.org/yihui/blogdown/github-pages.html). Once your site is deployed, you can click the `HTTPS` tab on Netlify and follow instructions. 

### Connecting Disqus

[Disqus](https://disqus.com/) is great for comments, but can be confusing to get set up. There are two parts - setting up a Disqus account and site and updating your Hugo `config.toml`.

Set things up on Disqus:

1. Go to [disqus.com](https://disqus.com/) and create a profile.
1. Click on `Admin` (or [www.disqus.com/admin](www.disqus.com/admin))
1. In the top left corner, click `Your sites` then  `+ New`
1. Under website name, just put something like "data science blog", or whatever you want to name it.
1. It'll now ask you to connect to a platform. Skip this and go to `3. Configure Disqus`.
1. You'll see your website name. Under `Website URL`, put the `http://<netlify-name>.netlify.com`. (I don't know if you can put your custom domain here, but for me putting my Netlify URL worked fine.)
1. Go to `Settings` and it'll provide the shortname. Copy that.

Set up `config.toml`:

1. Under baseurl I put my custom URL "https://www.bryanwhiting.com".

Note, Disqus won't work when you use `serve_site()` command. It only works on the live website.

### Change the background photo

This took me a minute to figure out, but I learned something about Hugo, so I'll share it here.

1. Put your desired photo in `static/images`.
2. Under `[author] picture = yourphoto.png'

You'll notice in the `public` folder, the `static` folder doesn't exist, but `images` does (after you `build_site()`).

## Takeaways and next steps

You've got a great blog ready to go! There are things I'd like to add to my Trankquilpeak site, such as a project page and a resume page. Perhaps if I get some time to read the Hugo docs I can figure out how to add static pages to the sidebar.
