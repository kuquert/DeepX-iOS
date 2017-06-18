# DeepX-iOS
This repo is the solution for de [code-challange](https://github.com/BearchInc/code-challenge/blob/master/challenge1.md) proposed by DeepX.

## Setup

this project uses [Carthage](https://github.com/Carthage/Carthage)<sup>*</sup>, to instal dependencies run 
```
$ carthage bootstrap --platform iOS
```
<sup>*I decided to not include de Carthage/ folder on source control to get smaller repo size and don`t have trash commints from libreries update.</sup>

## GitHub
To work with github API a github application was needed to have a higher limit rate for the chained requests.

|Resource | No Auth(requests/hour) | Auth(requests/hour) |
| --- | --- | --- |
|core	| 60 	| 5000	|
|search	| 10 	| 30	|
|graphql| 0 	| 5000	|
|rate	| 60 	| 5000	|

## Info
 
This project uses the icons from this [file-icons](https://github.com/file-icons/source), they only have .svg files available. The .svg files were than converted to .pdf using [caisosvg](http://cairosvg.org/) converter.:D

The app icon was made using [Sketch](https://www.sketchapp.com/) app, and its included on the repositorie.
