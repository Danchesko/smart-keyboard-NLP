Smart Keyboard. N-gram word prediction.
========================================================
author: Dan Berd
date: 07.10.2018
autosize: true

Data Science Capstone Project. Final Presentation
---

Introduction
========================================================

The very last project of Data Science Specialization was aimed to understand new field - Natural Language Processing. We had several task to accomplish:

- Getting and Cleaning Data
- Exploritatry Data Analysis
- Modelling
- Creating and Shiny.io application
- Making a presentation

So, now when everything is done, is time for last task - the presentation.

About the application
========================================================

Prediction algorithm uses n-gram language model built by these RStudio libraries:


```r
library(tm)
library(RWeka)
```
The application itself, is not that sophisticated, but very efficient, it doesn't use any timeconsuming techniques, it just works with term-document matrices already created before. 

Language model were built on data from corpus HC Corpora and external data sets for profanity filtering.

Algorithm of the application
========================================================

Smart-keyboard application implements the following logic:

1. App is reading the input reactively, so it doesn't need any submit buttons.
2. Preprocessing input (lowering case, remove punctuation, trim white spaces, etc.)
3. Analyzing all possible endings (among 2- , 3- and 4-grams)
4. Backing of to the lower-grams if nothing was found
5. If nothing found - the most common unigrams “the”, 'and', 'for' will be shown.

Where to see
========================================================

You can see the application here:
https://danchesko.shinyapps.io/smart_keyboard_NLP/
