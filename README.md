# GoodNews

After seeing John Krasinki's Some Good News, https://www.youtube.com/watch?v=F5pgG1M_h_U, we made an iOS app that curates only the positive news from a news api using a machine learning model. The motivation behind this app was the fact that many people are feeling down because of the quarantine. This app was made with hopes of bringing the spirits of people up and we will try to make the features even better in the future. This is just a MVP.

This model takes as input some text and outputs either "Pos", "Neg", or "Neutral." We imported this model into our iOS app and used it to only show the news with "Pos" as the label. Some challenges that we faced were trying to use PyTorch to train a stronger model but we weren't able to figure out how to import python code into swift, so we pivoted to use Apple's coreml framework. Some other challenges include that the original news api we were using stopped working, so we had to find a new one and use that instead.

This was a fun project that taught us a lot, and we hope that it can be inspiration for others to use their skills to bring joy to other people!
