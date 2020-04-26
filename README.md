# GoodNews

After seeing John Krasinki's Some Good News, https://www.youtube.com/watch?v=F5pgG1M_h_U, we made an iOS app that curates only the positive news from a news api using a machine learning model. The motivation behind this app was the fact that many people are feeling down because of the quarantine. This app was made with hopes of bringing the spirits of people up and we will try to make the features even better in the future. This is just a MVP.

This model takes as input some text and outputs either "Pos", "Neg", or "Neutral." We imported this model into our iOS app and used it to only show the news with "Pos" as the label. Some challenges that we faced were trying to use PyTorch to train a stronger model but we weren't able to figure out how to import python code into swift, so we pivoted to use Apple's coreml framework. Some other challenges include that the original news api we were using stopped working, so we had to find a new one and use that instead.

This was a fun project that taught us a lot, and we hope that it can be inspiration for others to use their skills to bring joy to other people!

# Instructions

To use this app, you simply have to download the zip file and open it on your computer in a desired location. Then, open the white file called GoodNews.xcworkspace. Here, it will take a while for the project to build and index. As you are waiting, download an iOS simulator to run this app on. Then, click command+b and command+r to build and run this app on your virtual iPhone.

If this does not work, there may have been a problem with setting up the pods. Thus, you can try to run pod update in your terminal at the directory of which the Podfile is. You can also try to delete the Podfile.lock, Pods/, and GoodNews.xcworkspace files/directories and run pod install. Then open the newly created GoodNews.xcworkspace file and follow the previous instructions to run it!
