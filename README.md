gh-deploy
=========

A small library to deploy static pages to GitHub

## Installation

  npm install -g gh-deploy

## Usage

```
gh-deploy reponame username password
```

* **reponame** - name of the github repository. Defines the page URL
* **username** - GitHub username
* **password** - GitHub password

### Page URL

GitHub offers two options for page URLs:

* http://*username*.github.io - use *username*.github.io as the **reponame**
* http://*username*.github.io/*reponame* - use any other **reponame**

## Release History

* 0.1.0 Initial release
