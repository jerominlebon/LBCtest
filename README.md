# LBCTest

This is the technical test for Leboncoin.
It is written is pure swift without any third parties libraries. The pattern used is **MVVM-C** and **Clean architecture**.

## Global

The app answers the main rules of the test and it is on iOS minimum target 14.0. 
No xibs or storyboards, only programmatical constraints.
I have written tests for different layers.
I have used a simple coordinator for navigation.
I used a swifty way to handle dependency injection with property wrapper.

## What is missing

- A better handling of the iPad
- A better UI: I preferred focusing on the code since I didn't have much time to write the test. I'm not really happy about it since focusing on UX / UI is what I prefer the most. Sorry for your eyes :)
- UI tests for two reasons: time and I don't really know that part that well
